Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVASTTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVASTTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVASTTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:19:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39562 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261857AbVASTS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:18:57 -0500
Date: Wed, 19 Jan 2005 13:56:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: megaraid2.c PATCH (was: Linux 2.4.28-rc3)
Message-ID: <20050119155644.GI2240@logos.cnet>
References: <20041112180052.GE23215@logos.cnet> <20041113162709.GX24130@kmv.ru> <20041113152450.GA28226@logos.cnet> <20050119175015.GG12843@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119175015.GG12843@kmv.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 08:50:16PM +0300, Andrey J. Melnikoff (TEMHOTA) wrote:
> Hi Marcelo Tosatti!
>  On Sat, Nov 13, 2004 at 01:24:50PM -0200, Marcelo Tosatti wrote next:
> 
> > On Sat, Nov 13, 2004 at 07:27:09PM +0300, Andrey Melnikoff wrote:
> > > In article <20041112180052.GE23215@logos.cnet> you wrote:
> > > > Hi,
> > > 
> > > > Here goes the third release candidate.
> > > 
> > > > It contains a v2.6 backport of the binfmt_elf potential vulnerabilities
> > > > disclosed this week, an enhanced smbfs client overflow fix, an ACPI update
> > > > fixing a couple of nasty bugs, a NFS client bugfix and a network update
> > > > from Davem.
> > > 
> > > Any chance to apply this patch before release?
> > > 
> > > Prevent NMI oopser kill kernel thread when megearid2 driver wating abort or
> > > reset command completion. 
> > 
> > I talked to Atul and Arjan about this one - the correct thing to do is to 
> > replace mdelay() with CPU yielding msleep(). 
> > 
> > We should backport msleep() in 2.4.29-pre1. 
> 
> Ok, msleep() backported, but driver isn't fixed. This patch acceptable?
> 
> Prevent NMI oopser kill kernel thread when megearid2 driver wating 
> abort or reset command completion. 

The megaraid maintainers seem to have an scheduled driver update but they
have taken too long.

Patch applied, thanks.

> Signed-off-by: Andrey Melnikov <temnota+kernel@kmv.ru>
> 
> --- linux-2.4.29/drivers/scsi/megaraid2.c~	Wed Jan 19 20:39:04 2005
> +++ linux-2.4.29/drivers/scsi/megaraid2.c	Wed Jan 19 20:44:21 2005
> @@ -2819,7 +2819,7 @@
>  		}
>  
>  		if( iter++ < MBOX_ABORT_SLEEP*1000 ) {
> -			mdelay(1);
> +			msleep(1);
>  		}
>  		else {
>  			printk(KERN_WARNING
> @@ -2899,7 +2899,7 @@
>  		}
>  
>  		if( iter++ < MBOX_RESET_SLEEP*1000 ) {
> -			mdelay(1);
> +			msleep(1);
>  		}
>  		else {
>  			printk(KERN_WARNING
> @@ -4040,10 +4040,10 @@
>  	printk(KERN_INFO "megaraid: cache flush delay:   ");
>  	for( i = 9; i >= 0; i-- ) {
>  		printk("\b\b\b[%d]", i);
> -		mdelay(1000);
> +		msleep(1000);
>  	}
>  	printk("\b\b\b[done]\n");
> -	mdelay(1000);
> +	msleep(1000);
>  
>  	return NOTIFY_DONE;
>  }
