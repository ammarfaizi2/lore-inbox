Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSKYAWv>; Sun, 24 Nov 2002 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKYAWv>; Sun, 24 Nov 2002 19:22:51 -0500
Received: from dp.samba.org ([66.70.73.150]:1466 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261996AbSKYAWu>;
	Sun, 24 Nov 2002 19:22:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Sat, 23 Nov 2002 23:23:34 BST."
             <20021123222334.GB5170@elf.ucw.cz> 
Date: Mon, 25 Nov 2002 11:26:25 +1100
Message-Id: <20021125003005.130DA2C087@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021123222334.GB5170@elf.ucw.cz> you write:
> Hi!
> 
> > Q: How does the module remove code work?
> > A: It stops the machine by scheduling threads for every other CPU,
> >    then they all disable interrupts.  At this stage we know that noone
> >    is in try_module_get(), so we can reliably read the counter.  If
> >    zero, or the rmmod user specified --wait, we set the live flag to
> >    false.  After this, the reference count should not increase, and
> >    each module_put() will wake us up, so we can check the counter
> >    again.
> 
> Where is this implemented? I guess I need this for swsusp...

I'm not so sure, but it's worth a look.  Look for stop_refcounts() in
module.c.  BTW, I call this a "bogolock".

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
