Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTBJEKl>; Sun, 9 Feb 2003 23:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTBJEKl>; Sun, 9 Feb 2003 23:10:41 -0500
Received: from [209.195.52.121] ([209.195.52.121]:36560 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S261530AbTBJEKk>; Sun, 9 Feb 2003 23:10:40 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Date: Sun, 9 Feb 2003 20:19:51 -0800 (PST)
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

note that issuing a fsync should change all pending writes to 'syncronous'
as should writes to any partition mounted with the sync option, or writes
to a directory with the S flag set.

David Lang

 On Mon, 10 Feb 2003, Rik van Riel
wrote:

> Date: Mon, 10 Feb 2003 02:15:10 -0200 (BRST)
> From: Rik van Riel <riel@conectiva.com.br>
> To: Andrea Arcangeli <andrea@suse.de>
> Cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
>      Jens Axboe <axboe@suse.de>
> Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
>     2.4.20-ck3 / aa / rmap with contest]
>
> On Mon, 10 Feb 2003, Rik van Riel wrote:
>
> > The only aspect of the anticipatory scheduler that is no longer needed
> > with your SFQ idea is the distinction between reads and writes, since
> > your idea already makes the (better, I guess) distinction between
> > synchronous and asynchronous requests.
>
> Forget that I said that, we don't have the infrastructure to
> get this right.  The definition of "synchronous" is "some
> process is waiting on this request to complete", but processes
> wait on other objects instead.
>
> A normal sequence (probably the most common) is:
>
> 1) submit request
>    (request is now asynchronous)
> 2) wait_on_page
>    (request should now magically become synchronous)
>
> The infrastructure to get this working is probably too big a
> change for 2.5/2.6, at this point, so chances are that we're
> better off using the (90% accurate?) distinction between reads
> and writes.
>
> regards,
>
> Rik
> --
> Bravely reimplemented by the knights who say "NIH".
> http://www.surriel.com/		http://guru.conectiva.com/
> Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
