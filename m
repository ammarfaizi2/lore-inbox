Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279988AbRKSCch>; Sun, 18 Nov 2001 21:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280024AbRKSCc1>; Sun, 18 Nov 2001 21:32:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279988AbRKSCcR>; Sun, 18 Nov 2001 21:32:17 -0500
Date: Sun, 18 Nov 2001 18:27:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111181756260.7482-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111181820040.7500-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Linus Torvalds wrote:
>
> And a signal comes in. Even without the volatile, if gcc has written
> _anything_ else than 1 or 2 into the variable, gcc is BROKEN.

Side note: the Linux kernel depends on these kinds of quality-of-
implementation issues in several places. Thge "page->flags" thing is just
one small (and rather localized) case.

If you look at all the stuff that enforces memory ordering, they all
absolutely _require_ that gcc write exactly the value that we specify and
no other. This includes things like "policy" and "has_cpu" in the process
data structures, and "dumpable" in the "mm" structure.

If the compiler were to write random internal values to these variables
before writing the one we ask for, you'd get kernel crashes (has_cpu) or
strange and subtle security races (dumpable).

Oh, and I bet TCP would break horribly if gcc wrote internal temporary
values to the socket sequence numbers.

		Linus

