Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUBYUNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUBYUNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:13:17 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17025 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261304AbUBYUNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:13:08 -0500
Message-ID: <403D02E3.4070208@tmr.com>
Date: Wed, 25 Feb 2004 15:17:39 -0500
From: Bill Davidsen <davidsen@tmr.com>
Reply-To: bill davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IO scheduler, queue depth, nr_requests
References: <1qJVx-75K-15@gated-at.bofh.it> <1qJVx-75K-17@gated-at.bofh.it> <1qJVw-75K-11@gated-at.bofh.it> <1qLb8-6m-27@gated-at.bofh.it> <1qLXl-XV-17@gated-at.bofh.it> <1qMgF-1dA-5@gated-at.bofh.it> <1qTs3-7A2-51@gated-at.bofh.it> <1qTBB-7Hh-7@gated-at.bofh.it> <1r3AS-1hW-5@gated-at.bofh.it> <1r5jD-2RQ-31@gated-at.bofh.it> <1r6fH-3L8-11@gated-at.bofh.it> <1r6S4-6cv-1@gated-at.bofh.it>
In-Reply-To: <1r6S4-6cv-1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux.kernelNick Piggin wrote:

> But the whole reason it is getting blocked in the first place
> is because your controller is sucking up all your requests.
> The whole problem is not a problem if you use properly sized
> queues.
> 
> I'm a bit surprised that it wasn't working well with a controller
> queue depth of 64 and 128 nr_requests. I'll give you a per process
> request limit patch to try in a minute.

And there's the rub... he did try what you are calling correctly sized 
queues, and his patch works better. I'm all in favor of having the 
theory and then writing the code, but when something works I would 
rather understand why and modify the theory.

In other words, given a patch which does help performance in this case, 
it would be good to understand why, instead of favoring a solution which 
is better in theory, but which has been tried and found inferior in 
performance.

I am NOT saying we should just block, effective as Miquel's patch seems, 
just that we should understand why it works well instead of saying it is 
in theory bad. I agree, but it works! Hopefully per-process limits solve 
this, but they "in theory" could result in blocking a process in an 
otherwise idle system. Unless I midread what you mean of course. 
Processes which calculate for a while and write results are not uncomon, 
and letting such a process write a whole bunch of data and then go 
calculate while it is written is certainly the way it should work. I'm 
unconvinced that per-process limits are the whole answer without 
considering the entire io load on the system.

Feel free to tell me I'm misreading your intent (and why).
-- 
bill on the road <davidsen@tmr.com>
