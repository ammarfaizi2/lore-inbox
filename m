Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWE3FVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWE3FVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWE3FVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:21:08 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:34206 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932118AbWE3FVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:21:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VwNh5HMuFz0SMAqrruLjK3g/oFtrKMGyZ5iT/ecApvPF3piS9zFMSSFUefeZx9LT9AUCPn8Zx9Oqto/D3qX9WCMsvNjm5fXthRTrrKyr/trGVl6ePgVDpRliju5G5u8TRMCyISQ5EROHzKcv3bWIjxpXo3EaTos+HL+0MNi8W9M=  ;
Message-ID: <447BD63D.2080900@yahoo.com.au>
Date: Tue, 30 May 2006 15:21:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au>
In-Reply-To: <447BD31E.7000503@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Linus Torvalds wrote:
> 
>>
>> Why do you think the IO layer should get larger requests?
> 
> 
> For workloads where plugging helps (ie. lots of smaller, contiguous
> requests going into the IO layer), should be pretty good these days
> due to multiple readahead and writeback.

Let me try again.

For workloads where plugging helps (ie. lots of smaller, contiguous
requests going into the IO layer), the request pattern should be
pretty good without plugging these days, due to multiple page
readahead and writeback.


> 
>>
>> I really don't understand why people dislike plugging. It's obviously 
>> superior to non-plugged variants, exactly because it starts the IO 
>> only when _needed_,

Taken to its logical conclusion, you are saying readahead / dirty
page writeout throttling is obviously inferior, aren't you?

Non-rhetorically: Obviously there can be regressions in plugging,
because you are holding the disk idle when you know there is work to
be done.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
