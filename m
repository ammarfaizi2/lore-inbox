Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTAMTb7>; Mon, 13 Jan 2003 14:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268243AbTAMTb7>; Mon, 13 Jan 2003 14:31:59 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:13733 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267847AbTAMTb6>; Mon, 13 Jan 2003 14:31:58 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8E7@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 13:39:43 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sould it be hard_smp_processor_id()?

-----Original Message-----
From: Nakajima, Jun [mailto:jun.nakajima@intel.com]
Sent: Monday, January 13, 2003 12:00 PM
To: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh
Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
Kernel
Subject: RE: APIC version


The entries in acpi_version[] are indexed by the APIC id, not
smp_processor_id(). So you can overwrite acpi_version[] for a different
processor.

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
