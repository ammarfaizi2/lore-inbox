Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSFFQgD>; Thu, 6 Jun 2002 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSFFQgC>; Thu, 6 Jun 2002 12:36:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10761 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316995AbSFFQgC>; Thu, 6 Jun 2002 12:36:02 -0400
Date: Thu, 6 Jun 2002 09:36:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <frankeh@watson.ibm.com>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <E17FrfH-0006Gt-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jun 2002, Rusty Russell wrote:
>
> The method is: open /dev/futex

STOP!

What madness is this?

You have a damn mutex system call, don't introduce mode crap in /dev.

Do we create pipes by opening /dev/pipe? No. Do we have major and minor
numbers for sockets and populate /dev with them? No. And as a result,
there has _never_ been any sysadmin problems with either.

You already have to have a system call to bind the particular fd to the
futex _anyway_, so do the only sane thing, and allocate the fd _there_,
and get rid of that stupid and horrible /dev/futed which only buys you
pain, system administration, extra code, and a black star for being
stupid.

		Linus

