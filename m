Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTFYRxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTFYRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:53:14 -0400
Received: from dm2-58.slc.aros.net ([66.219.220.58]:60854 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264844AbTFYRxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:53:10 -0400
Message-ID: <3EF9E4D7.10106@aros.net>
Date: Wed, 25 Jun 2003 12:07:19 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd driver for 2.5+: cleanup PARANOIA usage & code
References: <Pine.LNX.4.10.10306251154160.11076-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10306251154160.11076-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>On Tue, 24 Jun 2003, Lou Langholtz wrote:
>
>  
>
>>This fifth patch cleans up usage of the PARANOIA sanity checking macro 
>>and code. This patch modifies both drivers/block/nbd.c and 
>>include/linux/nbd.h. It's intended to be applied incrementally on top of 
>>my fourth patch (4.1 really if you count the memset addition as .1's 
>>worth) that simply removed unneeded blksize_bits field. Again, I wanted 
>>to get this smaller change out of the way before my next patch will is 
>>much more major. Comments welcome.
>>    
>>
>
>Lou, any chance you could fix the requests_in, requests_out accounting? 
>What I mean is that _in and _out do not match up if, .e.g, there's an 
>error. This has been broken for a while, but since you're in there 
>touching the code, it might be easy for you to go ahead and fix it. 
>
>BTW, the other patches you've posted look good. I'm glad that you chose
>to avoid the multithreading idea, which would have broken compatibility 
>with older nbd's (and added a lot of complexity to the driver).
>
Hi Paul!

I've also noticed this mismatch. Not sure that this is a bug so much as 
just a question of sematics. I'm not sure what was originally intended 
for with these counters either. My latest patch (patch 6, 6.1 or maybe 
its not till 7) does change this though. Let me know if this change is 
what you're thinking of as a "fix".

With new accounting capabilities in gendisks and request_queues, I'm not 
sure how much use there is left for these request counters anymore. I 
don't know for certain, but I believe these are counted now in the new 
gendisk or request_queue accounting. So I have been eyeing these 
counters for removal (just so you know). Is there still definate use for 
these???

Thanks for looking at the other patches too. The multi-threading idea is 
loosing favor with me so long as I can get the blocking stratedgy 
working when sock is null. And I haven't heard from Steven as to the 
problem he thought they fixed. The blocking code is in my patch 7 
however which I haven't released yet. Wanted to get the ioctl user 
interface issues nailed first (before tackling changing the default 
semantics).

