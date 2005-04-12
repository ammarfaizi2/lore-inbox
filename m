Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVDLOVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVDLOVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVDLOVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:21:25 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:45406 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262252AbVDLLJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:09:17 -0400
Message-ID: <425BAC55.7020506@yahoo.com.au>
Date: Tue, 12 Apr 2005 21:09:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Jens Axboe'" <axboe@suse.de>, Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504120803.j3C83tg06634@unix-os.sc.intel.com>
In-Reply-To: <200504120803.j3C83tg06634@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> On Tue, Apr 12 2005, Nick Piggin wrote:
> 
>>Actually the patches I have sent you do fix real bugs, but they also
>>make the block layer less likely to recurse into page reclaim, so it
>>may be eg. hiding the problem that Neil's patch fixes.
> 
> 
> Jens Axboe wrote on Tuesday, April 12, 2005 12:08 AM
> 
>>Can you push those to Andrew? I'm quite happy with the way they turned
>>out. It would be nice if Ken would bench 2.6.12-rc2 with and without
>>those patches.
> 
> 
> 
> I like the patch a lot and already did bench it on our db setup.  However,
> I'm seeing a negative regression compare to a very very crappy patch (see
> attached, you can laugh at me for doing things like that :-).
> 

OK - if we go that way, perhaps the following patch may be the
way to do it.

> My first reaction is that the overhead is in wait queue setup and tear down
> in get_request_wait function. Throwing the following patch on top does improve
> things a bit, but we are still in the negative territory.  I can't explain why.
> Everything suppose to be faster.  So I'm staring at the execution profile at
> the moment.
> 

Hmm, that's a bit disappointing. Like you said though, I'm sure we
should be able to get better performance out of this.

I'll look at it and see if we can rework it.

-- 
SUSE Labs, Novell Inc.

