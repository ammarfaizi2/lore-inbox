Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265744AbSJYAlQ>; Thu, 24 Oct 2002 20:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265745AbSJYAlP>; Thu, 24 Oct 2002 20:41:15 -0400
Received: from gaea.projecticarus.com ([195.10.228.71]:20145 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S265744AbSJYAlM>; Thu, 24 Oct 2002 20:41:12 -0400
Message-ID: <3DB8948D.3000003@walrond.org>
Date: Fri, 25 Oct 2002 01:47:09 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
References: <20021024230229.GA1841@vmware.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rebuilt 2.5.44 with the ACPI stuff enabled, and I see 2 cpus in 
/proc/cpuinfo:

    daedalus@hercules daedalus $ cat /proc/cpuinfo
    processor    : 0
    vendor_id    : GenuineIntel
    cpu family    : 15
    model        : 2
    model name    : Intel(R) XEON(TM) CPU 2.20GHz
    stepping    : 4
    cpu MHz        : 2200.469
    cache size    : 512 KB
    fdiv_bug    : no
    hlt_bug        : no
    f00f_bug    : no
    coma_bug    : no
    fpu        : yes
    fpu_exception    : yes
    cpuid level    : 2
    wp        : yes
    flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
    mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
    bogomips    : 4341.76

    processor    : 1
    vendor_id    : GenuineIntel
    cpu family    : 15
    model        : 2
    model name    : Intel(R) XEON(TM) CPU 2.20GHz
    stepping    : 4
    cpu MHz        : 2200.469
    cache size    : 512 KB
    fdiv_bug    : no
    hlt_bug        : no
    f00f_bug    : no
    coma_bug    : no
    fpu        : yes
    fpu_exception    : yes
    cpuid level    : 2
    wp        : yes
    flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
    mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
    bogomips    : 4390.91


Also dmesg says:

    daedalus@hercules daedalus $ dmesg
     1462.55 usecs.
    task migration cache decay timeout: 2 msecs.
    enabled ExtINT on CPU#0
    ESR value before enabling vector: 00000000
    ESR value after enabling vector: 00000000
    Booting processor 1/1 eip 2000
    Initializing CPU#1
    masked ExtINT on CPU#1
    ESR value before enabling vector: 00000000
    ESR value after enabling vector: 00000000
    Calibrating delay loop... 4390.91 BogoMIPS
    CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
    CPU: Trace cache: 12K uops, L1 D cache: 8K
    CPU: L2 cache: 512K
    CPU: Physical Processor ID: 0
    CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
    Intel machine check reporting enabled on CPU#1.
    CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
    CPU#1: Thermal monitoring enabled
    CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
    CPU:             Common caps: 3febfbff 00000000 00000000 00000000
    CPU1: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
    Total of 2 processors activated (8732.67 BogoMIPS).


And a bit further down...

    checking TSC synchronization across 2 CPUs: passed.
    Starting migration thread for cpu 0
    Bringing up 1
    CPU 1 IS NOW UP!
    Starting migration thread for cpu 1
    CPUS done 4294967295

And down some more we seem to have 4 cpus...

    ACPI: Processor [CPU0] (supports C1)
    ACPI: Processor [CPU1] (supports C1)
    ACPI: Processor [CPU2] (supports C1)
    ACPI: Processor [CPU3] (supports C1)

I think with ACPI disabled I had 4 processors listed in /proc/cpuinfo, 
but I'll check.



chrisl@vmware.com wrote:

>It seems that /proc/cpuinfo will return the number of logical CPU.
>If the machine has Intel Hyper-Thread enabled, that number is bigger
>than physical CPU number. Usually twice as big.
>
>My question is, what is the reliable way for user space program
>to detect the number of physical CPU in the current machine?
>
>If in it is in the kernel, I can read from cpu_sibling_map[]
>or phys_cpu_id[]. But it seems not easy read that from
>user space.
>
>Of course I can do "gdb /proc/kcore" to get them. But is there
>any better way?
>
>Thanks in advance.
>
>Chris
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


