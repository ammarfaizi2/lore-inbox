Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTE2URK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTE2URK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:17:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27087 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262593AbTE2URJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:17:09 -0400
Date: Thu, 29 May 2003 13:30:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-ID: <39810000.1054240214@[10.10.2.4]>
In-Reply-To: <20030529115237.33c9c09a.akpm@digeo.com>
References: <20030527004255.5e32297b.akpm@digeo.com><1980000.1054189401@[10.10.2.4]><18080000.1054233607@[10.10.2.4]> <20030529115237.33c9c09a.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, a 10x improvement isn't too bad.  I'm hoping the gap between ext2 and
> ext3 is mainly idle time and not spinning-on-locks time.
> 
> 
>> 
>>    2024927   267.3% total
>>    1677960   472.8% default_idle
>>     116350     0.0% .text.lock.transaction
>>      42783     0.0% do_get_write_access
>>      40293     0.0% journal_dirty_metadata
>>      34251  6414.0% __down
>>      27867  9166.8% .text.lock.attr
> 
> Bah.  In inode_setattr(), move the mark_inode_dirty() outside
> lock_kernel().

OK, will do. 

>>      20016  2619.9% __wake_up
>>      19632   927.4% schedule
>>      12204     0.0% .text.lock.sched
>>      12128     0.0% start_this_handle
>>      10011     0.0% journal_add_journal_head
> 
> hm, lots of context switches still.

I think that's ext3 busily kicking the living crap out of semaphores ;-)
See __down above ...

M.

