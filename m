Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272609AbTHEKFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTHEKFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:05:49 -0400
Received: from [203.221.74.83] ([203.221.74.83]:6929 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S272609AbTHEKFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:05:48 -0400
Message-ID: <3F2F8146.6030301@cyberone.com.au>
Date: Tue, 05 Aug 2003 20:04:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <20030804230337.703de772.akpm@osdl.org> <200308051726.14501.kernel@kolivas.org> <200308051012.12951.oliver@neukum.org>
In-Reply-To: <200308051012.12951.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oliver Neukum wrote:

>Am Dienstag, 5. August 2003 09:26 schrieb Con Kolivas:
>
>>On Tue, 5 Aug 2003 16:03, Andrew Morton wrote:
>>
>>>We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so they
>>>can submit more IO and go back to sleep.  Remember that we are artificially
>>>leaving the disk head idle in the expectation that the task will submit
>>>more I/O.  It's pretty sad if the CPU scheduler leaves the anticipated task
>>>in the doldrums for five milliseconds.
>>>
>>Indeed that has been on my mind. This change doesn't affect how long it takes 
>>to wake up. It simply prevents tasks from getting full interactive status 
>>during the period they are doing unint. sleep.
>>
>
>If you take that to its logical conclusion, such tasks should be woken
>immediately. Likewise, the io scheduler should be notified when you know
>that the task won't do io or will do other io, like waiting on character
>devices, go paging out or terminate.
>

I don't think that is the logical conclusion because you are balancing
against other things.

As for the io scheduler, no, there is a lot that can be done (including
waiting on character devs) before it is no longer worth keeping the disk
waiting. AS really doesn't care in the slightest what a process does
between submitting IOs*, what is important is simply its IO pattern.

* except exit which is an easy case of course.


