Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136091AbRECALS>; Wed, 2 May 2001 20:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136092AbRECALI>; Wed, 2 May 2001 20:11:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136091AbRECAK4>; Wed, 2 May 2001 20:10:56 -0400
Date: Wed, 2 May 2001 17:10:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Duc Vianney <dvianney@us.ibm.com>
cc: <castortz@nmu.edu>, Bill Hartner <bhartner@us.ibm.com>,
        <staelin@hpl.hp.com>, Larry McVoy <lm@bitmover.com>,
        <lse-tech@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <lmbench-users@bitmover.com>
Subject: Re: your mail
In-Reply-To: <OF8F1A4043.9087C91A-ON85256A40.0079DA30@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.31.0105021658170.24914-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 May 2001, Duc Vianney wrote:
>
> Has anyone seen performance degradations between 2.2.19 and 2.4.x

Yes.

The signal handling one is because 2.4.x will save off the full SSE2
state, which means that the signal stack is almost 700 bytes, as compared
to <200 before. This is sadly necessary to be able to take advantage of
the SSE2 instructions - and on special applications the win can be quite
noticeable. This one you won't be able to avoid, although you shouldn't
see it on older hardware that do not have SSE2 (you see it because you
have a PIII).

You don't say how much memory you have, but the file handling ones might
be due to a really unfortunate hash thinko that cause the dentry hash to
be pretty much useless on machines that have 512MB of RAM (it can show up
in other cases, but 512M is the case that makes the hash really become a
non-hash). If so, it should be fixed in 2.4.2.

2.4.4 will give noticeably better numbers for fork and fork+exec. However,
the scheduling optimization that does that actually breaks at least
"bash", and it appears that we will just undo it during the stable series.
Even if the bug is obviously in user land (and a fix is available), stable
kernels shouldn't try to hide the problems.

			Linus

