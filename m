Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHVICJ>; Thu, 22 Aug 2002 04:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSHVICJ>; Thu, 22 Aug 2002 04:02:09 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41991
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318017AbSHVICD>; Thu, 22 Aug 2002 04:02:03 -0400
Date: Thu, 22 Aug 2002 01:05:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
In-Reply-To: <5.1.0.14.0.20020822083701.009eaec0@legolas.dynup.net>
Message-ID: <Pine.LNX.4.10.10208220104100.11626-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SWEET, that give me a comparison point to check.
Please try with DMA off on the burn to isolate if net logic in the changes
is bad or if it is the DMA engine part.


On Thu, 22 Aug 2002, Rudmer van Dijk wrote:

> Hi Alan, Andre,
> 
> I have tried all 2.4.20-pre2-acX and found them stable until I tried to 
> burn a CD with -ac6...
> 
> the burner is an ide device, and after reading the changelog I decided to 
> give it a try:
> 
> I used cdrecord (via Xcdroast) and the burning never started due to the 
> fact that a kernel bug appeeared and the first cdrecord instance became a 
> zombie and the second got stuck in D state.
> 
> meanwhile (after the bug) the kernel was spitting out these messages 
> (around 4-5 a second):
> <snip>
> Aug 22 00:16:27 gandalf kernel: SCSI host 0 abort (pid 1784) timed out - 
> resetting
> Aug 22 00:16:27 gandalf kernel: SCSI bus is being reset for host 0 channel 0.
> Aug 22 00:16:27 gandalf kernel: scsi : aborting command due to timeout : 
> pid 1785, scsi0, channel 0, id 1, lun 0 0x1e 00 00 00 01 00
> Aug 22 00:16:27 gandalf kernel: SCSI host 0 abort (pid 1785) timed out - 
> resetting
> Aug 22 00:16:27 gandalf kernel: SCSI bus is being reset for host 0 channel 0.
> Aug 22 00:16:27 gandalf kernel: scsi : aborting command due to timeout : 
> pid 1782, scsi0, channel 0, id 1, lun 0 0x2a 00 00 00 00 00 00 00 1f 00
> Aug 22 00:16:27 gandalf kernel: SCSI host 0 abort (pid 1782) timed out - 
> resetting
> Aug 22 00:16:27 gandalf kernel: SCSI bus is being reset for host 0 channel 0.
> Aug 22 00:16:27 gandalf kernel: scsi : aborting command due to timeout : 
> pid 1783, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
> Aug 22 00:16:27 gandalf kernel: SCSI host 0 abort (pid 1783) timed out - 
> resetting
> Aug 22 00:16:27 gandalf kernel: SCSI bus is being reset for host 0 channel 0.
> Aug 22 00:16:27 gandalf kernel: scsi : aborting command due to timeout : 
> pid 1784, scsi0, channel 0, id 1, lun 0 0x1e 00 00 00 01 00
> Aug 22 00:16:27 gandalf kernel: SCSI host 0 abort (pid 1784) timed out - 
> resetting
> Aug 22 00:16:27 gandalf kernel: SCSI bus is being reset for host 0 channel 0.
> Aug 22 00:16:27 gandalf kernel: scsi : aborting command due to timeout : 
> pid 1785, scsi0, channel 0, id 1, lun 0 0x1e 00 00 00 01 00
> <snip>
> 
> well the pid's are strange, since the two cdrecord instances were pid 433 
> and 434...
> 
> the oops (through ksymoops):
> 
> rudmer:~ # ksymoops -L -m /boot/System.map-2.4.20-pre2-ac6 < oops
> ksymoops 2.4.3 on i686 2.4.20-pre2-ac6.  Options used
>       -V (default)
>       -k /proc/ksyms (default)
>       -L (specified)
>       -o /lib/modules/2.4.20-pre2-ac6/ (default)
>       -m /boot/System.map-2.4.20-pre2-ac6 (specified)
> 
> No modules in ksyms, skipping objects
> Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in 
> System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol 
> GPLONLY_ip_conntrack_expect_find_get not found in System.map.  Ignoring 
> ksyms_base entry
> Warning (compare_maps): ksyms_base symbol GPLONLY_ip_conntrack_expect_put 
> not found in System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol GPLONLY_ip_conntrack_find_get not 
> found in System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol GPLONLY_ip_conntrack_put not 
> found in System.map.  Ignoring ksyms_base entry
> Aug 22 00:02:21 gandalf kernel: kernel BUG in header file at line 157
> Aug 22 00:02:21 gandalf kernel: kernel BUG at panic.c:286!
> Aug 22 00:02:21 gandalf kernel: invalid operand: 0000
> Aug 22 00:02:21 gandalf kernel: CPU:    0
> Aug 22 00:02:21 gandalf kernel: 
> EIP:    0010:[__out_of_line_bug+15/32]    Not tainted
> Aug 22 00:02:21 gandalf kernel: EFLAGS: 00010286
> Aug 22 00:02:21 gandalf kernel: eax: 00000026   ebx: 00007800   ecx: 
> cdb9002c   edx: c32b0000
> Aug 22 00:02:21 gandalf kernel: esi: 00000002   edi: c1360000   ebp: 
> 00000000   esp: c32b1b90
> Aug 22 00:02:21 gandalf kernel: ds: 0018   es: 0018   ss: 0018
> Aug 22 00:02:21 gandalf kernel: Process cdrecord (pid: 433, stackpage=c32b1000)
> Aug 22 00:02:21 gandalf kernel: Stack: c0229e40 0000009d c01c7be1 0000009d 
> c1363000 c02db588 ceacb140 ceacf800
> Aug 22 00:02:21 gandalf kernel:        00000014 c1360014 00000002 c1360000 
> c01c7ddb c02db4d8 ceacb140 c02db4d8
> Aug 22 00:02:21 gandalf kernel:        c02db588 ceacb140 ceacf800 00000000 
> 00000000 c02db4d8 c01c8389 c02db588
> Aug 22 00:02:21 gandalf kernel: Call Trace:    [ide_build_sglist+321/384] 
> [ide_build_dmatable+91/416] [__ide_dma_write+41/288] [<d1b74963>] [<d1b74acb>]
> Aug 22 00:02:21 gandalf kernel:   [<d1b67ed1>] [<d1b67376>] [<d1b673ca>] 
> [<d1b61802>] [<d1b88f0b>] [<d1b89dd0>]
> Aug 22 00:02:21 gandalf kernel:   [<d1b88d1b>] [<d1b89158>] 
> [__alloc_pages+99/704] [reclaim_page+567/608] [__alloc_pages_limit+108/144] 
> [__alloc_pages+152/704]
> Aug 22 00:02:21 gandalf kernel: Code: 0f 0b 1e 01 66 9e 22 c0 eb fe 8d b4 
> 26 00 00 00 00 8a 54 24
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Trace; d1b67ed0 <END_OF_CODE+118870bc/????>
> Trace; d1b67376 <END_OF_CODE+11886562/????>
> Trace; d1b673ca <END_OF_CODE+118865b6/????>
> Trace; d1b61802 <END_OF_CODE+118809ee/????>
> Trace; d1b88f0a <END_OF_CODE+118a80f6/????>
> Trace; d1b89dd0 <END_OF_CODE+118a8fbc/????>
> Trace; d1b88d1a <END_OF_CODE+118a7f06/????>
> Trace; d1b89158 <END_OF_CODE+118a8344/????>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>     0:   0f 0b                     ud2a
> Code;  00000002 Before first symbol
>     2:   1e                        push   %ds
> Code;  00000002 Before first symbol
>     3:   01 66 9e                  add    %esp,0xffffff9e(%esi)
> Code;  00000006 Before first symbol
>     6:   22 c0                     and    %al,%al
> Code;  00000008 Before first symbol
>     8:   eb fe                     jmp    8 <_EIP+0x8> 00000008 Before 
> first symbol
> Code;  0000000a Before first symbol
>     a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
> Code;  00000010 Before first symbol
>    11:   8a 54 24 00               mov    0x0(%esp,1),%dl
> 
> 
> 5 warnings issued.  Results may not be reliable.
> 
> 
> 
> messages after loading the scsi-ide and friends modules:
> Aug 21 23:57:25 gandalf kernel:   Vendor: IOMEGA    Model: ZIP 
> 100           Rev: 23.D
> Aug 21 23:57:25 gandalf 
> kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
> Aug 21 23:57:25 gandalf kernel:   Vendor: HL-DT-ST  Model: CD-RW 
> GCE-8240B   Rev: 1.06
> Aug 21 23:57:25 gandalf 
> kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
> Aug 21 23:57:25 gandalf kernel: Attached scsi CD-ROM sr0 at scsi0, channel 
> 0, id 1, lun 0
> Aug 21 23:57:25 gandalf kernel: sr0: scsi3-mmc drive: 32x/40x writer cd/rw 
> xa/form2 cdda tray
> Aug 21 23:57:35 gandalf kernel: Attached scsi CD-ROM sr0 at scsi0, channel 
> 0, id 1, lun 0
> Aug 21 23:57:35 gandalf kernel: sr0: scsi3-mmc drive: 32x/40x writer cd/rw 
> xa/form2 cdda tray
> 
> lspci:
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
> (rev 01)
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> 00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
> 00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
> 00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)
> 
> 
> If you need more info, please ask
> 
> 	Rudmer
> 

Andre Hedrick
LAD Storage Consulting Group

