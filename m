Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTAMUEW>; Mon, 13 Jan 2003 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTAMUEW>; Mon, 13 Jan 2003 15:04:22 -0500
Received: from fmr04.intel.com ([143.183.121.6]:62201 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267807AbTAMUEV> convert rfc822-to-8bit; Mon, 13 Jan 2003 15:04:21 -0500
content-class: urn:content-classes:message
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 12:12:52 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D1036@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC version
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7PbYFLb8pGycwEdeo8gBQi2jWzAAAP1Kw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 20:12:52.0800 (UTC) FILETIME=[27184C00:01C2BB40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing you need to do is 
	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-	processor.mpc_apicver = 0x10; /* TBD: lapic version */
+	processor.mpc_apicver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) |

Jun

> -----Original Message-----
> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]
> Sent: Monday, January 13, 2003 11:55 AM
> To: 'Martin J. Bligh'; Nakajima, Jun; Protasevich, Natalie; Pallipadi,
> Venkatesh
> Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
> Kernel
> Subject: RE: APIC version
> 
> 
> The thing is, this array never gets filled with correct values for XAPICs
> in
> case when we go through ACPI, not MP.
> I only care about it because that is how I used to distinguish Cascades
> from
> Fosters on ES7000 (which I need to do very early, before I get to APIC
> mode
> setup).
> 
> On the other hand, I just noticed that I could go with smp_num_siblings
> for
> this purpose... so if this issue is too shady as of now, i will survive, I
> guess...:)
> 
> --Natalie
> 
> 
> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> Sent: Monday, January 13, 2003 12:26 PM
> To: Nakajima, Jun; Protasevich, Natalie; Pallipadi, Venkatesh
> Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
> Kernel
> Subject: RE: APIC version
> 
> 
> > The entries in acpi_version[] are indexed by the APIC id, not
> smp_processor_id(). So you can overwrite acpi_version[] for a different
> processor.
> 
> >> +	apic_version[smp_processor_id()] =
> 
> Ugh.
> 
> It's indexed by the apic ID, not the cpu id. They're not 1-1.
