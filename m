Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTHMBee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 21:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271308AbTHMBee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 21:34:34 -0400
Received: from fmr06.intel.com ([134.134.136.7]:5859 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270818AbTHMBec convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 21:34:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 18:34:28 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AE9B@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNhNlcjRMlFc1eSQX6cRLw+PlGFygAAXqXA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 13 Aug 2003 01:34:29.0882 (UTC) FILETIME=[0A3695A0:01C3613B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salability means many things. I'm not sure which aspect you are talking
about, but a good thing with MSI is that it does not depend on I/O
APICs. A typical I/O APIC has 24 RTEs, and we need about 10 I/O APICs to
consume the vectors. 

You can make this scale on SMP systems. The vector-based approach would
be easier to extend it per-CPU because vectors are inherently per-CPU,
compared with IRQ-based. Today we have IRQ balancing as you know, and
the key part is to bind IRQ to a particular CPU (BTW, with our patch it
happens automatically because the balancer does not care if they are IRQ
or vector). 

Thanks,
Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Tuesday, August 12, 2003 5:49 PM
> To: Nakajima, Jun
> Cc: Jeff Garzik; Nguyen, Tom L; Linux Kernel; long
> Subject: RE: Updated MSI Patches
> 
> On Tue, 12 Aug 2003, Nakajima, Jun wrote:
> 
> > static unsigned int startup_edge_ioapic_vector(unsigned int vector)
> > {
> > 	int was_pending = 0;
> > 	unsigned long flags;
> > 	int irq = vector_to_irq (vector);
> >
> > 	spin_lock_irqsave(&ioapic_lock, flags);
> > 	if (irq < 16) {
> > 		disable_8259A_irq(irq);
> > 		if (i8259A_irq_pending(irq))
> > 			was_pending = 1;
> > 	}
> > 	__unmask_IO_APIC_irq(irq);
> > 	spin_unlock_irqrestore(&ioapic_lock, flags);
> >
> > 	return was_pending;
> > }
> 
> Hmm that doesn't look too bad, i like, ok another question, do you
think
> this could be made to scale on systems with lots of devices requiring
> vectors?
> 
> Thanks,
> 	Zwane

