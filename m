Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGIKX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGIKX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUGIKX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:23:56 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:45830 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265031AbUGIKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:23:53 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@ds14.agh.edu.pl>
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: GCC 3.4 and broken inlining.
Date: Fri, 9 Jul 2004 12:23:47 +0200
User-Agent: KMail/1.6.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <20040709054657.GA52213@muc.de> <200407091143.41955.mbuesch@freenet.de>
In-Reply-To: <200407091143.41955.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407091223.47516.pluto@ds14.agh.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 of July 2004 11:43, Michael Buesch wrote:
> Quoting Andi Kleen <ak@muc.de>:
> > It's too bad that i386 doesn't enable -funit-at-a-time, that improves
> > the inlining heuristics greatly.
>
> From the gcc manpage:
>
> -O2 turns on all optimization flags specified by -O. It
> also turns on the following optimization flags: -fforce-mem
> -foptimize-sibling-calls -fstrength-reduce -fcse-follow-jumps
> -fcse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt
> -fgcse -fgcse-lm -fgcse-sm -fgcse-las -fdelete-null-pointer-checks
> -fexpensive-optimizations -fregmove -fschedule-insns
> -fschedule-insns2 -fsched-interblock -fsched-spec -fcaller-saves
> -fpeephole2 -freorder-blocks -freorder-functions -fstrict-aliasing
> -funit-at-a-time -falign-functions -falign-jumps -falign-loops
> ^^^^^^^^^^^^^^^^
> -falign-labels -fcrossjumping
>
> Do I miss something?

# gcc-3.4.1/gcc/opts.c

  if (optimize >= 2)
    {
(...)
      flag_unit_at_a_time = 1;
    }

btw).

I *don't trust* manpages ;)

# man gcc

-fomit-frame-pointer

   Don't keep the frame pointer in a register for functions that don't
   need one.  This avoids the instructions to save, set up and restore
   frame pointers; it also makes an extra register available in many
   functions.  It also makes debugging impossible on some machines.
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   (...)
   Enabled at levels -O, -O2, -O3, -Os.
   ^^^^^^^

  if (optimize >= 1)
    {
(...)
#ifdef CAN_DEBUG_WITHOUT_FP
      flag_omit_frame_pointer = 1;
#endif
(...)

finally, at ix86 -O[123s] doesn't turn on -fomit-frame-pointer.
manpage tells somethine else...

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
