Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275248AbTHGJ0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275249AbTHGJ0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:26:54 -0400
Received: from dyn-ctb-203-221-72-79.webone.com.au ([203.221.72.79]:35848 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275248AbTHGJ0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:26:52 -0400
Message-ID: <3F321B4A.6060403@cyberone.com.au>
Date: Thu, 07 Aug 2003 19:26:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: queue reference counting
References: <20030806232810.GA1623@elf.ucw.cz> <20030806234036.GA209@elf.ucw.cz> <20030807080251.GY7982@suse.de> <3F3219DC.4070608@cyberone.com.au> <20030807092237.GB858@suse.de>
In-Reply-To: <20030807092237.GB858@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Thu, Aug 07 2003, Nick Piggin wrote:
>
>>
>>Jens Axboe wrote:
>>
>>
>>>On Thu, Aug 07 2003, Pavel Machek wrote:
>>>
>>>
>>>>Hi!
>>>>
>>>>
>>>>
>>>>>I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
>>>>>but it compiles ;-).
>>>>>
>>>>>
>>>>It compiles, it event boots, but it does not seem to have much effect
>>>>:-(.
>>>>
>>>>
>>>Now that the queue reference counting is in the current bk tree, we are
>>>that much closer to real modular io schedulers. I'll post the cfq with
>>>priorities for that.
>>>
>>>
>>OK, the QUEUE_FLAG_DEAD. I assume that will be set in blk_cleanup_queue?
>>Then all remaining requests are flushed out of the queue?
>>
>>This requires that a driver must be able to continue to process requests
>>during the call to blk_cleanup_queue, and that blk_cleanup_queue might
>>block, right? Is this acceptable, or should there be an earlier call to
>>set QUEUE_FLAG_DEAD and ensure queue is flushed?
>>
>
>The plan was to add blk_shutdown_queue() to do this. And then make sure
>AS checks the dead flag and doesn't hold back any requests.
>

Sounds sensible. Just ensuring I wasn't missing out on the fun.


