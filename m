Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTCEUkD>; Wed, 5 Mar 2003 15:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTCEUkD>; Wed, 5 Mar 2003 15:40:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6663 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262394AbTCEUkC>; Wed, 5 Mar 2003 15:40:02 -0500
Date: Wed, 5 Mar 2003 21:50:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030305205032.GD2958@atrey.karlin.mff.cuni.cz>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > --- linux-2.5.63/arch/i386/kernel/suspend.c	2003-02-20 08:25:26.000000000 +1300
> > > > +++ linux-2.5.63-01/arch/i386/kernel/suspend.c	2003-02-20 08:27:36.000000000 +1300
> > > 
> > > Thank you for putting this back in C, it's much appreciated. 
> > 
> > Actually, it can not be put back in C. Manipulating stack pointer from
> > gcc inline assembly is just undefined. Its back in C so we can edit
> > it, but it needs to get back to assembly before merging with Linus.
> 
> Noted. I'll convert it back. 

Okay.

> > > This is better done as 
> > > 
> > > 	for (loop = 0; loop < nr_copy_pagse; loop++) {
> > > 		memcpy((char *)pagedir_nosave[loop].orig_address,
> > > 		       (char *)pagedir_nosave[loop].address,
> > > 		       PAGE_SIZE);
> > > 		__flush_tlb();
> > > 	}
> > 
> > Hehe, try it.
> > 
> > You may not do function call at this point, because you are
> > overwriting your stack. See mails with Andi Kleen. This *needs* to be
> > in assembly. 
> 
> memcpy() is inlined, at least on x86, and it seems to work fine for me
> here. Besides, even if memcpy is not safe, you could at least copy 4 bytes
> at a time. ;)

Well, this whole needs to be in assembly, anyway. I decided it is not
perfomance critical, and copied it byte-by-byte. That can be
changed...
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
