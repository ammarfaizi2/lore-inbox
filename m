Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWF0XPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWF0XPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWF0XPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:15:43 -0400
Received: from xenotime.net ([66.160.160.81]:23956 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422716AbWF0XPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:15:42 -0400
Date: Tue, 27 Jun 2006 16:18:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
Cc: snakebyte@gmx.de, linux-kernel@vger.kernel.org, Henk.Vergonet@gmail.com
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-Id: <20060627161826.db62fd00.rdunlap@xenotime.net>
In-Reply-To: <20060627230415.GA16561@alice>
References: <1151448080.16217.3.camel@alice>
	<20060627155143.b0e3e1dd.rdunlap@xenotime.net>
	<20060627230415.GA16561@alice>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 01:04:16 +0200 Eric Sesterhenn / Snakebyte wrote:

> * Randy.Dunlap (rdunlap@xenotime.net) wrote:
> > On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:
> > 
> > > another off by one spotted by coverity (id #485),
> > > we loop exactly one time too often
> > > 
> > > --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig	2006-06-28 00:29:46.000000000 +0200
> > > +++ linux-2.6.17-git11/drivers/usb/input/yealink.c	2006-06-28 00:30:04.000000000 +0200
> > > @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct 
> > >  		val = yld->master.b[ix];
> > >  		if (val != yld->copy.b[ix])
> > >  			goto send_update;
> > > -	} while (++ix < sizeof(yld->master));
> > > +	} while (++ix < sizeof(yld->master)-1);
> > >  
> > >  	/* nothing todo, wait a bit and poll for a KEYPRESS */
> > >  	yld->stat_ix = 0;
> > 
> > FWIW, on this one and the previous floppy.c patch,
> > I would rather see the comparison be <= instead of using -1.
> 
> maybe it is too late, but wouldnt the <= make the loop
> run even more iterations, like (++ix < sizeof() + 1)

:) Yep.

so for the floppy.c patch, I still prefer to see:
+	if (drive < 0 || drive >= N_DRIVE) {

instead of
+	if (drive < 0 || drive > N_DRIVE-1) {

Does that make sense?

---
~Randy
