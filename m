Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133035AbRAWFY3>; Tue, 23 Jan 2001 00:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133037AbRAWFYS>; Tue, 23 Jan 2001 00:24:18 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:4100 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S133035AbRAWFYC>;
	Tue, 23 Jan 2001 00:24:02 -0500
Date: Mon, 22 Jan 2001 23:23:36 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem with dd for floppy under 2.4.0
Message-ID: <Pine.LNX.4.30.0101222307020.640-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: seek= parameter for dd under 2.4.0
gives permission denied error
[2.] Full description of the problem/report:I was creating a new
root+boot disk for 2.4.0 this evening.  I issued the command:
dd if=/tmp/rootfs.gz of=/dev/fd0 bs=1k seek=335

and got the error message:
dd: /dev/fd0: Permission denied

Under 2.2.18 the copy succeeds.  Under 2.4.0, specifying a non-zero seek
paramter results in an error.

[3.] Keywords (i.e., modules, networking, kernel): floppy, dd, copy

[4.] Kernel version (from /proc/version):
Linux version 2.4.0 (tmolina@wr5z) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Sat Jan 20 15:20:46 CST 2001

[5.] Output of Oops.. message (if applicable) N/A

[6.] A small shell script or example program which triggers the
     problem (if possible) See 2. above

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux wr5z 2.4.0 #1 Sat Jan 20 15:20:46 CST 2001 i586 unknown
Kernel modules         2.4.1
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         opl3

[root@wr5z linux]# dd --version
dd (GNU fileutils) 4.0p

[7.2.] Processor information (from /proc/cpuinfo):
[root@wr5z linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.031
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 897.84

[7.3.] Module information (from /proc/modules):
opl3                   11904   0 (unused)

[7.4.] Loaded driver and
hardware information (/proc/ioports,
/proc/iomem)
[root@wr5z linux]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0388-038b : Yamaha OPL3
03bc-03be : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e87f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  e800-e87f : eth0
ec00-ec3f : 3Com Corporation 3c900 10BaseT [Boomerang]
  ec00-ec3f : eth1

[root@wr5z linux]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0021f62b : Kernel code
  0021f62c-002939c7 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e7ffffff : PCI Bus #01
  e4000000-e4ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    e4000000-e47fffff : vesafb
  e6000000-e6000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ea000000-ea00007f : Digital Equipment Corporation DECchip 21041 [Tulip
Pass 3]
  ea000000-ea00007f : eth0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root) N/A

[7.6.] SCSI information (from /proc/scsi/scsi) N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Under 2.2.18 I get the following extract from strace:

open("/tmp/rootfs.gz", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/dev/fd0", O_RDWR|O_CREAT|O_LARGEFILE, 0666) = 1
ftruncate64(0x1, 0x53c00, 0, 0, 0x1)    = -1 ENOSYS (Function not
implemented)
ftruncate(1, 343040)                    = 0
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0

Under 2.4.0 I get the following extract from strace:

open("/tmp/rootfs.gz", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/dev/fd0", O_RDWR|O_CREAT|O_LARGEFILE, 0666) = 1
ftruncate64(0x1, 0x53c00, 0, 0, 0x1)    = -1 EACCES (Permission denied)
write(2, "dd: ", 4)                     = 4
write(2, "/dev/fd0", 8)                 = 8
write(2, ": Permission denied", 19)     = 19
write(2, "\n", 1)                       = 1
_exit(1)                                = ?

Under 2.4.0 I get the following from strace if I don't include the seek=
paramter for the copy:

open("/tmp/rootfs.gz", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/dev/fd0", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80493a0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80493a0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80493a0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8049400, [], 0x4000000}, NULL, 8) = 0


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
