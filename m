Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTFBUXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbTFBUXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:23:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39918 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262297AbTFBUUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:20:53 -0400
Message-ID: <3EDBB4B0.6070601@mvista.com>
Date: Mon, 02 Jun 2003 13:33:52 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at>
In-Reply-To: <3EDBA83B.5050406@xss.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Haumer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> (I've already reported this previously as post scriptum
> to a different bugreport, so it might have slipped through
> unnoticed...)
> 
> I have a quite strange phenomenon here: I see a ~2.5 times
> speed up of system time on a Asus AP1700-S5 server with
> Linux-2.4.21-rc6-ac1.
> Simple proof: a "sleep 300" command terminates after exactly
> 120 seconds of wall clock time.

Just as a wild shot in the dark, what speed does the kernel think the 
cpu is running at and does this match what the BIOS thinks?

It sounds like the CLOCK_TICK_RATE is wrong.  This would show up as 
the kernel thinking the cpu was fast also.

You pin this to a particular kernel version.  Do other kernel versions 
do a better job?

-g

> 
> Or just look at this:
> root@setup:~ {544} $ ntpdate ntp.xss.co.at; ntpdate ntp.xss.co.at; sleep 300; ntpdate ntp.xss.co.at
>  2 Jun 21:24:45 ntpdate[3768]: step time server 194.152.162.17 offset -38.679740 sec
>  2 Jun 21:24:45 ntpdate[3769]: adjust time server 194.152.162.17 offset -0.069998 sec
>  2 Jun 21:26:45 ntpdate[3786]: step time server 194.152.162.17 offset -180.053781 sec
> 
> Impressive, isn't it?
> 
> This "acceleration" of time shows with other time measures,
> like "date", system uptime, process time, etc., too.
> 
> (HZ is still defined as 100, I haven't changed anything in
> the kernel sources)
> 
> System info:
> 
> Asus AP1700-S5, Asus PR-DLS533 Motherboard, Intel Xeon 2.4GHz CPU, 512MB RAM
> 
> root@setup:~ {545} $ uname -a
> Linux setup 2.4.21-rc6-ac1 #1 SMP Sat May 31 20:04:18 CEST 2003 i686 unknown
> 
> root@setup:~ {546} $ lspci -v
> 00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
>         Flags: fast devsel
> 
> 00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
>         Flags: fast devsel
> 
> 00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
>         Flags: fast devsel
> 
> 00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
>         Subsystem: Intel Corp. 82540EM Gigabit Ethernet Controller
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
>         Memory at fd800000 (32-bit, non-prefetchable) [size=128K]
>         I/O ports at d800 [size=64]
>         Capabilities: [dc] Power Management version 2
>         Capabilities: [e4] PCI-X non-bridge device.
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 
> 00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc: Unknown device 8008
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 46
>         Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>         I/O ports at d400 [size=256]
>         Memory at fb800000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at febe0000 [disabled] [size=128K]
>         Capabilities: [5c] Power Management version 2
> 
> 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
>         Subsystem: ServerWorks CSB5 South Bridge
>         Flags: bus master, medium devsel, latency 32
> 
> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
>         Subsystem: ServerWorks CSB5 IDE Controller
>         Flags: bus master, medium devsel, latency 64
>         I/O ports at <ignored>
>         I/O ports at <ignored>
>         I/O ports at <ignored>
>         I/O ports at <ignored>
>         I/O ports at a800 [size=16]
> 
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
>         Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         Memory at fb000000 (32-bit, non-prefetchable) [size=4K]
> 
> 00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
>         Subsystem: ServerWorks: Unknown device 0230
>         Flags: bus master, medium devsel, latency 0
> 
> 00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
>         Flags: 66Mhz, medium devsel
>         Capabilities: [60]
> 00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
>         Flags: 66Mhz, medium devsel
>         Capabilities: [60]
> 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
>         Flags: 66Mhz, medium devsel
>         Capabilities: [60]
> 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
>         Flags: 66Mhz, medium devsel
>         Capabilities: [60]
> 02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
>         Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
>         Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 22
>         I/O ports at a000 [size=256]
>         Memory at fa000000 (64-bit, non-prefetchable) [size=64K]
>         Memory at f9800000 (64-bit, non-prefetchable) [size=64K]
>         Expansion ROM at fe900000 [disabled] [size=1M]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>         Capabilities: [68]
> 02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
>         Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
>         Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 23
>         I/O ports at 9800 [size=256]
>         Memory at f9000000 (64-bit, non-prefetchable) [size=64K]
>         Memory at f8800000 (64-bit, non-prefetchable) [size=64K]
>         Expansion ROM at fe800000 [disabled] [size=1M]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>         Capabilities: [68]
> 03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
>         Subsystem: Intel Corp.: Unknown device 110d
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
>         Memory at f8000000 (64-bit, non-prefetchable) [size=128K]
>         Memory at f7800000 (64-bit, non-prefetchable) [size=128K]
>         I/O ports at 9400 [size=32]
>         Expansion ROM at fe7e0000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>         Capabilities: [e4] PCI-X non-bridge device.
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 
> root@setup:~ {547} $ cat /proc/interrupts
>            CPU0       CPU1
>   0:    1737732    1760169    IO-APIC-edge  timer
>   1:        260        260    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:         10         10    IO-APIC-edge  serial
>  15:          5         17    IO-APIC-edge  ide1
>  18:   22903530   23147515   IO-APIC-level  eth0
>  22:    1695902    1726918   IO-APIC-level  ioc0
>  23:         25         17   IO-APIC-level  ioc1
> NMI:          0          0
> LOC:    1398848    1398847
> ERR:          0
> MIS:          0
> 
> Any ideas?
> 
> - - andreas
> 
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQE+26g5xJmyeGcXPhERAj4tAJ98iFyniQ2N3P0jKkfQqla2GBVKXwCbBr36
> +2kB0HBIKcVXA+lkxAXeVMU=
> =Xk1O
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

