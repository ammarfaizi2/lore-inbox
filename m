Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTAEDpt>; Sat, 4 Jan 2003 22:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTAEDpt>; Sat, 4 Jan 2003 22:45:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:26840 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261451AbTAEDps>;
	Sat, 4 Jan 2003 22:45:48 -0500
Message-ID: <3E17AC67.43923E08@digeo.com>
Date: Sat, 04 Jan 2003 19:54:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <3E1783D0.5A47A299@digeo.com> <Pine.LNX.4.44.0301041930300.1388-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 03:54:16.0102 (UTC) FILETIME=[1DE93460:01C2B46E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Jan 2003, Andrew Morton wrote:
> >
> > Looks like you're right.  The indications are that this change
> > has slowed context switches by ~5% on a PIII.   The backout patch
> > against 2.5.54 is below.  Testing on a P4 would be useful.
> 
> Hmm.. The backup patch doesn't handle single-stepping correctly: the
> eflags cleanup singlestep patch later in the sysenter sequence _depends_
> on the stack (and thus thread) being right on the very first in-kernel
> instruction.

Well that's just a straight `patch -R' of the patch which added the wrmsr's.

> That (along with benchmarking of system call numbers - the stack switch at
> system call run-time ends up being quite expensive on a P4) was what made
> me decide to do the traditional "write MSR in schedule" approach, even
> though I agree that it would be much nicer to not have to rewrite that
> stupid MSR all the time.
> 
> It doesn't show up on lmbench (insufficient precision), but your AIM9
> numbers are quite interesting. Are they stable?
> 

Seem to be, but more work is needed, including oprofiling.  Andi is doing
some P4 testing at present.
