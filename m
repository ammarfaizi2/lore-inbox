Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVAECC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVAECC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAECC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:02:28 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:61267 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262174AbVAECAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:00:14 -0500
Message-ID: <41DB4A2B.1020005@yahoo.com.au>
Date: Wed, 05 Jan 2005 13:00:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-bkcurr: major slab corruption preventing booting on ARM
References: <20050104144350.A22890@flint.arm.linux.org.uk> <20050104161049.D22890@flint.arm.linux.org.uk> <20050104172118.B26816@flint.arm.linux.org.uk>
In-Reply-To: <20050104172118.B26816@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jan 04, 2005 at 04:10:49PM +0000, Russell King wrote:
> 
>>On Tue, Jan 04, 2005 at 02:43:50PM +0000, Russell King wrote:
>>
>>>I've had a report from a fellow ARM hacker of their platform not
>>>booting.  After they turned on slab debugging, they saw (pieced
>>>together from a report on IRC):
>>>
>>>Freeing init memory: 104K
>>>run_init_process(/bin/bash)
>>>Slab corruption: start=c0010934, len=160
>>>Last user: [<c00adc54>](d_alloc+0x28/0x2d8)
>>>
>>>I've just run up 2.6.10-bkcurr on a different ARM platform, and
>>>encountered the following output.  It looks like there's serious
>>>slab corruption issues in these kernels.
>>>
>>>I'll dig a little further into the report below to see if there's
>>>anything obvious.
>>
>>Ok, reverting the pud_t patch fixes both these problems (the exact
>>patch can be found at: http://www.home.arm.linux.org.uk/~rmk/misc/bk4-bk5
>>Note that this is not a plain bk4-bk5 patch, but just the pud_t
>>changes brought forward to bk6 or there abouts.)
>>
>>So, something in the 4 level page table patches is causing random
>>scribbling in kernel memory.
> 
> 
> Ok, I've narrowed the problem down to something in the following patch.
> Andi Kleen suggests that maybe the ARM FIRST_USER_PGD_NR got broken in
> by something here.  Nick, any ideas?
> 

I see you've had a fix commited to -bk? Yes that looks like it would
cause the problems you are seeing.

Thanks,
Nick
