Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268409AbTAMXoi>; Mon, 13 Jan 2003 18:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268393AbTAMXog>; Mon, 13 Jan 2003 18:44:36 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:24460 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268409AbTAMXoe>; Mon, 13 Jan 2003 18:44:34 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8EB@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 17:49:16 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you index it by 4-bit GET_APIC_ID() (not GET_APIC_LOGICAL_ID()), i.e.
hard_smp_processor_id(), you can get away with it.

Of course, it is possible that it can just be "don't care":

>I don't think the array apic_version[] is very helpful in the first place.
>I suspect it can be __init. 

>Jun

On the other hand, it might be needed if imagine hot plug CPU case.


--Natalie



-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com]
Sent: Monday, January 13, 2003 4:23 PM
To: Zwane Mwaikambo; Nakajima, Jun
Cc: Protasevich, Natalie; Pallipadi, Venkatesh; William Lee Irwin III;
Christoph Hellwig; James Cleverdon; Linux Kernel
Subject: RE: APIC version


>> The entries in acpi_version[] are indexed by the APIC id, not 
>> smp_processor_id(). So you can overwrite acpi_version[] for a different 
>> processor.
> 
> Is it possible to use smp_processor_id instead to avoid wasting memory 
> for the sparse APIC id case?

No, the array is set up in mpparse.c before we know the real processor 
numbers.

M.
