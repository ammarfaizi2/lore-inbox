Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJaPSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJaPSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUJaPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:18:11 -0500
Received: from jade.aracnet.com ([216.99.193.136]:41181 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261234AbUJaPSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:18:05 -0500
Date: Sun, 31 Oct 2004 07:17:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: PG_zero
Message-ID: <40860000.1099235861@[10.10.2.4]>
In-Reply-To: <20041030140732.2ccc7d22.akpm@osdl.org>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Saturday, October 30, 2004 14:07:32 -0700):

> Andrea Arcangeli <andrea@novell.com> wrote:
>> 
>> I think it's much better to have PG_zero in the main page allocator than
>>  to put the ptes in the slab. This way we can share available zero pages with
>>  all zero-page users and we have a central place where people can
>>  generate zero pages and allocate them later efficiently.
> 
> Yup.
> 
>>  This gives a whole internal knowledge to the whole buddy system and
>>  per-cpu subsystem of zero pages.
> 
> Makes sense.  I had a go at this ages ago and wasn't able to demonstrate
> much benefit on a mixed workload.
> 
> I wonder if it would help if the page zeroing in the idle thread was done
> with the CPU cache disabled.  It should be pretty easy to test - isn't it
> just a matter of setting the cache-disable bit in the kmap_atomic()
> operation?

I looked at the basic problem a couple of years ago (based on your own code,
IIRC Andrew) then Andy (cc'ed) did it again with cache writethrough. It 
doesn't provide any benefit at all, no matter what we did, and it was 
finally ditched. 

I wouldn't bother doing it again personally ... perhaps Andy still has
the last set of results he can send to you.

M.

