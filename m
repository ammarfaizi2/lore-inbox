Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUJ0Dit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUJ0Dit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUJ0DgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:36:11 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:40379 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261345AbUJ0Del (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:34:41 -0400
Message-ID: <417F1746.2080607@yahoo.com.au>
Date: Wed, 27 Oct 2004 13:34:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au> <20041027022920.GS14325@dualathlon.random> <417F0FA2.4090800@yahoo.com.au> <20041027032338.GU14325@dualathlon.random>
In-Reply-To: <20041027032338.GU14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Oct 27, 2004 at 01:01:54PM +1000, Nick Piggin wrote:
> 
>>Currently it does not overschedule, because one zone is always
>>going to be low by the time kswapd wakes up. This causes all zones
>>below to be scanned as well.
> 
> 
> that's quite subtle (after all it's needed only for the numa pgdats) and
> I agree on the wakeup side, the one thing that is wrong instead is the
> kswapd-stop side. On that side you really need to know every single zone
> that has to be balanced.  So whatever, you can't just use pages_high
> there. I'm creating a zone->max_lowmem_reserve to fix that efficiently
> (that's recalculated every time with the sysctl and at boot).
> 
> However my patch to wakeup_kswapd sure wouldn't hurt there.
> 

You do though... it is right as is (sort of).

It actually can overscan lower zones a little bit, because
whenever any higher zone in the pgdat is low on memory, then
it and all zones below it get scanned too.

So if HIGHMEM is low on memory, NORMAL and DMA get scanned
as well regardless. If NORMAL is low, then DMA gets scanned
as well.
