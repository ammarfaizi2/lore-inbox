Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSIOHK3>; Sun, 15 Sep 2002 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSIOHK3>; Sun, 15 Sep 2002 03:10:29 -0400
Received: from holomorphy.com ([66.224.33.161]:16601 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317888AbSIOHK2>;
	Sun, 15 Sep 2002 03:10:28 -0400
Date: Sun, 15 Sep 2002 00:11:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] add vmalloc stats to meminfo
Message-ID: <20020915071157.GH3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D8422BB.5070104@us.ibm.com> <3D84340A.25ED4C69@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D84340A.25ED4C69@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>>  It is often hard to tell
>> whether this is because the area is too small, or just too fragmented.  This
>> makes it easy to determine.

On Sun, Sep 15, 2002 at 12:17:30AM -0700, Andrew Morton wrote:
> I do not recall ever having seen any bug/problem reports which this patch
> would have helped to solve.  Could you explain in more detai why is it useful?

LDT's were formerly allocated in vmallocspace. This presented difficulties
with many simultaneous threaded applications. Also, given that there is
zero vmallocspace OOM recovery now present in the kernel some method of
monitoring this aspect of system behavior up until the point of failure is
useful for detecting further problem areas (LDT's were addressed by using
non-vmalloc allocations).

Also, dynamic vmalloc allocations may very well be starved by boot-time
allocations on systems where much vmallocspace is required for IO memory.
The failure mode of such is effectively deadlock, since they block
indefinitely waiting for permanent boot-time allocations to be freed up.

Cheers,
Bill
