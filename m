Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280835AbRKBVIw>; Fri, 2 Nov 2001 16:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRKBVId>; Fri, 2 Nov 2001 16:08:33 -0500
Received: from 216-239-45-7.google.com ([216.239.45.7]:30542 "EHLO
	corp.google.com") by vger.kernel.org with ESMTP id <S280835AbRKBVIZ>;
	Fri, 2 Nov 2001 16:08:25 -0500
Message-ID: <3BE30B3D.1080505@google.com>
Date: Fri, 02 Nov 2001 13:08:13 -0800
From: Ben Smith <ben@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <15330.56589.291830.542215@abasin.nj.nec.com> <20011102190046.B6003@athlon.random> <20011102181758Z16039-4784+420@humbolt.nl.linux.org> <9ruvkd$jh1$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So how much memory is mlocked?


In the 3.5G case, we lock 4 blocks (4 * 427683520 bytes, or 1.631M). 
There is code in the kernel that prevents more than 1/2 of all physical 
pages from being mlocked:

mlock.c:215-218: (in do_mlock)

	/* we may lock at most half of physical memory... */
	/* (this check is pretty bogus, but doesn't hurt) */
	if (locked > num_physpages/2)
		goto out;


For 2.2 we were have a patch that increases this to 90% or 60M, but we 
don't use this patch on 2.4 yet.


> Why _does_ this thing do mlock, anyway? What's the point? And how much
> does it try to lock?


Latency. We know exactly what data should remain in memory, so we're 
trying to prevent the vm from paging out the wrong data. It makes a huge 
difference in performance.
  - Ben

Ben Smith
Google, Inc.

