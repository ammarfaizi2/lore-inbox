Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSFOJK6>; Sat, 15 Jun 2002 05:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSFOJK6>; Sat, 15 Jun 2002 05:10:58 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:46236 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315191AbSFOJK5>; Sat, 15 Jun 2002 05:10:57 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 02:10:53 -0700
Message-Id: <200206150910.CAA00831@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	So, I need a fourth location at in generic_make_request
>> just before the call to q->make_request_fn, like so:
>> 
>> 	if (q->make_request_fn != __make_request) {
>> 		int flags;
>> 		spin_lock_irqsave(q->lock, flags);
>> 		clear_hint(bio);
>> 		spin_unlock_irqrestore(q->lock, flags);
>> 	}
>> 	ret = q->make_request_fn(q, bio);

>Irk, this is ugly. But how you are moving away from the initial goal (or
>maybe this was your goal the whole time, just a single merge hint?) of
>passing back the hint instead of maintaing it in the queue. So let me
>ask, are you aware of the last_merge I/O scheduler hint? Which does
>exactly this already...

	The code that I think I more or less have in my head has not
changed (aside from that fourth test).

	Although I was not aware of q->last_merge, I see that it is
not what I want.  I want up to one hint per request, for the last bio
in the request.  bi_hint would be null for all bio's except possibly
the last bio in a request.  I do not want just one hint per queue.

	If it is unclear what I mean, perhaps I really need to code it
up to explain it. and we can discuss it from there.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
