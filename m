Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVAFFop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVAFFop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVAFFop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:44:45 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:21429 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262739AbVAFFon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:44:43 -0500
Message-ID: <41DCD047.9050707@yahoo.com.au>
Date: Thu, 06 Jan 2005 16:44:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au> <20050106052507.GR4597@dualathlon.random> <41DCCE53.4000906@yahoo.com.au>
In-Reply-To: <41DCCE53.4000906@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
>> On Thu, Jan 06, 2005 at 04:19:36PM +1100, Nick Piggin wrote:
>>
>>> This is practically what blk_congestion_wait does when the queue
>>> isn't congested though, isn't it?
>>
>>
>>
>> The fundamental difference that makes it reliable is that:
>>
>> 1) only the I/O we're throttling against will be considered for the
>>    wakeup event, which means only clearing PG_writeback will be
>>    considered eligible for wakeup
>>    Currently _all_ unrelated write I/O was considered eligible
>>    for wakeup events and that could cause spurious oom kills.
> 
> 
> I'm not entirely convinced. In Rik's case it didn't matter, because
> all his writeout was in the same zone that reclaim was happening
> against (ZONE_NORMAL), so in that case, PG_writeback throttling
> will do exactly the same thing as blk_congestion_wait.
> 
> I do like your PG_writeback throttling idea for the other reason
> that it should behave better on NUMA systems with lots of zones
> and lots of disks.
> 

... or Andrew's described fix. I think both would result in pretty
similar behaviour, but Andrew's is probably a bit nicer because it
doesn't require the scanner to have initiated the write.
