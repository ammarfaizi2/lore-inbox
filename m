Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRACHxa>; Wed, 3 Jan 2001 02:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRACHxU>; Wed, 3 Jan 2001 02:53:20 -0500
Received: from www.wen-online.de ([212.223.88.39]:22283 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129413AbRACHxF>;
	Wed, 3 Jan 2001 02:53:05 -0500
Date: Wed, 3 Jan 2001 08:21:48 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.LNX.4.10.10101022151430.24870-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10101030814540.1271-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> On Wed, 3 Jan 2001, Mike Galbraith wrote:
> > 
> > No difference (except more context switching as expected)
> 
> What about the current prerelese patch in testing? It doesn't switch to
> bdflush at all, but instead does the buffer cleaning by hand.

99% gone.  The remaining 1% is refill_freelist().  If I use
flush_dirty_buffers() there instead of waiting, I have no more
semaphore timeouts (so far.. not thoroughly pounded upon). Without
that change, I still take hits.  (in my tinker tree, I usually
make a 'small flush' mode for flush_dirty_buffers() to do that)

Feel is _vastly_ improved.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
