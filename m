Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSLBUio>; Mon, 2 Dec 2002 15:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSLBUio>; Mon, 2 Dec 2002 15:38:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32262 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264983AbSLBUin>;
	Mon, 2 Dec 2002 15:38:43 -0500
Date: Mon, 2 Dec 2002 21:45:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
Message-ID: <20021202204509.GA21070@alpha.home.local>
References: <20021202085610.GU16942@suse.de> <Pine.LNX.4.44L.0212021035130.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0212021035130.15981-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 10:38:40AM -0200, Rik van Riel wrote:
> OK, do you have a better idea on how to implement this thing ?

Hello !

Please excuse my ignorance of the internals, but from a neutral view, I think
that an efficient design could be like this :
  - not one, but two elevators, one for read requests, one for write requests.
  - may be one couple of these elevators for each physical device to ease
    parallelism, but I'm not sure.
  - we would process one of the request queues (either reads or writes), and
    after a user-settable amount of requests processed, we would switch to the
    other one if it contains pending requests. For each request processed, we
    would take a look at the other queue, to see if a request for a very close
    location exists, in which case we would also switch.

This would bring the advantage of the latency/throughput balance being
completely user-settable.

Please excuse me if it's impossible in the current design or if it's already
done this way and fails. I just wanted to add my 2 euro-cents here.

Comments ?

Cheers,
Willy

