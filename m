Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWIHA3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWIHA3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWIHA3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:29:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22187 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751889AbWIHA27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:28:59 -0400
Subject: Re: [Bug] [2.6.18-rc5-mm1] system no boot early death  x86_64
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: mel gorman <mel@csn.ul.ie>, andrew <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <1157653241.5653.37.camel@keithlap>
References: <1157653241.5653.37.camel@keithlap>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 07 Sep 2006 17:28:54 -0700
Message-Id: <1157675335.5653.66.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 11:20 -0700, keith mannthey wrote:
> Hello,
>   I was booting rc4-mm3.  With rc5-mm1 I am hanging early... Mel I don't
> know if this is related to your code but I will soon know. (I don't get
> your debug info in early console.)  
>   I was working on patches for the reserve based memory hot add path in
> srat.c (the initial error is fixed by Mels patches but there is more to
> do) and was just moving to rc5-mm1 to sync up and then more trouble.
> This is with reserve based hot-add not enabled at the command line. 


Well this isn't fully adding up but here is what I found. 

If I drop 
x86_64-mm-drop-640k-reservation.patch
x86_64-mm-remove-e820-fallback.patch
and 
x86_64-mm-remove-e820-fallback-fix.patch

I build and boot.  All files in the series upto x86_64-mm-drop-640k-
reservation.patch work just fine.  Dropping this patch makes things
better. The e820 patches were removed to make the rest of the series
apply.  

It is not clear what changes would cause me to die setting up the
bootmem allocator on my first node... 

I know x86_64-mm-drop-640k-reservation.patch has been around for a
while.  

any ideas?

Thanks,
  Keith 

(from a working boot)

disabling early console
Linux version 2.6.18-rc5-mm1-smp (root@elm3a153) (gcc version 4.1.0
(SUSE Linux)) #13 SMP Thu Sep 7 19:15:00 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000098400 (usable)
 BIOS-e820: 0000000000098400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff85e00 (usable)
 BIOS-e820: 000000007ff85e00 - 000000007ff98880 (ACPI data)
 BIOS-e820: 000000007ff98880 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000470000000 (usable)
 BIOS-e820: 0000001070000000 - 0000001160000000 (usable)
Entering add_active_range(0, 0, 152) 0 entries of 3200 used
Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
Entering add_active_range(0, 17235968, 18219008) 3 entries of 3200 used
end_pfn_map = 18219008
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @
0x00000000000fdcf0
ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98800
ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98780
ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98600
ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff983c0
ACPI: HPET (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98380
ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @
0x000000007ff90780
ACPI: SSDT (v001 IBM    VIGSSDT1 0x00001000 INTL 0x20030122) @
0x000000007ff88bc0
ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 3 -> Node 0
SRAT: PXM 0 -> APIC 38 -> Node 0
SRAT: PXM 0 -> APIC 39 -> Node 0
SRAT: PXM 0 -> APIC 36 -> Node 0
SRAT: PXM 0 -> APIC 37 -> Node 0
SRAT: PXM 1 -> APIC 64 -> Node 1
SRAT: PXM 1 -> APIC 65 -> Node 1
SRAT: PXM 1 -> APIC 66 -> Node 1
SRAT: PXM 1 -> APIC 67 -> Node 1
SRAT: PXM 1 -> APIC 102 -> Node 1
SRAT: PXM 1 -> APIC 103 -> Node 1
SRAT: PXM 1 -> APIC 100 -> Node 1
SRAT: PXM 1 -> APIC 101 -> Node 1
SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 152) 0 entries of 3200 used
Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-470000000
Entering add_active_range(0, 0, 152) 2 entries of 3200 used
Entering add_active_range(0, 256, 524165) 2 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
SRAT: Node 1 PXM 1 1070000000-1160000000
Entering add_active_range(1, 17235968, 18219008) 3 entries of 3200 used
NUMA: Using 36 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000470000000
Bootmem setup node 1 0000001070000000-0000001160000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 -> 18219008
early_node_map[4] active PFN ranges
    0:        0 ->      152
    0:      256 ->   524165
    0:  1048576 ->  4653056
    1: 17235968 -> 18219008
On node 0 totalpages: 4128541



