Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBUBIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBUBIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBUBIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:08:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1968 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261167AbVBUBIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:08:17 -0500
Message-ID: <42193471.4020402@pobox.com>
Date: Sun, 20 Feb 2005 20:08:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       ncunningham@cyclades.com, kwijibo@zianet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
References: <88056F38E9E48644A0F562A38C64FB60040DBACB@scsmsx403.amr.corp.intel.com> <421769BD.4060606@pobox.com> <320350000.1108910651@[10.10.2.4]>
In-Reply-To: <320350000.1108910651@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Jeff Garzik <jgarzik@pobox.com> wrote (on Saturday, February 19, 2005 11:30:53 -0500):
> 
> 
>>Pallipadi, Venkatesh wrote:
>>
>>>You are right. Kernel balancer doesn't move around the irqs, unless it
>>>has too many interrupts. The logic is moving around interrupts all the
>>>time will not be good on caches. So, there is a threshold above which
>>>the balancer start moving things around.
>>>
>>>You should see them moving around if you do 'ping -f' or a big 'dd' from
>>>the disk.
>>
>>If kirqd is moving NIC interrupts, it's broken.
>>
>>(and another reason why irqbalanced is preferable)
> 
> 
> Why is it broken to move NIC interrupts? Obviously you don't want to
> rotate them around a lot, but in the interests of fairness to other 
> processes, it seems reasonable to migrate them occasionally (IIRC, kirqd
> rate limits to once a second or something).

This has been explained to you before, search your email archives...

The main problem that has been seen in the field SMP packet ordering, 
but a secondary problem observed is cache misses.  Just NAPI mitigates 
this somewhat (no pun intended).

Overall, kirqd should be avoided except in special situations.  It 
doesn't know about such policy things as network-specific or 
storage-specific irq balancing (and shouldn't).

	Jeff


