Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSIESas>; Thu, 5 Sep 2002 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSIESas>; Thu, 5 Sep 2002 14:30:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318044AbSIESar>; Thu, 5 Sep 2002 14:30:47 -0400
Date: Thu, 5 Sep 2002 11:38:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, Suparna Bhattacharya <suparna@in.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <20020905183117.GA22592@suse.de>
Message-ID: <Pine.LNX.4.33.0209051136090.1307-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Jens Axboe wrote:
> 
> However, I don't see how this is a two-liner change. Basically you are
> changing bi_end_io() from a completion to partial completion invokation,

Right. So we'll add one

	bio->bi_end_io(bio, nr_sectors)

to the partial bio completion case in "finish_that_request_first()".

That's one line.

The other line is

	if (bio->bi_size) return;

which has to be added to the end-request thing.

(yeah, yeah, there are several end-request functions, and we need to fix 
up the function prototypes too etc, but the point is that the actual 
_work_ is just two real lines of new code).

			Linus

