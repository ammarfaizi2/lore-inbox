Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUEIRSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUEIRSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 13:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUEIRSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 13:18:41 -0400
Received: from mail.tmr.com ([216.238.38.203]:18448 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264358AbUEIRSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 13:18:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped
   pages
Date: Sun, 09 May 2004 13:24:54 -0400
Organization: TMR Associates, Inc
Message-ID: <c7lovl$4ic$1@gatekeeper.tmr.com>
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>	<20040504180345.099926ec.akpm@osdl.org>	<40984E89.6070501@yahoo.com.au> <20040504195753.0a9e4a54.akpm@osdl.org> <40985C91.9080809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084122933 4684 192.168.12.10 (9 May 2004 17:15:33 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <40985C91.9080809@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>> So we need to understand why it was written, and what effects were
>> observed, with what workload, and all that good stuff.
>>
> 
> I guess it is an attempt to do somewhat better at dirty page accounting
> for mmap'ed pages. The balance_dirty_pages_ratelimited writeout path
> also has the same problem as you describe. Maybe usage patterns means
> this is less of an issue here?
> 
> But I suppose it wouldn't be nice to change without seeing some
> improvement somewhere.

Lots of issues here, writing in random blocks can lead to fragmentation 
if the data is newly allocated, but won't change fragmenting if the page 
mapped is alread allocated on the disk.

Is it practical or desirable to be writing mapped pages of allready 
allocated files back more readily, since it avoid all the allocation 
issues? But you still need to limit dirty pages, so at some point it 
will be necessary to do the allocation, preferably in an optimal way.

> 
>>
>>> It doesn't do the wakeup_bdflush thing, but that sounds
>>> like a good idea. What does wakeup_bdflush(-1) mean?
>>
>>
>>
>> It appears that it will cause pdflush to write out down to
>> dirty_background_ratio.
>>
> 
> Yeah. So wakeup_bdflush(0) would be more consistent?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
