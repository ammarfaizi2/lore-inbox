Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTCBXDC>; Sun, 2 Mar 2003 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTCBXDC>; Sun, 2 Mar 2003 18:03:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3745 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262038AbTCBXDB>; Sun, 2 Mar 2003 18:03:01 -0500
Date: Sun, 02 Mar 2003 15:13:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <87420000.1046646801@[10.10.2.4]>
In-Reply-To: <20030302221037.GK1195@holomorphy.com>
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Did you actually read the previous email? 
>> Same config file? Same tree? same compiler (gcc 2.95.4?)
> 
> gcc2.95.4; 2.5.63-bk5 w/& w/o, no patchkits prior, .config below

Wildly different config being compile tested => difference in speed.ls
 
>> I think we're talking about different things:
>> 1. Need to isolate what's causing the 6s improvement you're seeing.
>> Can you generate profiles & time output for before and after the patch,
>> and describe the test you're running (presumably make -j).
>> 2. SDET degredation. I'll try the additional patch you sent out on that.
> 
> It's not hard to figure out.

Part 2 may not be ... part 1 is ;-)

>>         60   125.0% page_address
>>         12    63.2% __pagevec_lru_add_active
>>         11    47.8% bad_range
>>         10    15.9% kmap_atomic
> 
> All users of page_zone(). The question you're (hopefully) about to
> answer is whether it was the division or something else like codesize
> or the newly introduced indirection.
> 
> If that is still seeing page_zone() suckage, I'll rip zone_table[] out
> of it entirely.

Still degraded: diffprofile:

       781     1.6% total
       346     1.0% default_idle
       217    10.1% __down
        79    12.0% __wake_up
        51    70.8% page_address
        32    66.7% kmap_atomic
        24     5.3% page_remove_rmap
        16    19.3% clear_page_tables
        14     4.6% release_pages
        13    33.3% path_release
        13     6.7% __copy_to_user_ll
        13   260.0% bad_range
        11     1.3% do_schedule
        10    15.6% pte_alloc_one

M.

