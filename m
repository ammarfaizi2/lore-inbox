Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266121AbUGJDR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbUGJDR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 23:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGJDR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 23:17:29 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4291 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266121AbUGJDRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 23:17:25 -0400
Date: Fri, 09 Jul 2004 21:12:04 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: GCC 3.4 and broken inlining.
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <018101c4662b$ad61c830$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.hnj36kg.4no2jk@ifi.uio.no> <fa.gktbdsg.1n4em8o@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you check the full gcc docs, the -Ox flags only enable omit-frame-pointer
on architectures where debugging is possible without a frame pointer. If you
use the actual -fomit-frame-pointer option, it is always omitted.

----- Original Message ----- 
From: "Pawel Sikora" <pluto@ds14.agh.edu.pl>
Newsgroups: fa.linux.kernel
To: "Michael Buesch" <mbuesch@freenet.de>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Sent: Friday, July 09, 2004 4:25 AM
Subject: Re: GCC 3.4 and broken inlining.


> On Friday 09 of July 2004 11:43, Michael Buesch wrote:
> > Quoting Andi Kleen <ak@muc.de>:
> > > It's too bad that i386 doesn't enable -funit-at-a-time, that improves
> > > the inlining heuristics greatly.
> >
> > From the gcc manpage:
> >
> > -O2 turns on all optimization flags specified by -O. It
> > also turns on the following optimization flags: -fforce-mem
> > -foptimize-sibling-calls -fstrength-reduce -fcse-follow-jumps
> > -fcse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt
> > -fgcse -fgcse-lm -fgcse-sm -fgcse-las -fdelete-null-pointer-checks
> > -fexpensive-optimizations -fregmove -fschedule-insns
> > -fschedule-insns2 -fsched-interblock -fsched-spec -fcaller-saves
> > -fpeephole2 -freorder-blocks -freorder-functions -fstrict-aliasing
> > -funit-at-a-time -falign-functions -falign-jumps -falign-loops
> > ^^^^^^^^^^^^^^^^
> > -falign-labels -fcrossjumping
> >
> > Do I miss something?
>
> # gcc-3.4.1/gcc/opts.c
>
>   if (optimize >= 2)
>     {
> (...)
>       flag_unit_at_a_time = 1;
>     }
>
> btw).
>
> I *don't trust* manpages ;)
>
> # man gcc
>
> -fomit-frame-pointer
>
>    Don't keep the frame pointer in a register for functions that don't
>    need one.  This avoids the instructions to save, set up and restore
>    frame pointers; it also makes an extra register available in many
>    functions.  It also makes debugging impossible on some machines.
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    (...)
>    Enabled at levels -O, -O2, -O3, -Os.
>    ^^^^^^^
>
>   if (optimize >= 1)
>     {
> (...)
> #ifdef CAN_DEBUG_WITHOUT_FP
>       flag_omit_frame_pointer = 1;
> #endif
> (...)
>
> finally, at ix86 -O[123s] doesn't turn on -fomit-frame-pointer.
> manpage tells somethine else...
>
> -- 
> /* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property.
*/
>
>                            #define say(x) lie(x)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

