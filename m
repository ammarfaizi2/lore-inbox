Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVDXUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVDXUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVDXUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:21:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17548 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262400AbVDXUUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:20:53 -0400
Date: Sun, 24 Apr 2005 22:20:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Message-ID: <20050424202034.GB30088@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz> <200504241230.27544.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504241230.27544.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The following patch makes some comments and printk()s in swsusp.c up to date.
> > > In particular it adds the string "swsusp" before every message that is printed by
> > > the code in swsusp.c.
> > 
> > I don't like this one. Adding swsusp everywhere just clutters the
> > screen, most of it should be clear from context.
> 
> Right.  Still, I'd like to drop function names from debug messages
> and replace "suspend" with "swsusp" in some messages.  I'll send another
> patch for it after 2.6.12 (please let me know if you don't think it's a good
> idea ;-)).

Well, I'll not say "no" just now ;-). I thought 'suspend' is nicer for
non-technical users, not being acronym.

> For now, please drop the patch altogether.

Done.

> > > @@ -1226,9 +1222,6 @@ static int check_sig(void)
> > >  
> > >  /**
> > >   *	data_read - Read image pages from swap.
> > > - *
> > > - *	You do not need to check for overlaps, check_pagedir()
> > > - *	already did that.
> > >   */
> > >  
> > >  static int data_read(struct pbe *pblist)
> > 
> > Why is this comment no longer valid?
> 
> It's just confusing.  Initially, I didn't intend to change it, but then I read it
> and thought "What overlaps?".  In data_read() there's nothing that could
> overlap with anything else ...

Well, if there were no checking in check_pagedir, we could end up in
situation where some page's address == some other page's original
address. That would be really bad. This comment says it can not happen
because care was taken in check_pagedir(). Perhaps it needs to be
explained better?

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
