Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTBJEFv>; Sun, 9 Feb 2003 23:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTBJEFv>; Sun, 9 Feb 2003 23:05:51 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:28042 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261370AbTBJEFu>; Sun, 9 Feb 2003 23:05:50 -0500
Date: Mon, 10 Feb 2003 02:15:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
 <20030209144622.GB31401@dualathlon.random>
 <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Rik van Riel wrote:

> The only aspect of the anticipatory scheduler that is no longer needed
> with your SFQ idea is the distinction between reads and writes, since
> your idea already makes the (better, I guess) distinction between
> synchronous and asynchronous requests.

Forget that I said that, we don't have the infrastructure to
get this right.  The definition of "synchronous" is "some
process is waiting on this request to complete", but processes
wait on other objects instead.

A normal sequence (probably the most common) is:

1) submit request
   (request is now asynchronous)
2) wait_on_page
   (request should now magically become synchronous)

The infrastructure to get this working is probably too big a
change for 2.5/2.6, at this point, so chances are that we're
better off using the (90% accurate?) distinction between reads
and writes.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
