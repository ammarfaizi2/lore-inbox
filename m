Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755113AbWKLN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbWKLN3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbWKLN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:29:55 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:24049 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1755112AbWKLN3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:29:54 -0500
Date: Sun, 12 Nov 2006 13:28:49 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <wim.coekaerts@oracle.com>
Subject: Re: [PATCH 5/5] ioremap balanced with iounmap for drivers/char/watchdog/s3c2410_wdt.c
Message-ID: <20061112132849.GA29674@home.fluff.org>
References: <1160110627.19143.88.camel@amol.verismonetworks.com> <20061006134020.96edb3ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006134020.96edb3ff.akpm@osdl.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:40:20PM -0700, Andrew Morton wrote:
> On Fri, 06 Oct 2006 10:27:07 +0530
> Amol Lad <amol@verismonetworks.com> wrote:
> 
> > Signed-off-by: Amol Lad <amol@verismonetworks.com>
> > ---
> >  s3c2410_wdt.c |    5 +++++
> >  1 files changed, 5 insertions(+)
> > ---
> > diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c
> > --- linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:00:43.000000000 +0530
> > +++ linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:50:00.000000000 +0530
> > @@ -381,18 +381,21 @@ static int s3c2410wdt_probe(struct platf
> >  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >  	if (res == NULL) {
> >  		printk(KERN_INFO PFX "failed to get irq resource\n");
> > +		iounmap(wdt_base);
> >  		return -ENOENT;
> >  	}
> >  
> >  	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
> >  	if (ret != 0) {
> >  		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
> > +		iounmap(wdt_base);
> >  		return ret;
> >  	}
> >  
> >  	wdt_clock = clk_get(&pdev->dev, "watchdog");
> >  	if (wdt_clock == NULL) {
> >  		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
> > +		iounmap(wdt_base);
> >  		return -ENOENT;
> >  	}
> >  
> > @@ -416,6 +419,7 @@ static int s3c2410wdt_probe(struct platf
> >  	if (ret) {
> >  		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
> >  			WATCHDOG_MINOR, ret);
> > +		iounmap(wdt_base);
> >  		return ret;
> >  	}
> >  
> 
> barf.  That function has to set the record for the
> number-of-return-statements-per-line.  There are good reasons why we prefer
> to have a single return point at which to handle all the error unwinding,
> and the above patch illustrates one of them.

I'll try and sort this out once 2.6.19 is out.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
