Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVCBHQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVCBHQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVCBHQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:16:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:63942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262206AbVCBHQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:16:57 -0500
Subject: Re: [PATCH] fix module paramater permissions in radeon_base.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302071147.GA29444@kroah.com>
References: <20050302071147.GA29444@kroah.com>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 18:14:37 +1100
Message-Id: <1109747677.5610.94.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 23:11 -0800, Greg KH wrote:
> You really don't want -2 for the file mode in sysfs.  It creates:
>   -rwsrwsrwT  1 root root 4096 Mar  1 22:59 /sys/module/radeonfb/parameters/default_dynclk
> 
> on my box.  Here's a fix against a clean 2.6.11-rc5 kernel, please
> forward onward as you see fit.
> 
> 
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> 
> --- 1.27/drivers/video/aty/radeon_base.c	2005-02-24 11:40:00 -08:00
> +++ edited/drivers/video/aty/radeon_base.c	2005-03-01 23:09:12 -08:00
> @@ -2551,7 +2551,7 @@
>  MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
>  MODULE_LICENSE("GPL");
>  module_param(noaccel, bool, 0);
> -module_param(default_dynclk, int, -2);
> +module_param(default_dynclk, int, 0);
>  MODULE_PARM_DESC(default_dynclk, "int: -2=enable on mobility only,-1=do not change,0=off,1=on");
>  MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
>  module_param(nomodeset, bool, 0);

Right, that is bogus, thanks.

Ben.



