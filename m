Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKAQ4d>; Thu, 1 Nov 2001 11:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRKAQ4Z>; Thu, 1 Nov 2001 11:56:25 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:65298 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S279313AbRKAQ4L>;
	Thu, 1 Nov 2001 11:56:11 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15329.32420.468485.681104@abasin.nj.nec.com>
Date: Thu, 1 Nov 2001 11:56:04 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: undefined reference in 2.2.19 build with Reiserfs  (was: Google's mm problem - not reproduced on 2.4.13)
In-Reply-To: <E15z9qE-0000iy-00@starship.berlin>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin>
	<E15z2WJ-0000wc-00@starship.berlin>
	<20011031145331.S16554@lynx.no>
	<E15z9qE-0000iy-00@starship.berlin>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have a couple of Dells with 4G of memory.  We have been
experiencing the same google problems.  My boss has asked me to roll
one of them back to a 2.2 kernel, we will live with 2G of memory for
now, while I help out with testing mmap problems.  I am, however
having problems compiling the 2.2.19 kernel with the
linux-2.2.19-reiserfs-3.5.34-patch.bz2 patch.  I get the following
error:

ld -m elf_i386 -T /home/sven/linux-build/linux-2.2.19-reiserfs/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	fs/filesystems.a \
	net/network.a \
	drivers/block/block.a drivers/char/char.o drivers/misc/misc.a drivers/net/net.a drivers/scsi/scsi.a drivers/pci/pci.a drivers/video/video.a \
	/home/sven/linux-build/linux-2.2.19-reiserfs/arch/i386/lib/lib.a /home/sven/linux-build/linux-2.2.19-reiserfs/lib/lib.a /home/sven/linux-build/linux-2.2.19-reiserfs/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
fs/filesystems.a(reiserfs.o): In function `ip_check_balance':
reiserfs.o(.text+0x9cc2): undefined reference to `memset'
drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
aic7xxx.o(.text+0x117ff): undefined reference to `memcpy'
make: *** [vmlinux] Error 1

I tried patching the 2.2.20-pre12 patch but got the same (or similar)
results.

After I get this 2.2.19 system stable by boss says fixing the google
bug is my "top priority".  Unfortunely this will only like be the
second time I dig into linux source code so I expect it will be mostly
me testing other people patches.  But I will try my best.

Here is info from my 2.2.19 system as asked for in the REPORTING-BUGS
file:

This is a Red Hat 7.1 system.

$ source scripts/ver_linux 
Linux ps1.web.nj.nec.com 2.4.9-marcelo-patch #10 SMP Wed Aug 22 15:13:48 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         autofs eepro100 md

the Marcelo Patch is from the list time I stuck my nose in the kernel
with a himem patch.  Checking my diff and the 2.4.13 kernel the stuff
is nearly the same.


$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 993.400
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1979.18

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 993.400
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1985.74

$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: SEAGATE  Model: ST173404LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: DELL     Model: 1x6 U2W SCSI BP  Rev: 5.35
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02

bash-2.04$ lsmod
Module                  Size  Used by
autofs                 11920   1 (autoclean)
eepro100               17184   1 (autoclean)
md                     43616   0 (unused)
