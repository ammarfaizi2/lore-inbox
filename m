Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265597AbSJSNPU>; Sat, 19 Oct 2002 09:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265600AbSJSNPU>; Sat, 19 Oct 2002 09:15:20 -0400
Received: from a169250.upc-a.chello.nl ([62.163.169.250]:2308 "EHLO
	walton.kettenis.dyndns.org") by vger.kernel.org with ESMTP
	id <S265597AbSJSNPT>; Sat, 19 Oct 2002 09:15:19 -0400
Date: Sat, 19 Oct 2002 15:20:19 +0200 (CEST)
Message-Id: <200210191320.g9JDKJWs001201@elgar.kettenis.dyndns.org>
From: Mark Kettenis <kettenis@chello.nl>
To: dan@debian.org, mingo@elte.hu
CC: mgross@unix-os.sc.intel.com, linux-kernel@vger.kernel.org,
       phil-list@redhat.com
In-reply-to: <20021018004847.GA27817@nevyn.them.org> (message from Daniel
	Jacobowitz on Thu, 17 Oct 2002 20:48:47 -0400)
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <200210180004.g9I04OP17510@unix-os.sc.intel.com> <20021018004847.GA27817@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 17 Oct 2002 20:48:47 -0400
   From: Daniel Jacobowitz <dan@debian.org>

   You'd have to ask Mark Kettenis about that.  Mark, it looks like you
   updated the kernel to write namesz == 6, but BFD still expects 5 (and
   elfcore_write_note writes 6)?  Shouldn't we accept both, anyway?

Depends...

The whole story about the SSE register stuff is a bit muddy.  IIRC,
the support for the reg-xfp sections was added by Jim Blandy to
support unofficial kernel patches that were developed/used internally
at RedHat.  That's probably why Jim picked this weird value for
NT_FPXREG.  Only some parts of those kernel patches ended up in
Linus's tree, and even those bits underwent some changes for which I
adjusted GDB.  Even now the official kernel still doesn't have support
for the SSE registers in core files, and as far as I know there is no
patch floating around that's in wide use (yet) that adds this support.
Therefore, I don't think we should "contaminate" our source with
backwards compatibility hacks.  That's what I suggested when I
submitted a patch for BFD.  See the thread at:

   http://sources.redhat.com/ml/binutils/2002-07/msg00096.html

As you can see from the last message I got permission to change 5 into
6.  Then I went on holiday, and forgot about the stuff :-(.  I assume
Alan would be still OK with the patch, so I'll add the change in a moment.

In the light of the discussion above, I don't think Ingo's patch
should change NT_FPXREG/NT_PRFPXREG from 20 to 0x46e62b7f (and the
name shouldn't be changed either I think).  We should change it in
GDB/BFD instead from 0x46e62b7f.  The value 20 is already publically
available in the current kernel headers and glibc headers.  What are
your feelings about that, Ingo?

Mark
