Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbRF3DBI>; Fri, 29 Jun 2001 23:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbRF3DA7>; Fri, 29 Jun 2001 23:00:59 -0400
Received: from dnvrpop3.dnvr.uswest.net ([206.196.128.5]:38154 "HELO
	dnvrpop3.dnvr.uswest.net") by vger.kernel.org with SMTP
	id <S264663AbRF3DAp>; Fri, 29 Jun 2001 23:00:45 -0400
Date: Fri, 29 Jun 2001 21:00:28 -0600
Message-Id: <200106300300.f5U30SE6004224@egor.linux.home>
From: "James A. Lupo" <lupoja@qwest.net>
To: tek@rbg.informatik.tu-darmstadt.de
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: AD1816A Sound Failure Upgrading to Kernel-2.4.5 from Kernel-2.2.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.]  AD1816A Sound Failure Upgrading to Kernel-2.4.5 from Kernel-2.2.19

[2.]  I have been successfully running kernel-2.2.19 on an HP Pavilion
      8180 system with an AD1816A sound device.  When I installed
      kernel-2.4.5, the sound system became erratic.  It would
      ocassionally produce the correct sounds, but would suddenly
      generate severely distorted output.

      I noted in the system logs that the AD1816 module reported
      "isadmabug=0" under kernel-2.2.19, but was now reporting
      "isadmabug=1" under kernel-2.4.5.  After searching the source,
      it appears that the variable 'isa_dma_bridge_buggy' is now set
      in /arch/i386/kernel/setup.c, though I'm not 100% sure of that.
      There does not appear to be a configuration variable which
      controls this setting either.

      As a pure hack, I modified drivers/sound/ad1816.c to include a
      line which sets isa_dma_bridge_buggy to zero in function
      probe_ad1816() as follows:

      /* replace with probe routine */
      static int __init probe_ad1816 ( struct address_info *hw_config )
      {
          ad1816_info    *devc = &dev_info[nr_ad1816_devs];
          int io_base=hw_config->io_base;
          int *osp=hw_config->osp;
          int tmp;

          printk("ad1816: AD1816 sounddriver Copyright (C) 1998 by Thorsten Knabe\n");

          isa_dma_bridge_buggy = 0;

          ...
       }

       With this one line change, the sound system works perfectly
       again.  This is clearly not the best fix, but I hope it helps
       isolate the true source of the problem.

[3.]  Keywords:  sound, ad1816

[4.]  Kernel version:  Linux version 2.4.5 (root@egor.linux.home)
      (gcc version 2.95.4 20010604 (Debian prerelease)) #3 Tue Jun 26
      14:35:49 MDT 2001

[5.]  N/A

[6.]  N/A

[7.]
[7.1]  
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux egor.linux.home 2.4.5 #3 Tue Jun 26 14:35:49 MDT 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11d
mount                  2.11d
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc ad1816 sound soundcore

[7.2]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 3
cpu MHz		: 265.914
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 530.84

[7.3]
ppp_deflate            39136   0 (autoclean)
bsd_comp                4096   0 (autoclean)
ppp_async               6224   0 (autoclean)
ppp_generic            12992   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4640   0 (autoclean) [ppp_generic]
ad1816                  9232   1 (autoclean)
sound                  54544   1 (autoclean) [ad1816]
soundcore               3664   4 (autoclean) [sound]

[7.4]
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
0213-0213 : isapnp read
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0500-050f : AD1816 Sound
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
f480-f4ff : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  f480-f4ff : tulip
f800-f8ff : Adaptec AIC-7861
fc00-fcff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
ff80-ff9f : Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II]
ffa0-ffaf : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0021e78f : Kernel code
  0021e790-0029abbf : Kernel data
fb000000-fbffffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
ffbee000-ffbeefff : Adaptec AIC-7861
  ffbee000-ffbeefff : aic7xxx
ffbef000-ffbeffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
fff7fc00-fff7fc7f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  fff7fc00-fff7fc7f : tulip

[7.5]  No lspci utility (??)

[7.6]  
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST410800N        Rev: 7101
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C5110A           Rev: 3701
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7]  None.

[X.]  See one line fix in [2.] above.

-- 
Jim
    ------------------- Optional Methods -----------------------
Dr James A. Lupo                          (303) 423-2652
9667 Independence Dr.                     lupoja@qwest.net
Westminster  CO  80021-6845               jalupo@regis.edu
