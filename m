Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRAMS03>; Sat, 13 Jan 2001 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbRAMS0O>; Sat, 13 Jan 2001 13:26:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131308AbRAMSZs>;
	Sat, 13 Jan 2001 13:25:48 -0500
Date: Sat, 13 Jan 2001 16:30:18 +0100 (CET)
From: Tilmann Bitterberg <tilmann@bitterberg.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [240-ac8] loop device hangs and sync does not return
Message-ID: <Pine.LNX.4.21.0101131529250.702-100000@nixon.whitehouse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there is something about loop device hangs in the 2.4
TODO list and I don't know if that is supposed to be fixed.

If this BUG is known, please appreciate

[1.] One line summary of the problem:    
[240-ac8] loop device hangs and sync does not return any more

[2.] Full description of the problem/report:
When I copy data to a ext2 filesystem mounted via loop0 the 'cp'
command stops after a while. The system is not dead but very
unusuable and I can't reboot because 'sync' is not working.
I am in single user mode on a 2way Pentium 166 w/o mmx SMP
system. 2.2.X is stable. The loop dev is compiled as a module.

I tried with 'noapic', 'maxcpus=1' and combination of both. I
have not tried a UP kernel. Same happens with 2.4.0-prerelease.
Copying (a lot of) data between "normal" mounted filesystems
works fine.

[3.] Keywords (i.e., modules, networking, kernel):
loop device, sync, module, SMP. 

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-ac8 (tibit@nixon.whitehouse.de)
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) 
#7 SMP Sat Jan 13 14:05:38 CET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
not available
     
[6.] A small shell script or example program which triggers the
     problem (if possible)
  dd if=/dev/zero of=file bs=1M count=500
  mke2fs file
  mount -o loop=/dev/loop0 file /mnt/loop
  cd $_
  cp -av /bin/ /etc/ /sbin/ .
  mkdir usr && cp -av /usr/bin usr/

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Kernel modules         2.4.1
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.10.0.18
Linux C Library        2.1.2
Dynamic linker         ldd (GNU libc) 2.1.2
Procps                 2.0.6
Mount                  2.10r
Net-tools              1.53
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded         loop 3c59x sb sb_lib uart401 sound soundcore

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 167.048
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 333.41

processor	: 1
... (same)

[7.3.] Module information (from /proc/modules):
loop                    7808   0 (unused)
3c59x                  24672   1 (autoclean)
sb                      7712   0 (autoclean)
sb_lib                 36192   0 (autoclean) [sb]
uart401                 6640   0 (autoclean) [sb_lib]
sound                  63024   0 (autoclean) [sb_lib uart401]
soundcore               4208   5 (autoclean) [sb_lib sound]

[7.4.] Loaded driver and hardware information
I am on an SCSI only system with aic7xxx and 2 4Gig IBM UW disk.

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
03c0-03df : vga+
  03c0-03df : matrox
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-60ff : Adaptec AIC-7880U
  6000-60fe : aic7xxx
6400-647f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  6400-647f : eth0
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

[X.] Other notes, patches, fixes, workarounds:
For what it's worth:
Data is copied from sda1 to sdb1 where the loop device is
located

I have a lot of NMI interrupts, nearly twice as much as from the
timer. Same is true for LOC.
Sometimes I even have some ERR but usually not more than 10.

When using sysrq to do an emergency sync and a killall I get:
(from memory)
NMI Watchdog detected LOOKUP on CPU0
and the calltrace (resolved)
do_exit    do_signal    do_pollfd   signal_return

Thanks in advance
Tilmann

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
