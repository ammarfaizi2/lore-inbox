Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbTIFBe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265829AbTIFBe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:34:57 -0400
Received: from dyn-ctb-203-221-72-243.webone.com.au ([203.221.72.243]:11268
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265821AbTIFBew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:34:52 -0400
Message-ID: <3F5939AB.5080804@cyberone.com.au>
Date: Sat, 06 Sep 2003 11:34:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: azarah@gentoo.org
CC: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix IO hangs
References: <3F5833BA.5090909@cyberone.com.au>	 <20030905070426.GP840@suse.de> <3F583861.6070109@cyberone.com.au>	 <20030905071852.GQ840@suse.de>  <20030905083106.GC6658@suse.de> <1062799434.11604.1.camel@nosferatu.lan>
In-Reply-To: <1062799434.11604.1.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Schlemmer wrote:

>On Fri, 2003-09-05 at 19:04, Jens Axboe wrote:
>
>>On Fri, Sep 05 2003, Jens Axboe wrote:
>>
>>>>Jens, if insert_here is dead, there is no point to passing back a hint
>>>>because it can't get back to the elevator anyway.
>>>>
>>>>I'd very much like to kill insert_here and be done with it. If another
>>>>io scheduler comes along with a good use for it then the writers can
>>>>come up with an elegant solution ;) Hey, if they know a NO_MERGE return
>>>>means an insert will soon happen under the same lock, they could keep
>>>>it cached privately.
>>>>
>>>Agree, lets just kill it off.
>>>
>>Here's the patch that kills it and its associated logic off completely.
>>Nick, I'm not too sure what the logic was for stopping anticipation in
>>as_insert_request() (the insert_here tests were somewhat convoluted :),
>>I've added what I think makes most sense: stop anticipating if someone
>>puts a request at the head of the dispatch list.
>>
>>It also makes the *_insert_request strategies much easier to follow,
>>imo.
>>
>>
>
>Hmm, do not know if its just me, but I just got two processes (cp's)
>in D state.  They did complete though, but throughput was not good.
>Any tips on getting it debugged ?
>

If they complete at all, then its very unlikely for them to be slowed
down (AS can do this a bit though). If you could get a comparison with
my patch that started the problems backed out it might tell me
something. Thanks.


