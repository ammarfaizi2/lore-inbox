Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTDYIQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTDYIQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:16:35 -0400
Received: from dial-ctb0174.webone.com.au ([210.9.241.74]:26885 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263023AbTDYIQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:16:34 -0400
Message-ID: <3EA8F1AC.4080509@cyberone.com.au>
Date: Fri, 25 Apr 2003 18:28:28 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as-iosched:1210
References: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com> <3EA7A0CC.50005@cyberone.com.au> <20030424084717.GF8775@suse.de> <3EA81A3B.80800@cyberone.com.au> <20030424173228.GT8775@suse.de> <3EA8A5A7.3080003@cyberone.com.au> <20030425062329.GB1012@suse.de>
In-Reply-To: <20030425062329.GB1012@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Fri, Apr 25 2003, Nick Piggin wrote:
>
>>Jens Axboe wrote:
>>
>>
>>>On Fri, Apr 25 2003, Nick Piggin wrote:
>>>
>>>Exactly, the rest looks ok, the debug trigger is wrong :). The
>>>add_request() strategy is the entry point for all types of requests, not
>>>just blk_fs_request()
>>>
>>>
>>No but it is as_insert_request which is that entry point. It
>>should only calls as_add_request for a blk_fs_request.
>>
>
>Oh I see, yes you are right, I should have looked closer (I just assumed
>it was your elevator_add_req_fn, your naming is a bit funny :)
>
>The debug check is still a bit silly, and there's nothing that stops it
>from being wrong. So I'd still suggest to kill it.
>
Well the debug check is supposed to catch drivers which aren't
behaving nicely or if the reference counting is broken somewhere.

I suppose now that blk_put_request is being used to call
elv_completed_request then it should be pretty safe, right?

So I'll remove the debug stuff then

