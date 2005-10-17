Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVJQXbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVJQXbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVJQXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:31:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11409 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932371AbVJQXbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:31:36 -0400
Message-ID: <43543455.4080206@pobox.com>
Date: Mon, 17 Oct 2005 19:31:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net>
In-Reply-To: <20051016005341.GB5946@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> On Oct 15 2005, at 06:40, Jeff Garzik was caught saying:
> 
>>Deepak Saxena wrote:
>>
>>>rewrite the damn thing to use the device model and have a rng
>>>device class with individual drivers for each RNG model, including
>>>IXP4xx. I'll keep the miscdev interface around but will add a
>>>new interface under /sys/class/rng that the userspace tools 
>>>can transition to. Is this OK with folks?
>>
>>How does the hardware export RNG functionality?  CPU insn?  Magic memory 
>>address?  Can it be done 100% in userspace?
> 
> 
> It's a magic regsiter we just read/write and could be done in userspace.
> I also took a look at MPC85xx and it has the same sort of interface but
> also has an error interrupt capability. On second thought a class
> interface is overkill b/c there will only be one RNG per system, so
> I can just do something like watchdogs where we have a bunch of simple
> drivers exposing the same interface. We could do it in user space but
> then we have separate RNG implementations for  x86 and !x86 and I'd
> rather not see that. Can we move the x86 code out to userspace and
> just let the daemon eat the numbers directly from HW? We can mmap() 
> PCI devices, but I don't know enough about x86 to say whether msr 
> instructions can execute out of userspace (or if we want them to...).

All of the hot path RNG stuff can and should be moved to userspace.

Right now the path is

	kernel /dev/hwrandom -> rngd -> add /dev/random entropy

All three current vendors shown in hw_random.c are doable in userspace. 
  Intel uses MMIO, AMD uses PIO, and VIA uses a specialized CPU 
instruction.  As HPA mentioned, you can use the MSR driver for control.

Patches welcome!  http://sf.net/projects/gkernel/

	Jeff




