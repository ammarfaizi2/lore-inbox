Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274292AbRJJChX>; Tue, 9 Oct 2001 22:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJJChE>; Tue, 9 Oct 2001 22:37:04 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:15119 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274292AbRJJCgp>; Tue, 9 Oct 2001 22:36:45 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@ufl.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010043003.C726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
	<20011010031803.F8384@athlon.random>
	<20011010020935.50DEF1E756@Cantor.suse.de> 
	<20011010043003.C726@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 22:37:56 -0400
Message-Id: <1002681480.1044.67.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 22:30, Andrea Arcangeli wrote:
> As said it's very very unlikely that preemption points can fix xmms
> skips anyways, the worst scheduler latency is always of the order of the
> msecs, to generate skips you need a latency of seconds.
>
> [...]
>
> There's nothing magic in the software, if you divide the cpu in 10 parts
> and you give 1/10 of the cpu to xmms, but xmms needs 1/2 of the cpu to
> play your .mp3 then there's nothing you can do to fix it but to tell
> the scheduler to give more cpu to xmms (renicing to -20 gives more cpu

What if the CPU does divide its time into two 1/2 parts, and gives one
each to xmms and dbench.  Everything runs fine, since xmms needs 1/2 cpu
to play without skips.

Now dbench (or any task) is in kernel space for too long.  The CPU time
xmms needs will of course still be given, but _too late_.  Its just not
a cpu resource problem, its a timing problem.  xmms needs x units of CPU
every y units of time.  Just getting the x whenever is not enough.

With preempt-kernel patch, the long-lasting kernel space activity dbench
is engaged in won't hog the CPU until it completes.  When xmms is ready
(time y arrives), the scheduler will yield the CPU.

	Robert Love

