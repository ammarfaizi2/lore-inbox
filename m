Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265685AbTBTWdK>; Thu, 20 Feb 2003 17:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbTBTWdK>; Thu, 20 Feb 2003 17:33:10 -0500
Received: from holomorphy.com ([66.224.33.161]:30881 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265685AbTBTWdJ>;
	Thu, 20 Feb 2003 17:33:09 -0500
Date: Thu, 20 Feb 2003 14:42:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       zwane@holomorphy.com, cw@f00f.org, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220224205.GD29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>, zwane@holomorphy.com,
	cw@f00f.org, linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20030220125021.03c6d39c.akpm@digeo.com> <Pine.LNX.4.44.0302202303400.4661-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302202303400.4661-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Andrew Morton wrote:
>> Fixes two deadlocks in the scheduler exit path:
>> 1: We're calling mmdrop() under spin_lock_irq(&rq->lock).  But mmdrop
>>    calls vfree(), which calls smp_call_function().  

On Thu, Feb 20, 2003 at 11:04:41PM +0100, Ingo Molnar wrote:
> this has been fixed in the -F3 scheduler patch.

Not quite. It leaks mm's because schedule_tail() isn't cleaning
up rq->prev_mm.


-- wli
