Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRLAWFf>; Sat, 1 Dec 2001 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRLAWFZ>; Sat, 1 Dec 2001 17:05:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56848 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281772AbRLAWFQ>; Sat, 1 Dec 2001 17:05:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] task_struct colouring ...
Date: 1 Dec 2001 14:04:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ubk5r$ev3$1@cesium.transmeta.com>
In-Reply-To: <000901c17a51$62526070$010411ac@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <000901c17a51$62526070$010411ac@local>
By author:    "Manfred Spraul" <manfred@colorfullife.com>
In newsgroup: linux.dev.kernel
> 
> There are obviously lots of alternatives how to look up the task structure address:
> * bottom of stack allocation (your patch)
> * %cr2 (broken, only works for OS' that never cause page faults such as Netware)
> * gs: (segment register, x86-64 uses that. But i386 doesn't have the swapgs instruction)
> * str (Ben's patch)
> * read from local apic memory (real slow!, uncached memory reference)
> 

%gs on x86-64 actually points to a per-CPU area; as does the proposed
%tr hack.  IMNSHO I think this is a much better idea than having
something that points to "current"; if we do this consistently across
architectures I'm sure there is plenty we can use this per-CPU area
for.

Saving and restoring %gs (or %fs, which is less likely to be used in
userspace, and therefore potentially faster) is probably not
justifiable unless we do at least four accesses to "current" in the
average system call.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
