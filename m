Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRAHV3M>; Mon, 8 Jan 2001 16:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAHV3D>; Mon, 8 Jan 2001 16:29:03 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:41975 "EHLO
	mf2.private") by vger.kernel.org with ESMTP id <S130497AbRAHV2x>;
	Mon, 8 Jan 2001 16:28:53 -0500
Date: Mon, 8 Jan 2001 13:30:56 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.21.0101081514180.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0101081312290.762-100000@mf2.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Rik van Riel wrote:

> How does 2.4 perform when you add an extra GB of swap ?

OK, some more data:

First, I tried booting 2.4.0 with "nosmp" to see if the behavior I observe
is SMP related.  It isn't, there was no difference under 2.4.0 between
512MB/512MB/1CPU and 512MB/512MB/2CPUs.

Second, I tried going to 2GB of swap with 2.4.0, so 512MB/2GB/2CPUs.
Again, there is no difference:  as soon as swapping begins with two MAGMA
processes, interactivity suffers.  I notice that while swapping in this
situation, the HD light is blinking only intermittently.

I also tried logging in to a fourth VT during this second test, and it got
nowhere.  In fact, this stopped the top updates completely and the HD
light also stopped.  After 30 seconds of nothing (all I could do is switch
VT's), I gave up and sent a ^Z to one MAGMA process; this eventually was
received, and the system immediately recovered.

Perhaps there is some sort of I/O starvation triggered by two swapping
processes?

Again, under 2.2.19pre6, the exact same tests yield hardly any loss of
interactivity, I can log in fine (a little slowly) during the top / two
MAGMA process test.  And once swapping begins, the HD light is continually
lit.

Again, I'd be happy to do any additional tests, provide more info about my
machine, etc.

Cheers,
Wayne




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
