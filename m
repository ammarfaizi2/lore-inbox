Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJJE0v>; Wed, 10 Oct 2001 00:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274683AbRJJE0l>; Wed, 10 Oct 2001 00:26:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23586 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274681AbRJJE02>; Wed, 10 Oct 2001 00:26:28 -0400
Date: Wed, 10 Oct 2001 06:27:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010062701.I726@athlon.random>
In-Reply-To: <200110100358.f9A3wSB17421@zero.tech9.net> <1002686542.866.164.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1002686542.866.164.camel@phantasy>; from rml@tech9.net on Wed, Oct 10, 2001 at 12:02:13AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 12:02:13AM -0400, Robert Love wrote:
> On Tue, 2001-10-09 at 23:57, Dieter Nützel wrote:
> > Robert you are running a dual PIII system, right?
> > Could that be the ground why you aren't see the hiccup with your nice preempt
> > patch? Are you running ReiserFS or EXT2/3?
> 
> No, I am on a single P3-733.  I am using ext3.
> 
> I have had reports from users on both UP and SMP systems that say audio
> playback is undisturbed during heavy I/O with preempt-kernel patch.  Of
> course, I don't know their definition of undisturbed...but I would wager
> it doesn't include 2-3s skips.

If it's purerly I/O even mainline that is missing the reschedule points
shouldn't matter.

Infact the only thing that hurts during pure I/O (I mean not I/O from
cache, I mean real I/O to disk) is the browse of the lru dirty lists in
buffer.c and the vm lists (the latter are covered in latest 2.4). And
just the preemptive patch cannot help there since they're both covered
by locks and the explicit checks in the preemptive patch will get a
result equal to the lowlatency approch.

If it's mixed I/O half from cache and half from disk, then the lack of
reschedule points could be the culprit of course.

Andrea
