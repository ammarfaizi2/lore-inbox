Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288649AbSAIAcb>; Tue, 8 Jan 2002 19:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288646AbSAIAcW>; Tue, 8 Jan 2002 19:32:22 -0500
Received: from waste.org ([209.173.204.2]:36235 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288647AbSAIAcQ>;
	Tue, 8 Jan 2002 19:32:16 -0500
Date: Tue, 8 Jan 2002 18:31:42 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C3B4CB7.FEAAF5FC@zip.com.au>
Message-ID: <Pine.LNX.4.43.0201081819060.23139-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Andrew Morton wrote:

> > What a preemptible kernel can do that a non-preemptible kernel can't is:
> > reschedule exactly as often as necessary, instead of having lots of extra
> > schedule points inserted all over the place, firing when *they* think the
> > time is right, which may well be earlier than necessary.
>
> Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> actually).

Have we ever considered making rescheduling work like get_user? That is,
make current->need_resched be a pointer, and if we need to reschedule,
make it an INVALID pointer that causes us to fault and call schedule in
its fault path?

Orthogonally, for rescheduling points with locks, we could build a version
of the spinlocks that know when they're blocking other processes and can
do a spin_yield(&lock) in places where they can safely give up a lock. On
single processor, spin_yield could translate to a scheduling point.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

