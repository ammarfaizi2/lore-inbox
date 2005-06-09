Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVFJB0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVFJB0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 21:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVFJB0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 21:26:49 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:48315 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262345AbVFJB0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 21:26:44 -0400
Message-ID: <42A8891A.1070404@cyte.com>
Date: Thu, 09 Jun 2005 11:23:22 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@muc.de>
Subject: Re: amd64 cdrom access locks system
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org> <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org> <20050609163216.A18636@unix-os.sc.intel.com>
In-Reply-To: <20050609163216.A18636@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The answer to what timer is getting used appears to be:

   time.c: Using 3.579545 MHz PM timer.
   time.c: Detected 2612.615 MHz processor.
   time.c: Using HPET/TSC based timekeeping.

I'm still waiting for the compile to complete to test
Mr. Morton's workaround. Should have results posted
in about 15 minutes.

Thanks,

- Jeff

Venkatesh Pallipadi wrote:
> On Thu, Jun 09, 2005 at 04:00:45PM -0700, Andrew Morton wrote:
> 
>>Jeff Wiegley <jeffw@cyte.com> wrote:
>>
>>>warning: many lost ticks.
>>>Your time source seems to be instable or some driver is hogging interupts
>>>rip default_idle+0x24/0x30
>>>Falling back to HPET
>>>divide error: 0000 [1] PREEMPT
>>>...
>>>RIP: 0010:[<ffffffff80112704>] <ffffffff80112704>{timer_interrupt+244}
>>
>>The timer code got confused, fell back to the HPET timer and then got a
>>divide-by-zero in timer_interrupt().  Probably because variable hpet_tick
>>is zero.
>>
>>- It's probably a bug that the cdrom code is holding interrupts off for
>>  too long.
>>
>>  Use hdparm and dmesg to see whether the driver is using DMA.  If it
>>  isn't, fiddle with it until it is.
>>
>>- It's possibly a bug that we're falling back to HPET mode just because
>>  the cdrom driver is being transiently silly.
>>
>>- It's surely a bug that hpet_tick is zero after we've switched to HPET mode.
>>
>>
>>
>>
>>Please test this workaround:
>>
> 
> 
> Only reason I can see for hpet_tick to be zero is when there was some error 
> in hpet_init(), and we start using PIT. But, later we try to fallback to an 
> uninitilized HPET. 
> 
> Can you look at your dmesg before the hang and check what timer is getting used?
> The dmesg line will look something like this...
> 
> time.c: Using ______ MHz ___ timer.
> 
> Thanks,
> Venki


-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)
