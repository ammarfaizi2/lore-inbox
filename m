Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284304AbRLGSVu>; Fri, 7 Dec 2001 13:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284297AbRLGSVk>; Fri, 7 Dec 2001 13:21:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11538 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284282AbRLGSV0>; Fri, 7 Dec 2001 13:21:26 -0500
Date: Fri, 7 Dec 2001 10:15:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <20011207185847.A20876@wotan.suse.de>
Message-ID: <Pine.LNX.4.33.0112071013390.8465-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Dec 2001, Andi Kleen wrote:
>
> Your proposals sound rather dangerous. They would silently break recompiled
> threaded programs that need the locking and don't use -D__REENTRANT

No it wouldn't.

Once you do a pthread_create(), the locking is there.

Before you do a pthread_create(), it doesn't lock.

What's the problem? Before you do a pthread_create(), you don't _NEED_
locking, because there is only one thread that accesses the stdio data
structures.

And there are no races - if there is only one thread, then another thread
couldn't be suddenly doing a pthread_create() during a stdio operations.

Safe, and efficient. Yes, it adds a flag test or a indirect branch, but
considering that you avoid a serialized locking instruction, the
optimization sounds obvious.

		Linus

