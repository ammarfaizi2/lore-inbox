Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUKMTKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUKMTKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUKMTKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:10:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261153AbUKMTKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:10:30 -0500
Date: Sat, 13 Nov 2004 13:24:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrey Melnikoff <temnota+news@kmv.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-rc3
Message-ID: <20041113152450.GA28226@logos.cnet>
References: <20041112180052.GE23215@logos.cnet> <20041113162709.GX24130@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113162709.GX24130@kmv.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 07:27:09PM +0300, Andrey Melnikoff wrote:
> In article <20041112180052.GE23215@logos.cnet> you wrote:
> > Hi,
> 
> > Here goes the third release candidate.
> 
> > It contains a v2.6 backport of the binfmt_elf potential vulnerabilities
> > disclosed this week, an enhanced smbfs client overflow fix, an ACPI update
> > fixing a couple of nasty bugs, a NFS client bugfix and a network update
> > from Davem.
> 
> Any chance to apply this patch before release?
> 
> Prevent NMI oopser kill kernel thread when megearid2 driver wating abort or
> reset command completion. 

Hi Andrey,

I talked to Atul and Arjan about this one - the correct thing to do is to 
replace mdelay() with CPU yielding msleep(). 

We should backport msleep() in 2.4.29-pre1. 


> Signed-off-by: Andrey Melnikov <temnota+kernel@kmv.ru>
> 
> --- linux-2.4.28-rc3/drivers/scsi/megaraid2.c~	Thu Nov 11 19:37:13 2004
> +++ linux-2.4.28-rc3/drivers/scsi/megaraid2.c	Sat Nov 13 19:20:23 2004
> @@ -39,6 +39,7 @@
>  #include <linux/reboot.h>
>  #include <linux/module.h>
>  #include <linux/list.h>
> +#include <linux/nmi.h>
>  
>  #include "sd.h"
>  #include "scsi.h"
> @@ -2820,6 +2821,7 @@
>  
>  		if( iter++ < MBOX_ABORT_SLEEP*1000 ) {
>  			mdelay(1);
> +			touch_nmi_watchdog();
>  		}
>  		else {
>  			printk(KERN_WARNING
> @@ -2900,6 +2902,7 @@
>  
>  		if( iter++ < MBOX_RESET_SLEEP*1000 ) {
>  			mdelay(1);
> +			touch_nmi_watchdog();
>  		}
>  		else {
>  			printk(KERN_WARNING
> 
> 
> -- 
>  Best regards, TEMHOTA-RIPN aka MJA13-RIPE
>  System Administrator. mailto:temnota@kmv.ru
