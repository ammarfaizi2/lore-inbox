Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268194AbTALBky>; Sat, 11 Jan 2003 20:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268196AbTALBky>; Sat, 11 Jan 2003 20:40:54 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:59807 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S268194AbTALBkx>; Sat, 11 Jan 2003 20:40:53 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
References: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: 11 Jan 2003 20:49:39 -0500
In-Reply-To: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
Message-ID: <sjm1y3j3znw.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Linus Torvalds <torvalds@transmeta.com> writes:

> >         1) PANIC: INIT: ...
> >         2) String of Oopses
> >         3) Working Tree.
> > 
> > The changeover from 2-3 is approximately December 30 (see my previous
> > post).
> 
> I was hoping for a exact changset, your post didn't seem to be 100% sure.

The 'String of oopses' was a red herring.  It was fixed sometime in early
January.  The PANIC: INIT: problem, however, is real, and was introduced
by the following ChangeSet on January 7:

D 1.972 03/01/07 10:08:55-08:00 torvalds@home.transmeta.com 15824 15815 2/0/1
P ChangeSet
C Move x86 signal handler return stub to the vsyscall page,
C and stop honoring the SA_RESTORER information.
C 
C This will prepare us for alternate signal handler returns.

If I build a kernel WITH this changeset it fails; if I build a kernel
at 1.971 (bjorn_helgaas's i810/i830 AGP patches) the kernel works just
fine.

So, something in your changes to kernel/sysenter.c or kernel/signal.c
causes INIT to PANIC and fail.

So, what would you like me to test, now?

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
