Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWDYIfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWDYIfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWDYIfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:35:05 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:21657 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751403AbWDYIfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:35:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aVYivagxekbfC5bWROJwBVOXpGsKVs+XkAv1WZLGOnnDqIb27TJ893vKSH5deJ46XIDqhOoKCwOXiMqYt2SRT2/5Fm53s/SP2RMLbr4BwGnBL4HRMBnIRByqmpNEqxdpjvzSWBGEU0weQAkXhc6gHe0FwpSy13COVhRxnGeWYog=  ;
Message-ID: <444DD54B.7010908@yahoo.com.au>
Date: Tue, 25 Apr 2006 17:52:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       David Chinner <dgc@sgi.com>
Subject: Re: [PATCH] Direct I/O bio size regression
References: <200604242006.11758.a1426z@gawab.com> <20060424194910.GK29724@suse.de> <200604242359.14192.a1426z@gawab.com>
In-Reply-To: <200604242359.14192.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Jens Axboe wrote:
> 
>>On Mon, Apr 24 2006, Al Boldi wrote:
>>
>>>On my system max_hw_sectors_kb is fixed at 1024, and max_sectors_kb
>>>defaults to 512, which leads to terribly fluctuating thruput.
>>>
>>>Setting max_sectors_kb = max_hw_sectors_kb makes things even worse.
>>>
>>>Tuning max_sectors_kb to ~192 only stabilizes this situation.
>>
>>That sounds pretty strange. Do you have a test case?
> 
> 
> I would think that, if you could get your hands on some hw that defaults to 
> the same values, you may easily see the same problem by doing this:
> 
> 1. # vmstat 1 (or some other bio mon)
> 2. < change vt >
> 3. # cat /dev/hda > /dev/null &
> 4. # cat /dev/hda > /dev/null
> Let this second cat run for a sec, then ^C.
> Depending on your hw specifics the bio should either go up or down by a 
> factor of 2 (on my system 25mb/s-48mb/s).  You may have to repeat step 4 a 
> few times to aggravate the situation.
> 
> Note that this is not specific to cat, but can also be observed during normal 
> random disk access, although not in a controlled manner.

*random* disk access?

What io scheduler are you using? Can you try with as?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
