Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTIICa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTIICa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:30:26 -0400
Received: from dp.samba.org ([66.70.73.150]:64479 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263887AbTIICaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:30:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection 
In-reply-to: Your message of "Mon, 08 Sep 2003 16:29:21 +0200."
             <20030908142920.GB28062@fs.tum.de> 
Date: Tue, 09 Sep 2003 11:11:21 +1000
Message-Id: <20030909023011.BF25E2C014@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030908142920.GB28062@fs.tum.de> you write:
> On Mon, Sep 08, 2003 at 10:46:30AM +1000, Rusty Russell wrote:
> > In message <20030907112813.GQ14436@fs.tum.de> you write:
> > > - @Rusty:
> > >   what's your opinion on making MODULE_PROC_FAMILY in 
> > >   include/asm-i386/module.h some kind of bitmask?
> > 
> > The current one is readable, which is good, and Linus asked for it,
> > which makes it kinda moot.  And really, if you compile a module with
> > M686 and insert it in a kernel with M586, *WHATEVER* scheme you we use
> > for CPU seleciton, I want the poor user to have to use "modprobe -f".
> 
> I agree, my thoughts go in the direction
> 
> bit 0 CPU_386
> bit 1 CPU_486
> bit 2 CPU_586

We had a bitmask, which Linus said to replace with a string.  We have
21 architectures, and a string works well in practice.  We could have
a bitmask *and* a string, but why the complexity?

> And you should need a "modprobe -f" if the bitmask in the module differs 
> from the bitmask in the kernel.

All modprobe -f knows is that it should remove/rename various sections
from the elf object before handing it to the kernel.  The checking is
done in the kernel, as it should be (so we could change this whenever
we want, for example).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
