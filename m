Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281848AbRKRDSK>; Sat, 17 Nov 2001 22:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281849AbRKRDSB>; Sat, 17 Nov 2001 22:18:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281848AbRKRDRt>; Sat, 17 Nov 2001 22:17:49 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 17 Nov 2001 19:12:51 -0800
Message-Id: <200111180312.fAI3CpG01076@penguin.transmeta.com>
To: ehrhardt@mathematik.uni-ulm.de, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Newsgroups: linux.dev.kernel
In-Reply-To: <20011117225327.5368.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20011116142344.A7316@netnation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011117225327.5368.qmail@thales.mathematik.uni-ulm.de> you write:
>
>I think this one liner (diffed against 2.4.14) could fix this Oops:

It really shouldn't matter - at that point we have the page locked, and
we know the page has buffers, so the page cannot go away from under us:
we can delay the "increment page count" simply because we know somebody
else (the buffers) hold on to the page.

Which is not to say that I disagree with the patch itself: it tends to
be good practice to not depend on quite-so-subtle locking rules. It just
really shouldn't make any difference to the problem.

		Linus

