Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSDCRwD>; Wed, 3 Apr 2002 12:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312302AbSDCRvx>; Wed, 3 Apr 2002 12:51:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14341 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312294AbSDCRvf>; Wed, 3 Apr 2002 12:51:35 -0500
Date: Wed, 3 Apr 2002 09:50:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] BKL reduction in do_exit
In-Reply-To: <3CAB3807.5040508@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0204030945310.3571-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Apr 2002, Dave Hansen wrote:
>
> Nobody had anything to sayabout it, so here's a patch.  It moves the
> disassociate_ctty(1) up, and releases the BKl after it gets done.  Is
> this a sane thing to do, or do some of those exit_*() functions still
> need the tty?

I'd prefer to have the BKL just moved into the functions that need it, and
removed altogether from do_exit().

That's especially true as I don't know if sem_exit() actually needs the
BKL any more at all - so that if it doesn't, we can just remove it from
there (at which point it is a local implementation issue, rather than a
cross-module thing).

The disassociate_tty thing falls under a similar heading - we're going to
have to fix up the tty layer some day anyway, let's make the BKL detail a
tty layer internal thing.

		Linus

