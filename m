Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWF2MYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWF2MYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWF2MYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:24:12 -0400
Received: from ns.suse.de ([195.135.220.2]:17795 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751295AbWF2MYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:24:11 -0400
Date: Thu, 29 Jun 2006 14:23:55 +0200
From: Karsten Keil <kkeil@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i4l:add some checks for valid drvid and driver pointer
Message-ID: <20060629122355.GA10273@pingi.kke.suse.de>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060629111629.GB9501@pingi.kke.suse.de> <1151580572.3122.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151580572.3122.30.camel@laptopd505.fenrus.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:29:31PM +0200, Arjan van de Ven wrote:
> On Thu, 2006-06-29 at 13:16 +0200, Karsten Keil wrote:
> > If all drivers go away before all ISDN network interfaces are closed we got
> > a OOps on removing interfaces, this patch avoid it.
> > 
> > Signed-off-by: Karsten Keil <kkeil@suse.de>
> > 
> > diff -ur linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c linux-2.6.4/drivers/isdn/i4l/isdn_common.c
> > --- linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c	2004-03-11 03:55:25.000000000 +0100
> > +++ linux-2.6.4/drivers/isdn/i4l/isdn_common.c	2004-03-30 18:35:38.000000000 +0200
> > @@ -341,6 +341,16 @@
> >  		printk(KERN_WARNING "isdn_command command(%x) driver -1\n", cmd->command);
> >  		return(1);
> >  	}
> > +	if (!dev->drv[cmd->driver]) {
> > +		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d] NULL\n",
> > +			cmd->command, cmd->driver);
> > +		return(1);
> > +	}
> 
> Hi,
> 
> if this is a "legal" condition, you really shouldn't printk about it. If
> it's not a normal legal condition, this isn't a fix but a hacky
> workaround ;)
> 

I also was thinking about removing the printk, they are in my patch for some
time to prove (which runs for long time on my systems) that this are legal
conditions. But you are correct, now it should be removed, no need to spam
syslog.

> Also..  return is not a function, so return 1; is the preferred form,
> not return(1)..
> 

OK

(I don't know why, but for me return() looks better, but that pure
private taste)


So I will send a new patch.

-- 
Karsten Keil
SuSE Labs
ISDN development
