Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTCDUuS>; Tue, 4 Mar 2003 15:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTCDUuS>; Tue, 4 Mar 2003 15:50:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266886AbTCDUuR>;
	Tue, 4 Mar 2003 15:50:17 -0500
Date: Tue, 4 Mar 2003 14:36:51 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > --- linux-2.5.63/arch/i386/kernel/suspend.c	2003-02-20 08:25:26.000000000 +1300
> > > +++ linux-2.5.63-01/arch/i386/kernel/suspend.c	2003-02-20 08:27:36.000000000 +1300
> > 
> > Thank you for putting this back in C, it's much appreciated. 
> 
> Actually, it can not be put back in C. Manipulating stack pointer from
> gcc inline assembly is just undefined. Its back in C so we can edit
> it, but it needs to get back to assembly before merging with Linus.

Noted. I'll convert it back. 


> > This is better done as 
> > 
> > 	for (loop = 0; loop < nr_copy_pagse; loop++) {
> > 		memcpy((char *)pagedir_nosave[loop].orig_address,
> > 		       (char *)pagedir_nosave[loop].address,
> > 		       PAGE_SIZE);
> > 		__flush_tlb();
> > 	}
> 
> Hehe, try it.
> 
> You may not do function call at this point, because you are
> overwriting your stack. See mails with Andi Kleen. This *needs* to be
> in assembly. 

memcpy() is inlined, at least on x86, and it seems to work fine for me
here. Besides, even if memcpy is not safe, you could at least copy 4 bytes
at a time. ;)

	-pat

