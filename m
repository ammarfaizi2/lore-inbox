Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263753AbTCUTTR>; Fri, 21 Mar 2003 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263750AbTCUTSR>; Fri, 21 Mar 2003 14:18:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10378 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262726AbTCUTRF>; Fri, 21 Mar 2003 14:17:05 -0500
Date: Fri, 21 Mar 2003 14:31:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Ded-Fat 8.0 and ext3
Message-ID: <Pine.LNX.4.53.0303211420170.13876@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all. Greetings from fix-up land.

I installed RedHat 8.0 of an existing system.  By default it
makes ext3 file-systems with journaling enabled.

That distribution used Linux-2.4.18-14.
I copied /boot/config-2.4.18-14 to /usr/src/linux-2.4.18-15/.config
as a ".config" file and executed:

`make oldconfig`

It asked me some more questions so I fear that /boot/config-2.4.18-14
was not used in the distribution configuration for linux-2.4.18-14,
but I continued anyway.

Then I executed `make dep`. This failed to find the math emulation
library, but continued anyway.

Then I executed make bzImage

The result was screens and screens full of errors, to lengthy to
describe.  When it failed, it was obvious that this version,
supplied by our respected, and soon to be unloved, vendor had
never, ever been built from the supplied sources.

This has always happened to me when attempting to build whatever
Red Hat distributed. Undaunted, I grabbed a linux-2.4.20 tarball
and built a system using the same .config file. I also built the
modules, but many of them had errors. Not to worry, I learned a
long time ago to execite `make -i` when building modules. I got
the modules I needed.

The problem is:
It took 14:37:xx minutes to build a kernel that took 00:12:xx to
         |___ 14 hours, 37 minutes                       |___ 12 min.
build on an identical system. The only difference is the "fast"
system uses ext2, and the slooooooooow system uses ext3. This
14 hour stuff is reminisicent of the days of x386 and ST-506
drives!

I just timed reading the whole physical drive and I can do that
at 24 megabytes per second. If I read a 24 megabyte file, however
it takes over 1 minute, about 400k per second!  What is going
on with ext3 file-systems or is something else stealing CPU
cycles?

It there a way to convert to ext2 without having to start from
scratch again? I know you can mount it as an ext2, would that
help?

When trying to create this report, I executed `script`. Something
bad has happened because I get this:

The simple command `cat /proc/cpuinfo` results in:
# # # c# c# ca# ca# cat# cat# cat # cat # cat /# cat /# cat /p# cat /p# cat /pr# cat /pr# cat /pro# cat /pro# cat /proc# cat /proc# cat /proc/# cat /proc/# cat /proc/c# cat /proc/c# cat /proc/cp# cat /proc/cp# cat /proc/cpu# cat /proc/cpu# cat /proc/cpui# cat /proc/cpui# cat /proc/cpuin# cat /proc/cpuin# cat /proc/cpuinf# cat /proc/cpuinf# cat /proc/cpuinfo# cat /proc/cpuinfo

So whatever `script` is interfacing with is broken in Red Hat 8.0 also.
I wish they actually tested this stuff.

Script started on Fri Mar 21 13:54:23 2003
# # # c# c# ca# ca# cat# cat# cat # cat # cat /# cat /# cat /p# cat /p# cat /pr# cat /pr# cat /pro# cat /pro# cat /proc# cat /proc# cat /proc/# cat /proc/# cat /proc/c# cat /proc/c# cat /proc/cp# cat /proc/cp# cat /proc/cpu# cat /proc/cpu# cat /proc/cpui# cat /proc/cpui# cat /proc/cpuin# cat /proc/cpuin# cat /proc/cpuinf# cat /proc/cpuinf# cat /proc/cpuinfo# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 199.437
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 398.13

# # # l# l# ls# ls# lsp# lsp# lspc# lspc# lspci# lspci
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:0d.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 08)
00:0e.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06)
00:10.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
# # # c# c# ca# ca# cat# cat# cat # cat # cat /# cat /# cat /p# cat /p# cat /pr# cat /pr# cat /pro# cat /pro# cat /proc# cat /proc# cat /proc/# cat /proc/# cat /proc/m# cat /proc/m# cat /proc/me# cat /proc/me# cat /proc/mem# cat /proc/mem# cat /proc/memi# cat /proc/memi# cat /proc/memin# cat /proc/memin# cat /proc/meminf# cat /proc/meminf# cat /proc/meminfo# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  64098304 54976512  9121792        0  5009408 29765632
Swap: 148013056  4980736 143032320
MemTotal:        62596 kB
MemFree:          8908 kB
MemShared:           0 kB
Buffers:          4892 kB
Cached:          28468 kB
SwapCached:        600 kB
Active:          20828 kB
Inactive:        15084 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62596 kB
LowFree:          8908 kB
SwapTotal:      144544 kB
SwapFree:       139680 kB
# # # c# c# ca# ca# cat# cat# cat # cat # cat /# cat /# cat /p# cat /p# cat /pr# cat /pr# cat /pro# cat /pro# cat /proc# cat /proc# cat /proc/# cat /proc/# cat /proc/m# cat /proc/m# cat /proc/mo# cat /proc/mo# cat /proc/mod# cat /proc/mod# cat /proc/modu# cat /proc/modu# cat /proc/modul# cat /proc/modul# cat /proc/module# cat /proc/module# cat /proc/modules# cat /proc/modules
nfsd                   73360   8 (autoclean)
lockd                  54064   1 (autoclean) [nfsd]
sunrpc                 77308   1 (autoclean) [nfsd lockd]
autofs                 12244   0 (autoclean) (unused)
3c59x                  29360   1
iptable_filter          2316   0 (autoclean) (unused)
ip_tables              14488   1 [iptable_filter]
ext3                   64192   5
jbd                    47828   5 [ext3]
loop                   10936   0 (unused)
sr_mod                 16824   0 (unused)
cdrom                  31008   0 [sr_mod]
BusLogic               93724   7
sd_mod                 12652  14
scsi_mod              102836   3 [sr_mod BusLogic sd_mod]
# # # c# c# ca# ca# cat# cat# cat # cat # cat /# cat /# cat /p# cat /p# cat /pr# cat /pr# cat /pro# cat /pro# cat /proc# cat /proc# cat /proc/# cat /proc/# cat /proc/s# cat /proc/s# cat /proc/sc# cat /proc/sc# cat /proc/scs# cat /proc/scs# cat /proc/scsi# cat /proc/scsi# cat /proc/scsi/# cat /proc/scsi/# cat /proc/scsi/s# cat /proc/scsi/s# cat /proc/scsi/sc# cat /proc/scsi/sc# cat /proc/scsi/scs# cat /proc/scsi/scs# cat /proc/scsi/scsi# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Quantum  Model: XP34300W         Rev: L912
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL_TM1280S Rev: 300X
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST19101W         Rev: 0014
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-76S   Rev: 1.1c
  Type:   CD-ROM                           ANSI SCSI revision: 02
# # # e# e# ex# ex# exi# exi# exit# exit
Script done on Fri Mar 21 13:57:47 2003


I fear that the "new" system might be slow because there is some
loop going on in STDIN that's eating CPU time. That may be
the reason why `script` is broken in that distribution.
Anyway, sombody should check the evidence.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

