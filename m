Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUHQUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUHQUXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268414AbUHQUW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:22:59 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:40082 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S268410AbUHQUWU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:22:20 -0400
Date: Tue, 17 Aug 2004 21:22:18 +0100
From: Jonathan Sambrook <beardie@dsvr.net>
To: linux-kernel@vger.kernel.org
Cc: John Riggs <jriggs@altiris.com>, greg@kroah.com
Subject: Re: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Message-ID: <20040817202218.GE21078@jsambrook>
References: <9B96255DE3B181429D06C6ADB0B37470232AFC@sandman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9B96255DE3B181429D06C6ADB0B37470232AFC@sandman.altiris.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:22 on Fri 06/08/04, jriggs@altiris.com masquerading as 'John Riggs' wrote:
> Summary: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
>   Please CC me on any replies.
> 
>   Hi, I am responsible for maintaining a pre-boot Linux environment, for
> which we use a 2.6.7 linux kernel, booted with the freeloader boot
> loader. Our environment works well on most systems, but on this
> particular model of laptop the kernel crashes before I get a shell
> prompt. From the stack trace, it appears to be crashing during the PCI
> device detection. The root filesystem is loaded into a ramdisk. The
> crash doesn't always reproduce, and I'm not sure what changes that it
> does or does not reproduce. But I see the crash on more than 50% of the
> reboots.
> 
> Oops output from ksymoops:
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000008
> c015f846
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c015f846>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246   (2.6.7)
> eax: 0000000f   ebx: df7ab1b8   ecx: c0270970   edx: 00007782
> esi: df7ab178   edi: 00000000   ebp: c0276554   esp: df775ef8
> ds: 007b   es: 007b   ss: 0068
> Stack: c024ade6 df7ab1b8 df7ab178 df7ab378 df602c00 c019045f 00000000
> c0276554
>        c01733b5 df7ab1f0 c0276554 df7ab1f0 df7ab238 c024e1d6 00000000
> 00000009
>        df602c00 df7ab378 00000009 00000001 c01734f4 df7ab378 df602c00
> 00000009
> Call Trace:
>  [<c019045f>]  [<c01733b5>]  [<c01734f4>]  [<c0173b6c>]  [<c0173cb9>]
> [<c023b34
> Code: 8b 47 08 5e 8d 48 68 ff 48 68 0f 88 64 01 00 00 8b 5d 00 53
> 
> 
> >>EIP; c015f846 <sysfs_add_file+16/a0>   <=====
> 
> >>ebx; df7ab1b8 <pg0+1f4e51b8/3fd38000>
> >>ecx; c0270970 <console_sem+0/10>
> >>esi; df7ab178 <pg0+1f4e5178/3fd38000>
> >>ebp; c0276554 <class_device_attr_cpuaffinity+0/14>
> >>esp; df775ef8 <pg0+1f4afef8/3fd38000>
> 
> Trace; c019045f <class_device_create_file+1f/30>
> Trace; c01733b5 <pci_alloc_child_bus+75/c0>
> Trace; c01734f4 <pci_scan_bridge+b4/200>
> Trace; c0173b6c <pci_scan_child_bus+8c/a0>
> Trace; c0173cb9 <pci_scan_bus_parented+119/140>
> 
> Code;  c015f846 <sysfs_add_file+16/a0>
> 00000000 <_EIP>:
> Code;  c015f846 <sysfs_add_file+16/a0>   <=====
>    0:   8b 47 08                  mov    0x8(%edi),%eax   <=====
> Code;  c015f849 <sysfs_add_file+19/a0>
>    3:   5e                        pop    %esi
> Code;  c015f84a <sysfs_add_file+1a/a0>
>    4:   8d 48 68                  lea    0x68(%eax),%ecx
> Code;  c015f84d <sysfs_add_file+1d/a0>
>    7:   ff 48 68                  decl   0x68(%eax)
> Code;  c015f850 <sysfs_add_file+20/a0>
>    a:   0f 88 64 01 00 00         js     174 <_EIP+0x174>
> Code;  c015f856 <sysfs_add_file+26/a0>
>   10:   8b 5d 00                  mov    0x0(%ebp),%ebx
> Code;  c015f859 <sysfs_add_file+29/a0>
>   13:   53                        push   %ebx
> 
>  <0>Kernel panic: Attempted to kill init!
> 
> 
> 
> Output from lspci -vvv: (Note: lspci seemed to be stuck in an infinite
> loop, printing the last two lines over and over)
> 00:00.0 Class f000: 0001:0000 (rev c3) (prog-if e2)
> 	Subsystem: 69d5:f000
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr+ Stepping+ SERR+ FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort+ <MAbort+ >SERR+ <PERR+
> 	Latency: 105 (60000ns max), cache line size d5
> 	Interrupt: pin (c) routed to IRQ 0
> 	BIST is running
> 	Region 0: I/O ports at <ignored>
> 	Region 1: Memory at <ignored> (64-bit, non-prefetchable)
> [disabled]
> 	Region 3: I/O ports at <ignored>
> 	Region 4: Memory at <ignored> (64-bit, prefetchable) [disabled]
> 	Expansion ROM at f0006800 [disabled] [size=2K]
> 
> 00:0d.0 Class c024: 0068:24cf (rev 60) (prog-if cf)
> 	Subsystem: 1c24:44c7
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping+ SERR+ FastB2B+
> 	Status: Cap+ 66Mhz- UDF+ FastB2B+ ParErr- DEVSEL=fast >TAbort+
> <TAbort- <MAbort+ >SERR+ <PERR-
> 	Interrupt: pin ,C (Brouted to IRQ 0
> 	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
> [disabled]
> 	Region 1: Memory at <ignored> (low-1M, prefetchable) [disabled]
> 	Region 2: Memory at <ignored> (low-1M, non-prefetchable)
> [disabled]
> 	Region 3: I/O ports at <ignored> [disabled]
> 	Region 4: I/O ports at <ignored> [disabled]
> 	Region 5: Memory at <ignored> (type 3, non-prefetchable)
> [disabled]
> 	Expansion ROM at <unassigned> [disabled] [size=2K]
> 
> 00:0e.0 Class 27bc: 6ce9:ffff (prog-if 8d)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop+
> ParErr+ Stepping+ SERR+ FastB2B-
> 	Status: Cap+ 66Mhz+ UDF+ FastB2B- ParErr- DEVSEL=?? >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Region 0: I/O ports at <ignored>
> 	Region 1: Memory at <ignored> (32-bit, non-prefetchable)
> 	Region 2: Memory at <ignored> (32-bit, non-prefetchable)
> 	Region 3: Memory at <ignored> (32-bit, non-prefetchable)
> 	Region 4: Memory at <ignored> (32-bit, non-prefetchable)
> 	Region 5: I/O ports at <ignored>
> 	Expansion ROM at 0001f800 [disabled] [size=2K]
> 
> 00:0f.0 Class 26b4: c483:e910 (rev 90) (prog-if 8d)
> 	Subsystem: 748d:0026
> 	Control: I/O- Mem- BusMaster+ SpecCycle+ MemWINV+ VGASnoop+
> ParErr- Stepping- SERR+ FastB2B+
> 	Status: Cap+ 66Mhz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+
> <TAbort+ <MAbort+ >SERR+ <PERR+
> 	Latency: 0 (34750ns min, 31000ns max)
> 	Interrupt: pin P routed to IRQ 0
> 	Region 0: I/O ports at <ignored> [disabled]
> 	Region 1: Memory at <ignored> (32-bit, non-prefetchable)
> [disabled]
> 	Region 2: I/O ports at <ignored> [disabled]
> 	Region 3: Memory at <ignored> (64-bit, non-prefetchable)
> [disabled]
> 	Region 5: Memory at <ignored> (32-bit, prefetchable) [disabled]
> 	Expansion ROM at e000b800 [disabled] [size=2K]
> 	Capabilities: [fc] #c0 [c8a1]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	Capabilities: [c0] #e8 [f9d4]
> 	Capabilities: [d8] #85 [2274]
> 	C
> 
> Listing of /proc/cpuinfo:
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 13
> model name	: Intel(R) Pentium(R) M processor 1.73GHz
> stepping	: 6
> cpu MHz		: 1734.122
> cache size	: 64 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca
> cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
> bogomips	: 3416.06
> 
> 
> Listing of /proc/ioports and /proc/iomem:
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 01f0-01f7 : ide0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> c000-efff : PCI Bus #4d
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000d0000-000d0fff : Adapter ROM
> 000d1000-000d2fff : Adapter ROM
> 000f0000-000fffff : System ROM
> 00100000-1f7cffff : System RAM
>   00100000-0023de35 : Kernel code
>   0023de36-0028a3ff : Kernel data
> 1f7d0000-1f7efbff : reserved
> 1f7efc00-1f7fafff : ACPI Non-volatile Storage
> 1f7fb000-1f7fffff : reserved
> 40800000-8b6fffff : PCI Bus #28
> e0000000-efffffff : reserved
> fec00000-fec01fff : reserved
> fed20000-fed9afff : reserved
> feda0000-fedbffff : reserved
> ffb00000-ffbfffff : reserved
> fff00000-ffffffff : reserved
> 
> I don't have /proc/scsi/scsi on my system, nor /proc/modules
> 
> Thank you,
> John
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                   
 Jonathan Sambrook 
Software  Developer 
 Designer  Servers
