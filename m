Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbUKMA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUKMA6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbUKMA4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:56:33 -0500
Received: from mail.aei.ca ([206.123.6.14]:32992 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262665AbUKLXqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:46:20 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
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
In-Reply-To: <20041112201334.GA14785@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
	 <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
	 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <1100269881.10971.6.camel@mars>
	 <20041112201334.GA14785@elte.hu>
Content-Type: text/plain
Message-Id: <1100303094.4880.6.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 18:44:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 15:13, Ingo Molnar wrote:
> * Shane Shrybman <shrybman@aei.ca> wrote:
> 
> > V0.7.25-1 has been stable here with the ivtv driver for 11 hrs. No
> > sign of the ide dma time out issue either. Out of curiosity, do we
> > know what solved that problem?
> 
> could you try the attached patch - does it trigger the DMA timeouts
> again? There were 3 changes to the IOAPIC code that could have affected
> your dma-timeout problem, this patch reverts all of them.
> 

Ok, V0.7.25-1 seems to have resolved the DMA timeout problem.

I don't know how useful it is but this patch also seems to have resolved
that problem.

--- linux-2.6.10-rc1mm3-RT3/arch/i386/kernel/io_apic.c	2004-11-11 16:41:37.000000000 -0500
+++ linux-2.6.10-rc1mm3-RT3.T5/arch/i386/kernel/io_apic.c	2004-11-12 17:54:31.000000000 -0500
@@ -156,7 +156,7 @@
  * generate lots of spurious interrupts due to the POST-ed write not
  * reaching the IOAPIC before the IRQ is ACK-ed in the local APIC.
  */
-#define IOAPIC_POSTFLUSH
+//#define IOAPIC_POSTFLUSH
 
 static void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
@@ -1940,7 +1940,7 @@
  * unacked local APIC is dangerous on SMP as it can prevent the
  * delivery of IPIs and can thus cause deadlocks.)
  */
-#if defined(CONFIG_PREEMPT_HARDIRQS) && defined(CONFIG_SMP)
+#if defined(CONFIG_PREEMPT_HARDIRQS)
 
 static void mask_and_ack_level_ioapic_irq(unsigned int irq)
 {

Regards,

Shane

