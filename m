Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSA3ANO>; Tue, 29 Jan 2002 19:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSA3ALQ>; Tue, 29 Jan 2002 19:11:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287109AbSA3AKP>; Tue, 29 Jan 2002 19:10:15 -0500
Date: Tue, 29 Jan 2002 16:09:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <1012348838.817.50.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jan 2002, Robert Love wrote:
>
> This patch pushes the BKL out of llseek() and into the individual llseek
> methods.  For generic_file_llseek, I replaced it with the inode
> semaphore.

Thinking about that, that actally sounds like the _right_ thing to do even
from a correctness standpoint - as llseek() looks at the inode size, so we
should have that lock anyway.

So I'd suggest doing the inode semaphore globally, instead of using
kernel_lock at all.

Al?

		Linus

