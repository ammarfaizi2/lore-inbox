Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWCOVxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCOVxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOVxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:53:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:54709 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751323AbWCOVxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:53:00 -0500
Date: Wed, 15 Mar 2006 22:50:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315215020.GA18241@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315213638.GA17817@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:

>    <...>-2913  0d.h.    8us : raise_softirq_irqoff (blk_complete_request)
>    <...>-2913  0d.h.    8us : __ata_qc_complete (ata_qc_complete)
>    <...>-2913  0d.h.    9us : ata_host_intr (nv_interrupt)
>    <...>-2913  0d.h.    9us!: ata_bmdma_status (ata_host_intr)
>    <...>-2913  0d.h. 16641us : nv_check_hotplug_ck804 (nv_interrupt)
>    <...>-2913  0d.h. 16642us : _spin_unlock_irqrestore (nv_interrupt)
>    <...>-2913  0d.h. 16642us : smp_apic_timer_interrupt (apic_timer_interrupt)
>    <...>-2913  0d.h. 16642us : exit_idle (smp_apic_timer_interrupt)

ouch. The codepath in question (ata_host_intr()) doesnt seem to have any 
loop that could take 16.6 msecs (!). This very much looks like some 
hardware-triggered delay - some really screwed up DMA prioritization 
perhaps, starving the host CPU for 16.6 msecs? But what DMA takes 16.6 
msecs? That's enough time to transfer dozens of megabytes of data on a 
midrange system.

	Ingo
