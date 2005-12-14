Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVLNVeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVLNVeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVLNVeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:34:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58872 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964988AbVLNVeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:34:06 -0500
Message-ID: <43A08FCD.2060501@mvista.com>
Date: Wed, 14 Dec 2005 15:34:05 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-6mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Galtieri <pgaltieri@mvista.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: IPMI panic
References: <1134595930.32485.1.camel@playin.mvista.com>
In-Reply-To: <1134595930.32485.1.camel@playin.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, there is an error patch that can get here with those values set to
NULL.

Thanks, Paolo.

-Corey

Paolo Galtieri wrote:

>Oops,
>  brain fade - forgot the Signed-of-by.  Resent as requested
>by Corey Minyard.
>
>Folks,
>  while doing some testing I discovered that if the BIOS on a
>board does not properly setup the DMI information it leads to 
>a panic in the IPMI code.  The panic is due to dereferencing 
>a pointer which is not initialized.  The pointer is initialized
>in port_setup() and/or mem_setup() and used in init_one_smi() and
>cleanup_one_si(), however if either port_setup() or mem_setup()
>return ENODEV the pointer does not get initialized.  The patch
>is below done against 2.6.15-rc5-git4
>
>Paolo
>
>Signed-off-by: Paolo Galtieri <pgaltieri@mvista.com>
>
>--- linux-2.6.15-rc5/drivers/char/ipmi/ipmi_si_intf.c	2005-12-05
>10:02:56.000000000 -0700
>+++ new-linux-2.6.15-rc5/drivers/char/ipmi/ipmi_si_intf.c	2005-12-14
>13:57:02.000000000 -0700
>@@ -2399,7 +2399,8 @@
> 			new_smi->handlers->cleanup(new_smi->si_sm);
> 		kfree(new_smi->si_sm);
> 	}
>-	new_smi->io_cleanup(new_smi);
>+	if (new_smi->io_cleanup)
>+		new_smi->io_cleanup(new_smi);
> 
> 	return rv;
> }
>@@ -2518,7 +2519,8 @@
> 
> 	kfree(to_clean->si_sm);
> 
>-	to_clean->io_cleanup(to_clean);
>+	if (to_clean->io_cleanup)
>+		to_clean->io_cleanup(to_clean);
> }
> 
> static __exit void cleanup_ipmi_si(void)
>
>
>  
>

