Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbTCNH7y>; Fri, 14 Mar 2003 02:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTCNH7x>; Fri, 14 Mar 2003 02:59:53 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:21104 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S263277AbTCNH7u>; Fri, 14 Mar 2003 02:59:50 -0500
Date: Fri, 14 Mar 2003 09:04:11 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.44.0303121706030.16238-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.30.0303140703010.24704-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Linus Torvalds wrote:
>
> The preceding bytes may not even be code - they can be constant data in
> the code segment. Trying to decode them as code just generates garbage in
> those circumstances.

What do you exactly mean under "garbage"? There could be several (e.g.
by a jump to EIP). My best bet you don't want to dump the bytes before
EIP if they don't start on the correct instuction boundary the CPU was
or could execute or the reliable "off-line" disassembling of the
oopsed function would give.

Bcode, meaning before code [well, wrong choise, could be misunderstend
as byte code], would mean it's the bytes before Code. They are not
necessarily start on the _correct_ instruction boundary (14% they
are). One should disassemble them separately from offset 0,1,...6
(pedantic coders or in case of a later failure to 14) and choose the
one that makes sense based on

	1) next instruction boundary is on EIP (can be automated)
and
	2) has something to do with the C source code
and
	3) the assembly makes sense (considering compiler
           optimizations, generated dead/bad code, etc)
and
	4) the assembly fits the context after EIP.

If you think this would result more confusion than benefit, I
understand (promised to my fiancee to say so ;)

On the other hand, if the kernel did this, a simple script could be
written analysing the last two years kernel oopses [and future ones]
on linux-kernel and tell what oopses resulted due to this access below
stack compiler bug. Yes, some minimal human intervention would be
still needed to confirm all of them but IMHO it's more productive then
just letting them unsolved and have doubts in kernel quality.

	Szaka

