Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRBJJ3Q>; Sat, 10 Feb 2001 04:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130911AbRBJJ3G>; Sat, 10 Feb 2001 04:29:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:30469 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130651AbRBJJ2z>;
	Sat, 10 Feb 2001 04:28:55 -0500
Date: Sat, 10 Feb 2001 10:28:29 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10102100958090.1007-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Rik van Riel wrote:

> On Thu, 8 Feb 2001, Alan Cox wrote:
> 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> > 
> > 2.4.1-ac7
> > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> > 	| This should make things feel a lot faster especially
> > 	| on small boxes .. feedback to Rik
> 
> I'd really like feedback from people when it comes to this
> change. The change /should/ fix most paging performance bugs
> because it makes kswapd do the right amount of work in order
> to solve the free memory shortage every time it is run.

Hi Rik,

This change makes my box swap madly under load.  It appears to be
keeping more cache around than is really needed, and therefore
having to resort to swap instead.  The result is MUCH more I/O than
previous kernels while doing the same exact job.

My test load is make -jN bzImage.  Previous kernels kept cache at
an average of ~20ish mb at a job level N at which level I had nearly
zero measurable throughput loss compared to single task compile.

>From that, I surmise that the cachable component of this job must
fit in that roughly 20ish mb of space.  (for otherwise, I would be
suffering throughput loss).  With this vm change, cache is nearly
three times as large as usual.  Where 30 tasks will run with only
modest throughput loss in ac5, ac8 throughput tapers off rapidly
at half of that.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
