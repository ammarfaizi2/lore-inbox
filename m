Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUKNNqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUKNNqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUKNNqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:46:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:3208 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261300AbUKNNp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:45:58 -0500
Date: Sun, 14 Nov 2004 13:51:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Shane Shrybman <shrybman@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114125159.GC11042@elte.hu>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <1100269881.10971.6.camel@mars> <20041112201334.GA14785@elte.hu> <1100303094.4880.6.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100303094.4880.6.camel@mars>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Shane Shrybman <shrybman@aei.ca> wrote:

> -#define IOAPIC_POSTFLUSH
> +//#define IOAPIC_POSTFLUSH

> -#if defined(CONFIG_PREEMPT_HARDIRQS) && defined(CONFIG_SMP)
> +#if defined(CONFIG_PREEMPT_HARDIRQS)

unfortunately the POST-flush is still needed. Without it i can see lots
of spurious interrupts on SMP systems. (most likely caused by the ACK
reaching the IO-APIC _before_ the mask-the-irq PCI-space write [which
gets delayed in the chipset due to write optimizations], so the IO-APIC
still thinks that the IRQ is enabled and for level-triggered IRQs this
means that another interrupt is sent to the CPU.)

	Ingo
