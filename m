Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTJTIIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTJTIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:08:45 -0400
Received: from dyn-ctb-210-9-246-89.webone.com.au ([210.9.246.89]:42759 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262337AbTJTIIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:08:42 -0400
Message-ID: <3F9397ED.8040004@cyberone.com.au>
Date: Mon, 20 Oct 2003 18:08:13 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, DEBUG_SLAB, oops in as_latter_request()
References: <m2ismlovep.fsf@p4.localdomain> <20031019142042.2f41eb68.akpm@osdl.org> <3F932B81.2040202@cyberone.com.au> <20031020070924.GU1128@suse.de>
In-Reply-To: <20031020070924.GU1128@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Mon, Oct 20 2003, Nick Piggin wrote:
>
>>
>>Andrew Morton wrote:
>>
>>
>>>Peter Osterlund <petero2@telia.com> wrote:
>>>
>>>
>>>>I was running 2.6.0-test8 compiled with CONFIG_DEBUG_SLAB=y. When
>>>>testing the CDRW packet writing driver, I got an oops in
>>>>as_latter_request. (Full oops at the end of this message.) It is
>>>>repeatable and happens because arq->rb_node.rb_right is uninitialized.
>>>>
>>>>
>>>deadline seems to have the same problem.
>>>
>>>We may as well squish this with the big hammer?
>>>
>>>
>>Thanks for the report, Peter.
>>
>>The request is a special request, so either blk_attempt_remerge should
>>never be called on it, or blk_attempt_remerge (or as_latter_request) should
>>check for this. Its up to Jens.
>>
>>I would say to stick something like
>>if (!rq_mergeable(rq))
>>   return;
>>
>>into blk_attempt_remerge.
>>
>>I'd say we shouldn't expect drivers to try to get this right.
>>
>
>attempt_merge() already includes such a check. To me it looks really
>buggy that elv_latter_request() cannot be called on non-fs requests, I'd
>rather get that fixed like Peter suggests. elv_latter_request() should
>work on all requests in the io sched queue, period.
>

I don't have a problem with that. Peter's patch it is.


