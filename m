Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTBJHLO>; Mon, 10 Feb 2003 02:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTBJHLO>; Mon, 10 Feb 2003 02:11:14 -0500
Received: from [195.223.140.107] ([195.223.140.107]:39041 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263977AbTBJHLN>;
	Mon, 10 Feb 2003 02:11:13 -0500
Date: Mon, 10 Feb 2003 08:20:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David Lang <david.lang@digitalinsight.com>,
       Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210072038.GE31401@dualathlon.random>
References: <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <Pine.LNX.4.50L.0302100228140.12742-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302100228140.12742-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 02:29:20AM -0200, Rik van Riel wrote:
> On Sun, 9 Feb 2003, David Lang wrote:
> 
> > note that issuing a fsync should change all pending writes to 'syncronous'
> > as should writes to any partition mounted with the sync option, or writes
> > to a directory with the S flag set.
> 
> Exactly.  This is nasty with our current data structures;
> probably not something to do during the current code slush.

as I said, you can consider asychronous all requests submitted with
current->mm, this will be 90% accurate.  This whole thing is an
heuristic, if the heuristic fails the behaviour become like w/o SFQ so
no regression. Also the latency of fsync is less critical than the
latency of a read() syscall, again, this is statistically, sometime it
can be the other way around.

Andrea
