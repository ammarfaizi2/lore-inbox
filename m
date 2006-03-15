Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCOWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCOWao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWCOWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:30:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932124AbWCOWao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:30:44 -0500
Message-ID: <4418958E.7070200@garzik.org>
Date: Wed, 15 Mar 2006 17:30:38 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu>
In-Reply-To: <20060315215020.GA18241@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:
> 
> 
>>   <...>-2913  0d.h.    8us : raise_softirq_irqoff (blk_complete_request)
>>   <...>-2913  0d.h.    8us : __ata_qc_complete (ata_qc_complete)
>>   <...>-2913  0d.h.    9us : ata_host_intr (nv_interrupt)
>>   <...>-2913  0d.h.    9us!: ata_bmdma_status (ata_host_intr)
>>   <...>-2913  0d.h. 16641us : nv_check_hotplug_ck804 (nv_interrupt)
>>   <...>-2913  0d.h. 16642us : _spin_unlock_irqrestore (nv_interrupt)
>>   <...>-2913  0d.h. 16642us : smp_apic_timer_interrupt (apic_timer_interrupt)
>>   <...>-2913  0d.h. 16642us : exit_idle (smp_apic_timer_interrupt)
> 
> 
> ouch. The codepath in question (ata_host_intr()) doesnt seem to have any 
> loop that could take 16.6 msecs (!). This very much looks like some 
> hardware-triggered delay - some really screwed up DMA prioritization 
> perhaps, starving the host CPU for 16.6 msecs? But what DMA takes 16.6 
> msecs? That's enough time to transfer dozens of megabytes of data on a 
> midrange system.

Yeah, I don't see anything offhand either.

sata_nv's nv_interrupt() should be using spin_lock() rather than 
spin_lock_irqsave(), but I doubt that's a latency cause.

I would be surprised if the legacy PCI IDE registers, all PIO-based, 
would be implemented via BIOS SMM or some other similarly slow method. 
But its not impossible...

	Jeff



