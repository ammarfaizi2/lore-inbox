Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267127AbSKMHhD>; Wed, 13 Nov 2002 02:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbSKMHhC>; Wed, 13 Nov 2002 02:37:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:42213 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267127AbSKMHhA>; Wed, 13 Nov 2002 02:37:00 -0500
From: "Uwe Langenkamp" <ul@uwe-langenkamp.de>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: System crashed (kernel bug report)
Date: Wed, 13 Nov 2002 08:43:45 +0100
Message-ID: <JLECLKCMILLGAJOCDMKEOEDMCEAA.ul@uwe-langenkamp.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after running 8 weeks without problems, our server had a system crash, I
found the following bug message in /var/log/messages:

An additional information: Since 19th of October, the system is shut down by
a SmartUPS over night (to save energy, from 11pm to 7am).


Nov 12 16:16:30 serv1 kernel: Assertion failure in
journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
Nov 12 16:16:30 serv1 kernel: ------------[ cut here ]------------
Nov 12 16:16:30 serv1 kernel: kernel BUG at commit.c:535!
Nov 12 16:16:30 serv1 kernel: invalid operand: 0000
Nov 12 16:16:30 serv1 kernel: autofs eepro100 hisax isdn slhc st ext3 jbd
aic7xxx megaraid sd_mod scsi_mod
Nov 12 16:16:30 serv1 kernel: CPU:    1
Nov 12 16:16:30 serv1 kernel: EIP:    0010:[<c885e0e4>]    Not tainted
Nov 12 16:16:30 serv1 kernel: EFLAGS: 00010286
Nov 12 16:16:30 serv1 kernel:
Nov 12 16:16:30 serv1 kernel: EIP is at journal_commit_transaction [jbd]
0xb04 (2.4.18-3smp)
Nov 12 16:16:30 serv1 kernel: eax: 0000001c   ebx: 0000000a   ecx: c02eee60
edx: 00003cb1
Nov 12 16:16:30 serv1 kernel: esi: c6a22790   edi: c76393e0   ebp: c6824000
esp: c6825e78
Nov 12 16:16:30 serv1 kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:16:30 serv1 kernel: Process kjournald (pid: 146,
stackpage=c6825000)
Nov 12 16:16:30 serv1 kernel: Stack: c8864eee 00000217 c010a767 00000000
00000f0c c3e670f4 00000000 c0b869c0
Nov 12 16:16:30 serv1 kernel:        c3e71a00 00000826 00000006 00000005
00000296 00000296 c38dbf80 c31abda0
Nov 12 16:16:30 serv1 kernel:        c776c380 c776c320 c776ce60 c776cec0
c6352840 c6a36440 c6a36200 c5121a40
Nov 12 16:16:30 serv1 kernel: Call Trace: [<c8864eee>] .rodata.str1.1 [jbd]
0x26e
Nov 12 16:16:30 serv1 kernel: [<c010a767>] do_IRQ [kernel] 0xc7
Nov 12 16:16:30 serv1 kernel: [<c0119048>] schedule [kernel] 0x348
Nov 12 16:16:30 serv1 kernel: [<c88607d6>] kjournald [jbd] 0x136
Nov 12 16:16:30 serv1 kernel: [<c8860680>] commit_timeout [jbd] 0x0
Nov 12 16:16:30 serv1 kernel: [<c0107286>] kernel_thread [kernel] 0x26
Nov 12 16:16:30 serv1 kernel: [<c88606a0>] kjournald [jbd] 0x0
Nov 12 16:16:31 serv1 kernel:
Nov 12 16:16:31 serv1 kernel:
Nov 12 16:16:31 serv1 kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 e8
4b f1 ff ff 8d 47 48


----------------/proc/version:

Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 07:27:31 EDT
2002


----------------/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.444
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
bogomips        : 397.31

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.444
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
bogomips        : 398.13


----------------/proc/modules:

autofs                 12804   0 (autoclean) (unused)
eepro100               20816   1
hisax                 585060   6
isdn                  134656   7 [hisax]
slhc                    6612   2 [isdn]
st                     29908   0 (unused)
ext3                   70752   5
jbd                    53632   5 [ext3]
aic7xxx               125440   0 (unused)
megaraid               28640   6
sd_mod                 12896  12
scsi_mod              112272   4 [st aic7xxx megaraid sd_mod]


----------------/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
0340-0340 : HiSax hscx A fifo
03c0-03df : vga+
03f8-03ff : serial(auto)
0740-075f : HiSax hscx A
0b40-0b40 : HiSax hscx B fifo
0cf8-0cff : PCI conf1
0f40-0f5f : HiSax hscx B
1340-1340 : HiSax isac fifo
1740-175f : HiSax isac
1b40-1b47 : avm cfg
e000-efff : PCI Bus #01
  ec00-ec7f : American Megatrends Inc. MegaRAID
    ec10-ec1f : megaraid
  ece0-ecff : Intel Corp. 82557 [Ethernet Pro 100]
    ece0-ecff : eepro100
f400-f4ff : Adaptec AIC-7880U (#2)
f800-f8ff : Adaptec AIC-7880U


----------------/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-002342b0 : Kernel code
  002342b1-00306b3f : Kernel data
fe900000-fe9fffff : PCI Bus #01
  fe9fe000-fe9fefff : Intel Corp. 82557 [Ethernet Pro 100]
    fe9fe000-fe9fefff : eepro100
fea00000-feafffff : PCI Bus #01
  fea00000-feafffff : Intel Corp. 82557 [Ethernet Pro 100]
fec00000-fec00fff : reserved
fedfe000-fedfefff : Adaptec AIC-7880U (#2)
  fedfe000-fedfefff : aic7xxx
fedff000-fedfffff : Adaptec AIC-7880U
  fedff000-fedfffff : aic7xxx
fee00000-fee00fff : reserved
ffff1cb4-ffffffff : reserved


----------------/proc/scsi/scsi:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID5  8132R Rev:   A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: HP35480A         Rev: T503
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-415   Rev: 1.1n
  Type:   CD-ROM                           ANSI SCSI revision: 02


What happened to the system and how can i prevent it?

Regards
U.Langenkamp

