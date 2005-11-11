Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVKKCuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVKKCuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 21:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVKKCuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 21:50:14 -0500
Received: from smtp-out.google.com ([216.239.45.12]:27771 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932283AbVKKCuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 21:50:13 -0500
Message-ID: <437406D4.4060304@google.com>
Date: Thu, 10 Nov 2005 18:49:56 -0800
From: Arun Sharma <arun.sharma@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
References: <20051109184623.GA21636@sharma-home.net>	<20051109222223.538309e4.akpm@osdl.org>	<43739302.1080404@google.com>	<20051110115941.1cbe1ae7.akpm@osdl.org>	<4373BE8D.2070104@google.com> <20051110140621.47729c5b.akpm@osdl.org>
In-Reply-To: <20051110140621.47729c5b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>>How important is this feature?
>>
>>Without this feature, an application has no way to figure out if a given 
>>segment is hugetlb or not. Applications need to know this to be able to 
>>handle alignment issues properly.
>>
>>Also, if the flag is exported via ipcs, the system administrator would 
>>have a better idea about how the hugetlb pages she configured on the 
>>system are getting used.
>>
> 
> 
> I'd suggest that any API which allows us to query the hugeness of a piece
> of memory should also work for mmap(hugetld_fd...).  IOW: this capability
> shouldn't be restricted to sysv shm areas.

The capability I was talking about was the ability to figure out where 
the configured hugetlb pages are going (vs is this a hugetlb page?).

I suspect that one can use lsof+/proc/pid/maps and look for hugetlbfs 
mount points to gather that data. But for shared memory hugepages, we 
don't have a way.

> But then again, if it was possible to write 100 lines of userspace code, we
> wouldn't need this capability at all.  I bet if the userspace guys tried a
> bit harder they'd work out a way of teaching their applications to remember
> what they did.

Why do we need shmctl(IPC_STAT) then? Applications should remember what 
they did :)

	-Arun
