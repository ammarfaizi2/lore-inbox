Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWF0XEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWF0XEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWF0XEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:04:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:63878 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932574AbWF0XET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:04:19 -0400
X-Authenticated: #704063
Date: Wed, 28 Jun 2006 01:04:16 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       Henk.Vergonet@gmail.com
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-ID: <20060627230415.GA16561@alice>
References: <1151448080.16217.3.camel@alice> <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17-mm3 (i686)
X-Uptime: 01:02:44 up  7:16,  5 users,  load average: 1.90, 1.90, 1.21
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy.Dunlap (rdunlap@xenotime.net) wrote:
> On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:
> 
> > hi,
> > 
> > another off by one spotted by coverity (id #485),
> > we loop exactly one time too often
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> > --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig	2006-06-28 00:29:46.000000000 +0200
> > +++ linux-2.6.17-git11/drivers/usb/input/yealink.c	2006-06-28 00:30:04.000000000 +0200
> > @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct 
> >  		val = yld->master.b[ix];
> >  		if (val != yld->copy.b[ix])
> >  			goto send_update;
> > -	} while (++ix < sizeof(yld->master));
> > +	} while (++ix < sizeof(yld->master)-1);
> >  
> >  	/* nothing todo, wait a bit and poll for a KEYPRESS */
> >  	yld->stat_ix = 0;
> 
> FWIW, on this one and the previous floppy.c patch,
> I would rather see the comparison be <= instead of using -1.

maybe it is too late, but wouldnt the <= make the loop
run even more iterations, like (++ix < sizeof() + 1)

greetings, Eric

