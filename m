Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWHVJHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWHVJHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHVJHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:07:42 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:42126 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750803AbWHVJHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:07:41 -0400
Message-ID: <44EAC874.7040102@s5r6.in-berlin.de>
Date: Tue, 22 Aug 2006 11:03:48 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, scjody@modernduck.com,
       bcollins@ubuntu.com, benh@kernel.crashing.org, obiwan@mailmij.org
Subject: Re: [patch 20/20] 1394: fix for recently added firewire patch that
 breaks things on ppc
References: <20060821183818.155091391@quad.kroah.org> <20060821184831.GV21938@kroah.com>
In-Reply-To: <20060821184831.GV21938@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Danny Tholen <obiwan@mailmij.org>
> 
> Recently a patch was added for preliminary suspend/resume handling on
> !PPC_PMAC.  However, this broke both suspend and firewire on powerpc
> because it saves the pci state after the device has already been disabled.
> 
> This moves the save state to before the pmac specific code.
> 
> Signed-off-by: Danny Tholen <obiwan@mailmij.org>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Ben Collins <bcollins@ubuntu.com>
> Cc: Jody McIntyre <scjody@modernduck.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/ieee1394/ohci1394.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17.9.orig/drivers/ieee1394/ohci1394.c
> +++ linux-2.6.17.9/drivers/ieee1394/ohci1394.c
> @@ -3548,6 +3548,8 @@ static int ohci1394_pci_resume (struct p
>  
>  static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
>  {
> +	pci_save_state(pdev);
> +
>  #ifdef CONFIG_PPC_PMAC
>  	if (machine_is(powermac)) {
>  		struct device_node *of_node;
> @@ -3559,8 +3561,6 @@ static int ohci1394_pci_suspend (struct 
>  	}
>  #endif
>  
> -	pci_save_state(pdev);
> -
>  	return 0;
>  }
>  
> 
> --


-- 
Stefan Richter
-=====-=-==- =--- =-==-
http://arcgraph.de/sr/
