Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQKMRlN>; Mon, 13 Nov 2000 12:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQKMRlE>; Mon, 13 Nov 2000 12:41:04 -0500
Received: from mout1.freenet.de ([194.97.50.132]:18059 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S129873AbQKMRkx>;
	Mon, 13 Nov 2000 12:40:53 -0500
Date: Sun, 12 Nov 2000 20:05:33 +0100 (CET)
From: Gert Wollny <wollny@cns.mpg.de>
To: linux-kernel@vger.kernel.org
Subject: BUG Report 2.4.0-test11-pre3: NMI Watchdoch detected LOCKUP at
 CPU[01]  (fwd)
Message-ID: <Pine.LNX.4.10.10011121945480.643-100000@bolide.beigert.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bug i had with kernel version 2.4.0-test9 is still there, but there are
additional information:

When parport_pc is compiled as module, and not already loaded 
"modprobe imm" yields the LOCKUP message (subject). 

The iomega-drive is usable after the modprobe and despite of
the lockup.

If parport_pc is compiled into the kernel, or the modules is already
loaded, this lockup doen not happen. 



the trace looks like this:

0: ?? (assume spin_lock_irqsave in blk_get_queue but printed EIP seems to
       be sensless - area with no code according to the map file)

1: ll_rw_blk.c: 874 
          generic_make_request -> "after line q = blk_get_queue(...)" 
2: ll_rw_blk.c: 925   ll_rw_block 	
3: ll_rw_blk.c: 287     writeout_one_page
4: filemap.c: 332     do_buffer_fdatasync
5: filemap.c: 352     generic_buffer_fdatasync

5.1: filemap.c: 278     writeout_one_page 
this is on the stack trace, but maybe only since its adress is used in 
call (5)

6: ext2/fsync.c: 140       ext2_sync_file  
7: fs/buffer.c: 370  sys_fsync

Please CC me, if you have some comments, ideas, and thanks for your time. 

Gert 

additional information:

Linux version 2.4.0-test11--pre3 (gcc version 2.95.2 19991024 (release)) #30 SMP Son Nov 12 19:15:40 CET 2000
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.77
Binutils               2.9.1.0.25
Linux C Library        2.1.1
Dynamic linker         ldd (GNU libc) 2.1.1
Procps                 2.0.2
Mount                  2.9w
Net-tools              1.52
Console-tools          0.2.0
Sh-utils               2.0
Modules Loaded         sd_mod nfsd lockd sunrpc 8139too nls_cp437 vfat 
                       fat awe_wave sb sb_lib uart401 sound soundcore 
                       advansys scsi_mod

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.000029
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 897.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.000029
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 901.12

/proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   9, function  0:
    SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 3).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 32 bit memory at 0xde800000 [0xde8000ff].
  Bus  0, device  10, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe1000000 [0xe1000fff].
  Bus  0, device  10, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xb800 [0xb8ff].
      Non-prefetchable 32 bit memory at 0xde000000 [0xde0000ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 5).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xe2000000 [0xe3ffffff].
      Non-prefetchable 32 bit memory at 0xdf800000 [0xdf803fff].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf7fffff].

/proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0H
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: J.45
  Type:   Direct-Access                    ANSI SCSI revision: 02


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
