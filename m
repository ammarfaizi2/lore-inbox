Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRAQUsB>; Wed, 17 Jan 2001 15:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRAQUry>; Wed, 17 Jan 2001 15:47:54 -0500
Received: from abyss.devicen.de ([194.25.37.241]:38665 "EHLO abyss.devicen.de")
	by vger.kernel.org with ESMTP id <S132912AbRAQUrn>;
	Wed, 17 Jan 2001 15:47:43 -0500
Date: Wed, 17 Jan 2001 21:47:42 +0100
From: Oliver Teuber <teuber@abyss.devicen.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.0/smp damaged my filesystems (raid-ext2/ext2)
Message-ID: <20010117214742.A23252@abyss.devicen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[1.] One line summary of the problem:    
Linux 2.4.0 ate my filesystems ...

[2.] Full description of the problem/report:
after an uptime of about 10 days i wasnt able
to start a program because no shared
library could be loaded.

i could rescue my logfiles:
Jan  5 15:15:47 olibox kernel: raid5: switching cache buffer size, 1024 --> 4096
...
Jan 12 18:53:24 olibox kernel: EXT2-fs warning (device md(9,0)): ext2_unlink: Deleting nonexistent file (2391247), 0
Jan 12 18:53:24 olibox kernel: EXT2-fs warning (device md(9,0)): ext2_unlink: Deleting nonexistent file (2390881), 0
Jan 12 18:53:24 olibox kernel: EXT2-fs warning (device md(9,0)): ext2_unlink: Deleting nonexistent file (2391249), 0
...
Jan 15 20:03:04 olibox kernel: EXT2-fs error (device md(9,0)): ext2_readdir: bad entry in directory #1931587: rec_len %% 4 != 0 - offset=0, inode=966326071, rec_len=47331, name_len=95
Jan 15 20:03:04 olibox kernel: EXT2-fs error (device md(9,0)): ext2_readdir: bad entry in directory #1931589: directory entry across blocks - offset=0, inode=1046719047, rec_len=28576, name_len=229
Jan 15 20:03:04 olibox kernel: EXT2-fs error (device md(9,0)): ext2_readdir: bad entry in directory #1931591: rec_len %% 4 != 0 - offset=0, inode=4118425535, rec_len=27555, name_len=16

at 00:00 cron starts some daily jobs with high filesystem usage and my
system goes down ...
Jan 16 00:00:01 olibox /USR/SBIN/CRON[18956]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.daily) 
Jan 16 00:00:23 olibox squid[481]: storeDirClean: WARNING: Creating /var/squid/cache/0F/88 
Jan 16 00:00:23 olibox squid[481]: storeDirClean: /var/squid/cache/0F/88: (17) File exists 
Jan 16 00:00:34 olibox modprobe: modprobe: Can't open dependencies file /lib/modules/2.4.0/modules.dep (No such file or directory)
Jan 16 00:00:37 olibox su: (to nobody) root on none
Jan 16 00:01:25 olibox squid[481]: storeDirClean: WARNING: Creating /var/squid/cache/03/89 
Jan 16 00:01:25 olibox squid[481]: storeDirClean: /var/squid/cache/03/89: (17) File exists 
Jan 16 00:01:41 olibox squid[481]: storeDirClean: WARNING: Creating /var/squid/cache/04/89 
Jan 16 00:01:41 olibox squid[481]: storeDirClean: /var/squid/cache/04/89: (17) File exists 
Jan 16 00:02:58 olibox squid[481]: storeDirClean: WARNING: Creating /var/squid/cache/09/89 
Jan 16 00:02:58 olibox squid[481]: storeDirClean: /var/squid/cache/09/89: (17) File exists 
Jan 16 00:04:31 olibox squid[481]: storeDirClean: WARNING: Creating /var/squid/cache/0F/89 
Jan 16 00:04:31 olibox squid[481]: storeDirClean: /var/squid/cache/0F/89: (17) File exists 
Jan 16 00:06:01 olibox /usr/sbin/cron[516]: (CRON) STAT FAILED (tabs) 
Jan 16 00:07:00 olibox /USR/SBIN/CRON[18954]: (root) MAIL (mailed 113 bytes of output but got status 0x0047 ) 
Jan 16 00:29:56 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:35:42 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:40:43 olibox init: got bogus initrequest
Jan 16 00:41:28 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:46:54 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:52:25 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:54:11 olibox init: got bogus initrequest
Jan 16 00:54:26 olibox init: Id "m2" respawning too fast: disabled for 5 minutes
Jan 16 00:57:26 olibox init: got bogus initrequest
Jan 16 00:57:31 olibox init: Id "il" respawning too fast: disabled for 5 minutes
Jan 16 00:59:31 olibox init: got bogus initrequest
Jan 16 01:00:16 olibox init: Id "m2" respawning too fast: disabled for 5 minutes
Jan 16 01:02:36 olibox init: got bogus initrequest
Jan 16 01:02:41 olibox init: Id "il" respawning too fast: disabled for 5 minutes
...

[3.] Keywords (i.e., modules, networking, kernel):
kernel, filesystem, raid

[4.] Kernel version (from /proc/version):
Linux version 2.4.0 (root@olibox) (gcc version 2.95.2 19991024 (release)) #2 SMP Wed Jan 5 13:31:42 CET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No Ooops ...

[6.] A small shell script or example program which triggers the
     problem (if possible)
none

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux olibox 2.4.0 #2 SMP Wed Jan 17 13:31:42 CET 2001 i586 unknown
Kernel modules         2.3.24
Gnu C                  2.95.2
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4071014 Dec 30 13:22
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ipchains tulip hisax isdn slhc serial

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 198.950
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 397.31

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 198.950
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 397.31

[7.3.] Module information (from /proc/modules):
[7.4.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM OEM  Model: DFHSS4F          Rev: 4343
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: NAKAMICH Model: MJ-5.16S         Rev: 1.11
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 01
  Vendor: NAKAMICH Model: MJ-5.16S         Rev: 1.11
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 02
  Vendor: NAKAMICH Model: MJ-5.16S         Rev: 1.11
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 03
  Vendor: NAKAMICH Model: MJ-5.16S         Rev: 1.11
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 04
  Vendor: NAKAMICH Model: MJ-5.16S         Rev: 1.11
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S60B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: HP35480A         Rev: T503
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: WA6A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S61A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S61A
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

olibox:~ # cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md0 : active raid5 sdf5[3] sde5[2] sdd5[1] sdb5[0] 12698880 blocks level 5, 32k
chunk, algorithm 2 [4/4] [UUUU]
unused devices: <none>

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:11.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 02)
00:12.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 53)
00:13.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 20)
00:14.0 SCSI storage controller: Adaptec AIC-7881U

olibox:~ # cat /proc/interrupts
           CPU0       CPU1
  0:    1121770     890786    IO-APIC-edge  timer
  1:          1          7    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:         13         10    IO-APIC-edge  serial
 10:          2          0    IO-APIC-edge  Cyclom-Y
 13:          1          0          XT-PIC  fpu
 15:     140723     139481    IO-APIC-edge  HiSax
 16:      25099      24987   IO-APIC-level  aic7xxx
 17:     113346     113503   IO-APIC-level  eth0
NMI:          0
ERR:          0



[X.] Other notes, patches, fixes, workarounds:


Thank you
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
