Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWAUOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWAUOwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 09:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAUOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 09:52:13 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:32164 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750772AbWAUOwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 09:52:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Q0N7b6pPoiIrM5j5LKg7yNwXOMPAKTJkNXGn9qaVuDmDEWpZ1ibcCTnXClZGNjjgMoqkeiIc+4CilEeVhz6C54kfPUlmybb5ru/g+kRHVYbMRsO4Lasswj/8PBPd6f3lVmIJkyMtynKXihSUbcHPI6+8UfqUqJtQsIlxpMSOlgw=  ;
Message-ID: <43D24167.1010007@yahoo.com.au>
Date: Sun, 22 Jan 2006 01:12:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Don Dupuis <dondster@gmail.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Can't mlock hugetlb in 2.6.15
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com> <20060120235240.39d34279.akpm@osdl.org>
In-Reply-To: <20060120235240.39d34279.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Don Dupuis <dondster@gmail.com> wrote:
> 
>>I have an app that mlocks hugepages. The same app works just fine in 2.6.14.
>>This app has 128MB or more of shared memory that is using hugepages via
>>mmap. When I try this, I get the error "can't allocate memory".  Is this a
>>kernel bug or is this not supported anymore.  I want to guarantee that
>>this memory doesn't get swapped out to a swap device.
> 
> 
> hugetlb areas are not pageable and it's very unlikely that they will become
> so in the forseeable future.  So you don't need to do this.
> 
> That being said, we shouldn't have broken your application.
> 

Yep, and it does not sound unreasonable to have mlock succeed on hugepage
areas (though I'm not reading any standardese). And you wouldn't expect
mlockall to fail if an app is using hugepages either.

I don't have an idea off the top of my head though. Don, an strace log of
the failing sequence of syscalls could be helpful.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
