Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRIIDuP>; Sat, 8 Sep 2001 23:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271867AbRIIDuF>; Sat, 8 Sep 2001 23:50:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:59261 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271865AbRIIDts>; Sat, 8 Sep 2001 23:49:48 -0400
Date: Sun, 9 Sep 2001 05:50:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: expand_stack fix [was Re: 2.4.9aa3]
Message-ID: <20010909055038.M11329@athlon.random>
In-Reply-To: <20010908180416.Z11329@athlon.random> <200109090423.XAA03403@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109090423.XAA03403@ccure.karaya.com>; from jdike@karaya.com on Sat, Sep 08, 2001 at 11:23:38PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 11:23:38PM -0500, Jeff Dike wrote:
> andrea@suse.de said:
> > My fix for the race doesn't drop the usability of GROWSDOWN that could
> > otherwise break userspace programs. I guess at least uml uses
> > growsdown vma file backed. Jeff? 
> 
> No.  In neither the host kernel or UML is there a vma that's file backed and
> growsdown.
> 
> UML process stacks are marked growsdown in UML and are file backed on the host,
> but that's not the same thing.

ok, so I guess you're doing the growsdown by hand in the uml sigsegv
handler.

So it's probably fine to allow GROWSDOWN only on anon vmas per Linus's
suggestion. I can attempt to change the race fix that way.

However about last Linus's suggestion it's not obvious to me that
dropping GROWSDOWN/UP completly and forcing a fixed virtual size of the
stack [modulo rlimit of course] is a good idea, because:

1) on 32bit platforms having big vma for the stack means reducing the
   space for the dynamic mappings
2) I love not to have a virtual stack limit for software making use of
   aggressive recursion.

The gap logic is very simple too.

Andrea
