Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUAOV55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUAOV54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:57:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14538 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263310AbUAOV5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:57:53 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Thu, 15 Jan 2004 13:57:16 -0800
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
References: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com> <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401151357.16807.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 January 2004 8:36 pm, Zwane Mwaikambo wrote:
> On Wed, 14 Jan 2004, Nakajima, Jun wrote:
> > I tend to agree. I think the confusing part is the range of the IRQs on
> > that machine. Assuming that irq_vector[NR_IRQ_VECTORS = 1024] requires
> > more entries, then the IRQs should take that range, because
> > IO_APCI_VECTOR(irq) is just irq_vector[irq], for example. If NR_IRQS is
> > still 224, how can do_IRQ() can get the correct IRQ (i.e. >= 224) ? So
> > in that case, the IRQ should be smaller than 224, then irq_vector[]
> > should be smaller.
>
> In my opinion we should be breaking after we've exceeded the maximum
> external vectors we can install. This will of course mean less than
> the number of RTEs. James have you actually managed to use the devices
> connected to the high (over ~224) RTEs?

No, I haven't exceeded the available vectors, but wli has on a large NUMA-Q 
box.

The x440 and x445's problems are pre-reserving lots of bus numbers in the 
BIOS, more than one per PCI slot.  They must be anticipating PCI cards with 
bridge chips on them.

I believe that the reason for irq_vector being so large is to allow IRQ (and 
eventually vector) sharing.  The array is to map from RTE to vector.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
