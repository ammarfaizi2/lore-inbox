Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBJFAZ>; Mon, 10 Feb 2003 00:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTBJFAZ>; Mon, 10 Feb 2003 00:00:25 -0500
Received: from unthought.net ([212.97.129.24]:16520 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261689AbTBJFAY>;
	Mon, 10 Feb 2003 00:00:24 -0500
Date: Mon, 10 Feb 2003 06:10:08 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, David Lang <david.lang@digitalinsight.com>,
       riel@conectiva.com.br, andrea@suse.de, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210051007.GE1109@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>,
	David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
	andrea@suse.de, ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org,
	axboe@suse.de
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E473172.3060407@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:58:26PM +1100, Nick Piggin wrote:
...
> >If we assume they are synchronous, that would be rather unfair
> >especially on multi-user systems - and the 90% accuracy that Rik
> >suggested would seem exaggerated to say the least (accuracy would be
> >more like 10% on a good day).
> >
> Remember that readahead gets scaled down quickly if it isn't
> getting hits. It is also likely to be sequential and in the
> track buffer, so it is a small cost.

I buy the sequential-argument - very good point.

Thanks,

> Huge readahead is a problem however anticipatory scheduling
> will hopefully allow good throughput for multiple read streams
> without requiring much readahead.

I'm curious as to how these things will interact in the NFS
server<->client situation  :)

Time will show, I guess.

Random data-point (not meant as a rant - I'm happy for all I got  ;)

In stock 2.4.20 the interaction is horrible - whatever was done there is
not optimal.    A 'tar xf' on the client will neither load the network
nor the server - it seems to be network latency bound (readahead not
doing it's job - changing min-readahead and max-readahead on the client
doesn't seem to make a difference). However, my desktop (running on the
client) can hang for 10 seconds straight every half hour or so, when the
nightly backup runs on the server (local disk reads streaming at around
2 MB/sec from an array capable of at least 40 MB/sec).

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
