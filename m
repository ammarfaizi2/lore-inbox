Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbTAMSuy>; Mon, 13 Jan 2003 13:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbTAMSuy>; Mon, 13 Jan 2003 13:50:54 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:18043 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267972AbTAMSuw> convert rfc822-to-8bit; Mon, 13 Jan 2003 13:50:52 -0500
content-class: urn:content-classes:message
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 10:59:35 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D1026@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC version
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7M9RRzP1KbSckEdeo8gBQi2jWzAAAQYRw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 18:59:36.0316 (UTC) FILETIME=[EA9613C0:01C2BB35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The entries in acpi_version[] are indexed by the APIC id, not smp_processor_id(). So you can overwrite acpi_version[] for a different processor.

Jun


> -----Original Message-----
> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]
> Sent: Monday, January 13, 2003 10:44 AM
> To: 'Martin J. Bligh'; Pallipadi, Venkatesh
> Cc: 'William Lee Irwin III'; Nakajima, Jun; 'Christoph Hellwig'; 'James
> Cleverdon'; 'Linux Kernel'; Protasevich, Natalie
> Subject: APIC version
> 
> I have a little patch here for the APIC version.
> Without it, I get version 0x10 instead of 0x14 for Fosters/Gallatins
> (booting with ACPI):
> 
> --- mpparse.c.org	2003-01-13 11:32:18.000000000 -0700
> +++ mpparse.c	2003-01-13 11:33:26.000000000 -0700
> @@ -773,6 +773,8 @@
>  	if (boot_cpu_physical_apicid == -1U)
>  		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
> 
> +	apic_version[smp_processor_id()] =
> GET_APIC_VERSION(apic_read(APIC_LVR));
> +
>  	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
>  }
> 
> @@ -795,7 +797,7 @@
> 
>  	processor.mpc_type = MP_PROCESSOR;
>  	processor.mpc_apicid = id;
> -	processor.mpc_apicver = 0x10; /* TBD: lapic version */
> +	processor.mpc_apicver = apic_version[smp_processor_id()];
>  	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
>  	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
>  	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) |
> 
> 
> It seems to work OK for me, although you may find some implications...
> Anyway -
> 
> Thanks,
> 
> --Natalie
