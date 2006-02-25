Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWBYRW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWBYRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBYRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:22:58 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:61627 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932515AbWBYRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:22:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=buXJKWpGsPykQqe4vn/YoKeRdKcRwUSrqzWy6KvHN8ElwI5Seit2TchYEiYMska5EXTtwfIrkVS/QuknIxnjR2h0RLBH0K9pPiTRUZmUH0xG9jRVEtM2hcpCQDnLyuXH1uIFl/eSAOszqyQWIshAVwdGSUzn174b82dFTjuLxeY=  ;
Message-ID: <44009269.1000704@yahoo.com.au>
Date: Sun, 26 Feb 2006 04:22:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, andrea@suse.de
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140772543.2874.20.camel@laptopd505.fenrus.org> <43FED128.1030500@yahoo.com.au> <200602241327.27390.ak@suse.de> <44008A73.4030804@yahoo.com.au>
In-Reply-To: <44008A73.4030804@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Here is a forward port of my scalability improvement, untested.
> 
> Unfortunately I didn't include absolute performance results, but the
> changelog indicates that there was some noticable delta between the
> rwsem implementations (and that's what I vaguely remember).
> 
> Note: this was with volanomark, which can be quite variable at the
> best of times IIRC.
> 
> Note2: this was on a 16-way NUMAQ, which had the interconnect
> performance of a string between two cans compared to a modern x86-64
> of smaller size, so it may be harder to notice an improvement.
> 

Oh, I remember one performance caveat of this code on preempt kernels:
at very high loads, (ie. lots of tasks being woken in the up path),
the wakeup code would end up doing a lot of context switches to and
from the tasks it is waking up.

This could be easily solved by disabling preempt (and would be still
better in terms of interrupt latency and lock hold times), however I
never got around to implementing that.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
