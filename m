Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVBWXcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVBWXcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVBWXaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:30:23 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:905 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261710AbVBWX1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:27:53 -0500
Message-ID: <421D1171.7070506@yahoo.com.au>
Date: Thu, 24 Feb 2005 10:27:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
References: <1109182061.16201.6.camel@krustophenia.net>     <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>     <1109187381.3174.5.camel@krustophenia.net>     <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>     <1109190614.3126.1.camel@krustophenia.net> <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 23 Feb 2005, Lee Revell wrote:
> 
>>>>Thanks, your patch fixes the copy_pte_range latency.
>>
>>clear_page_range is also problematic.
> 
> 
> Yes, I saw that from your other traces too.  I know there are plans
> to improve clear_page_range during 2.6.12, but I didn't realize that
> it had become very much worse than its antecedent clear_page_tables,
> and I don't see missing latency fixes for that.  Nick's the expert.
> 

I wouldn't have thought it should have become worse, latency
wise. What is actually happening is that the lower level freeing
functions are being called more often. But this should result in
the work being spread out more, if anything. Rather than in the
old system things would tend to be batched up into bigger chunks
(typically at exit() time).

If you are using i386 with 2-level page tables (no highmem), then
the behaviour should be more or less identical. Odd.

Nick

