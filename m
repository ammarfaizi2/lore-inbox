Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUJ0FvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUJ0FvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUJ0FvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:51:00 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:58229 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261655AbUJ0Fug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:50:36 -0400
Message-ID: <417F3720.40307@yahoo.com.au>
Date: Wed, 27 Oct 2004 15:50:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <20041027044445.GV14325@dualathlon.random> <Pine.LNX.4.44.0410270049250.21548-100000@chimarrao.boston.redhat.com> <20041027050527.GW14325@dualathlon.random>
In-Reply-To: <20041027050527.GW14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Oct 27, 2004 at 12:51:11AM -0400, Rik van Riel wrote:
> 
>>On Wed, 27 Oct 2004, Andrea Arcangeli wrote:
>>
>>
>>>what we'll happen is that we'll blindly free a few pages from each zone,
>>>but then we'll be allowed to allocate the highmem pages, and not the
>>>normal/dma pages. So after allocating the highmem pages we invoke kswapd
>>>again and it frees again some highmem/normal/dma pages but we keep only
>>>using the highmem ones.  So for a while we may be rolling over only the
>>>highmem lru and ignoring all freed pages from the normal/dma zones.
>>

That's what I mean when I say it can overscan the lower zones.
You don't want to change the stop condition here though because
obviously the highmem zone still has work to do - you just want
to stop scanning the lower zones.

I don't think it is a big problem though.

I do have a patch to make it use the lower zone protection watermarks
explicitly, but it is sitting on top of other stuff which I'm going
to try to get merged first...
