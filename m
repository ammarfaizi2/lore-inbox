Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264011AbRFJGTk>; Sun, 10 Jun 2001 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264502AbRFJGTb>; Sun, 10 Jun 2001 02:19:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264011AbRFJGT1>; Sun, 10 Jun 2001 02:19:27 -0400
Date: Sat, 9 Jun 2001 23:19:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <200106100228.TAA18829@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.21.0106092313280.27431-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Jun 2001, Dawson Engler wrote:
> > 
> > Good point. Spinlocks (with the exception of read-read locks, of course)
> > and semaphores will deadlock on recursive use, while the BKL has this
> > "process usage counter" recursion protection.
> 
> Actually, it did show up all over the place --- I'd just selected two
> candidates to examine out of hundreds.  (Checking call chains is
> strenous, even when you know what you're looking for.)

Sure.

> > Dawson - the user-mode access part is probably _the_ most interesting from
> > a lock checking standpoint, could you check doing the page fault case?
> 
> Sure, it's a pretty interaction.  To be sure about the rule: any *_user
> call can be treated as an implicit invocation of do_page_fault?  

As a first approximation, yes. The exception cases are certain callers
that use kernel addresses and set_fs(KERNEL_DS) in order to "fake"
arguments to system calls etc, but I doubt they should need any
special-casing.

		Linus

