Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUAOWiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUAOWiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:38:08 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:61964 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262827AbUAOWho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:37:44 -0500
Message-ID: <40071742.10809@kolumbus.fi>
Date: Fri, 16 Jan 2004 00:42:10 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamesclv@us.ibm.com
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
References: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com> <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com> <200401151357.16807.jamesclv@us.ibm.com>
In-Reply-To: <200401151357.16807.jamesclv@us.ibm.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 16.01.2004 00:39:46,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 16.01.2004 00:38:59,
	Serialize complete at 16.01.2004 00:38:59
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Cleverdon wrote:

>On Wednesday 14 January 2004 8:36 pm, Zwane Mwaikambo wrote:
>  
>
>>On Wed, 14 Jan 2004, Nakajima, Jun wrote:
>>    
>>
>>>I tend to agree. I think the confusing part is the range of the IRQs on
>>>that machine. Assuming that irq_vector[NR_IRQ_VECTORS = 1024] requires
>>>more entries, then the IRQs should take that range, because
>>>IO_APCI_VECTOR(irq) is just irq_vector[irq], for example. If NR_IRQS is
>>>still 224, how can do_IRQ() can get the correct IRQ (i.e. >= 224) ? So
>>>in that case, the IRQ should be smaller than 224, then irq_vector[]
>>>should be smaller.
>>>      
>>>
>>In my opinion we should be breaking after we've exceeded the maximum
>>external vectors we can install. This will of course mean less than
>>the number of RTEs. James have you actually managed to use the devices
>>connected to the high (over ~224) RTEs?
>>    
>>
>
>No, I haven't exceeded the available vectors, but wli has on a large NUMA-Q 
>box.
>
>The x440 and x445's problems are pre-reserving lots of bus numbers in the 
>BIOS, more than one per PCI slot.  They must be anticipating PCI cards with 
>bridge chips on them.
>
>I believe that the reason for irq_vector being so large is to allow IRQ (and 
>eventually vector) sharing.  The array is to map from RTE to vector.
>  
>
Any attempt to  setup an irq >= NR_IRQS will crash, because for instance 
entry.c interrupt stubs are an array of NR_IRQS entries...NR_IRQ_VECTORS 
 > NR_IRQS really doesn't make sense as is.

We do support irq sharing among devices, but not vector sharing among 
irqs. For that the handler should loop through irq_vector[] to find 
every index, index != irq, irq_vector[index] == irq_vector[irq].

--Mika


