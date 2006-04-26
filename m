Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWDZTl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWDZTl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWDZTl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:41:58 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:58788 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964856AbWDZTl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=12xzH4vvPDIdiipt4T31aFKH0dt8LUiL4r6a3VYQZW4LpVtFAkHF2MzLc8sL+4AgO6946lmt4eYoZoPNKO4LoG3saOpN9pQXNFRJcwhCXYpKQa316YE0dWcxueWmbcScVlSoFsdkjzVQB7SsZcybZm5JIaXhilx2aHp0+vfnQjU=  ;
Message-ID: <444F8714.9060808@yahoo.com.au>
Date: Thu, 27 Apr 2006 00:43:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de>
In-Reply-To: <20060426135310.GB5083@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> Running a splice benchmark on a 4-way IPF box, I decided to give the
> lockless page cache patches from Nick a spin. I've attached the results
> as a png, it pretty much speaks for itself.
> 
> The test in question splices a 1GiB file to a pipe and then splices that
> to some output. Normally that output would be something interesting, in
> this case it's simply /dev/null. So it tests the input side of things
> only, which is what I wanted to do here. To get adequate runtime, the
> operation is repeated a number of times (120 in this example). The
> benchmark does that number of loops with 1, 2, 3, and 4 clients each
> pinned to a private CPU. The pinning is mainly done for more stable
> results.

Thanks Jens!

It's interesting, single threaded performance is down a little. Is
this significant? In some other results you showed me with 3 splices
each running on their own file (ie. no tree_lock contention), lockless
looked slightly faster on the same machine.

In my microbenchmarks, single threaded lockless is quite a bit faster
than vanilla on both P4 and G5.

It could well be that the speculative get_page operation is naturally
a bit slower on Itanium CPUs -- there is a different mix of barriers,
reads, writes, etc. If only someone gave me an IPF system... ;)

As you said, it would be nice to see how this goes when the other end
are 4 gigabit pipes or so... And then things like specweb and file
serving workloads.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
