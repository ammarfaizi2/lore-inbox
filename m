Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbTAJHZt>; Fri, 10 Jan 2003 02:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTAJHYv>; Fri, 10 Jan 2003 02:24:51 -0500
Received: from dp.samba.org ([66.70.73.150]:5100 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263366AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [PATCH] Embed __this_module in module itself. 
In-reply-to: Your message of "07 Jan 2003 14:36:54 +0900."
             <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Date: Wed, 08 Jan 2003 22:51:24 +1100
Message-Id: <20030110073328.A53D02C0DF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp> you write:
> Miles Bader <miles@lsi.nec.co.jp> writes:
> > When I try to build modules using 2.5.54, the resulting .ko files lack
> > the .gnu.linkonce.* sections, which causes the kernel module loader to
> > fail on them -- those sections _are_ present in the .o files, but the
> > linker apparently removes them!
> 
> Ok, I found out why this is happening -- the v850 default linker
> scripts, for whatever reason, merge any section called `.gnu.linker.t*'
> with .text.

That's about as wierdass as it comes.

> I can prevent this by adding the option `--unique=.gnu.linkonce.this_module'
> to the linker flags (specifically, to LDFLAGS_MODULE in the top-level
> Makefile).  I suppose another way to do it would be to rename the
> section something that doesn't match `.gnu.linker.t*'.

Or you could add this flag in arch/v850/Makefile.

> What's the right way to handle this?
> 
> [from perusing the ld srcs, a few other archs seem to have the same
> `feature,' though the only that I think has linux support is `cris']

I think:
	LDFLAGS_MODULE += -T arch/v850/module.lds

And include a linker script there which works.

Thanks for finding this...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
