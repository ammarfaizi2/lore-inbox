Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbRETCg6>; Sat, 19 May 2001 22:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbRETCgs>; Sat, 19 May 2001 22:36:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51718 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261384AbRETCgc>; Sat, 19 May 2001 22:36:32 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: DVD blockdevice buffers
Date: 19 May 2001 19:36:07 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9e7ain$lis$1@penguin.transmeta.com>
In-Reply-To: <20010518210226.A7147@moserv.hasi> <20010518212531.A6763@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010518212531.A6763@suse.de>, Jens Axboe  <axboe@suse.de> wrote:
>> 
>> As a result the system performance goes down. I'm still able to use
>> my applications, but es every single piece of unused memory is swapped
>> out, and swapping in costs a certain amount of time.
>
>That's why streaming media applications like a dvd player should use raw
>I/O -- to bypass system cache. See /dev/raw*

I disagree.. 

The fact is that the block device fs infrastructure is just sadly
broken. By using the buffer cache, it makes memory management very hard,
and just upgrading to the page cache would (a) speed stuff up and (b)
make it much easier for the kernel to do the right thing wrt the MM use.

Right now we don't try to aggressively drop streaming pages, but it's
possible. Using raw devices is a silly work-around that should not be
needed, and this load shows a real problem in current Linux (one soon to
be fixed, I think - Andrea already has some experimental patches for the
page-cache thing).

		Linus
