Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278913AbRJVUza>; Mon, 22 Oct 2001 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278917AbRJVUzX>; Mon, 22 Oct 2001 16:55:23 -0400
Received: from blue.gradwell.net ([195.149.39.10]:40916 "HELO
	blue.gradwell.net") by vger.kernel.org with SMTP id <S278913AbRJVUzH>;
	Mon, 22 Oct 2001 16:55:07 -0400
Date: Mon, 22 Oct 2001 21:57:12 +0100
From: Peter Hamilton <lobsterphoneuk@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.12: High disk activity + system load causes lockup.
Message-ID: <20011022215712.A763@hamil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.12: High disk activity + system load causes lockup.

The first time this happened, I was copying .wav files from a vfat
partition (about 30..80Mb each).  The second time I was running lame
whilst downloading news.  I found the problem can be reliably reproduced
by simply copying large files around (copy two lots at the same time
and the system dies within 10..30 seconds).  Nothing is printed to
the console or written to any log files, and the only way to recover
is to hit the reset button.
The system seems stable in every other respect.

I've moved back to 2.4.6 which is fine.  Also tried downloading
a new 2.4.12 and configuring from scratch.

I'm not subscribed to this list, so please Cc: if you want me to
see replies.

All the best, Pete (lobsterphoneuk@yahoo.co.uk).


root@yuri:/usr/local# cat /proc/version 
  Linux version 2.4.12 (root@yuri) (gcc version 2.95.3 20010315 (release)) #1 Mon Oct 22 19:47:44 BST 2001

root@yuri:/usr/local# df
  Filesystem           1k-blocks      Used Available Use% Mounted on
  /dev/hda5              1976236   1423664    450564  76% /
  /dev/hda8             19637504  12135248   6478114  66% /usr2
  /dev/hda6              9212264   2619704   6592560  29% /dosd
  
root@yuri:/usr/local# cat /proc/mounts
  /dev/root / ext2 rw 0 0
  /dev/hda8 /usr2 ext2 rw,nodev 0 0
  none /dev/pts devpts rw 0 0
  none /proc proc rw 0 0
  /dev/hda6 /dosd vfat rw,nodev,noexec 0 0
  
root@yuri:/usr/local# sh /usr/src/linux/scripts/ver_linux
  If some fields are empty or look unusual you may have an old version.
  Compare to the current minimal requirements in Documentation/Changes.
   
  Linux yuri 2.4.12 #1 Mon Oct 22 19:47:44 BST 2001 i686 unknown
   
  Gnu C                  2.95.3
  Gnu make               3.79.1
  binutils               2.11.90.0.19
  util-linux             2.11f
  mount                  2.11b
  modutils               2.4.6
  e2fsprogs              1.22
  reiserfsprogs          3.x.0j
  PPP                    2.4.1
  Linux C Library        2.2.3
  Dynamic linker (ldd)   2.2.3
  Procps                 2.0.7
  Net-tools              1.60
  Kbd                    1.06
  Sh-utils               2.0
  Modules Loaded         nls_iso8859-1 nls_cp437 NVdriver nfsd lockd sunrpc ne 8390 tvaudio bttv videodev i2c-algo-bit tuner i2c-core ipchains advansys eepro100 emu10k1 ac97_codec ppp_async ppp_generic slhc parport_pc parport rtc sr_mod cdrom isofs vfat fat
  
root@yuri:/usr/local# cat /proc/cpuinfo
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 4
  model name      : AMD Athlon(tm) Processor
  stepping        : 2
  cpu MHz         : 750.034
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
  bogomips        : 1497.49
  
root@yuri:/usr/local# cat /proc/modules
  nls_iso8859-1           2880   1 (autoclean)
  nls_cp437               4384   1 (autoclean)
  NVdriver              722336  14 (autoclean)
  nfsd                   43616   8
  lockd                  36976   1 [nfsd]
  sunrpc                 59648   1 [nfsd lockd]
  ne                      6432   1
  8390                    6016   0 [ne]
  tvaudio                 8192   0 (autoclean) (unused)
  bttv                   57808   0 (unused)
  videodev                4704   3 [bttv]
  i2c-algo-bit            7168   1 [bttv]
  tuner                   4528   1
  i2c-core               12960   0 [tvaudio bttv i2c-algo-bit tuner]
  ipchains               29744   0
  advansys               82544   0 (unused)
  eepro100               15840   1
  emu10k1                51152   0
  ac97_codec              9600   0 [emu10k1]
  ppp_async               6288   0 (unused)
  ppp_generic            14720   0 [ppp_async]
  slhc                    4672   0 [ppp_generic]
  parport_pc             10976   0 (unused)
  parport                14144   0 [parport_pc]
  rtc                     5504   0 (autoclean)
  sr_mod                 11504   0 (autoclean) (unused)
  cdrom                  28928   0 (autoclean) [sr_mod]
  isofs                  17360   0 (autoclean)
  vfat                    8688   1 (autoclean)
  fat                    29824   0 (autoclean) [vfat]
  
root@yuri:/usr/local# cat /proc/ioports
  0000-001f : dma1
  0020-003f : pic1
  0040-005f : timer
  0060-006f : keyboard
  0070-007f : rtc
  0080-008f : dma page reg
  00a0-00bf : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  01f0-01f7 : ide0
  02f8-02ff : serial(auto)
  0300-031f : eth1
  0378-037a : parport0
  03c0-03df : vga+
  03f6-03f6 : ide0
  03f8-03ff : serial(auto)
  0cf8-0cff : PCI conf1
  5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  d000-d00f : VIA Technologies, Inc. Bus Master IDE
    d000-d007 : ide0
  d400-d41f : VIA Technologies, Inc. UHCI USB
  d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  dc00-dc1f : Creative Labs SB Live! EMU10k1
    dc00-dc1f : EMU10K1
  e000-e007 : Creative Labs SB Live!
  e400-e43f : Advanced System Products, Inc ABP940-U / ABP960-U
    e400-e40f : advansys
  e800-e83f : Intel Corporation 82557 [Ethernet Pro 100]
    e800-e83f : eepro100
  
root@yuri:/usr/local# cat /proc/iomem
  00000000-0009fbff : System RAM
  0009fc00-0009ffff : reserved
  000a0000-000bffff : Video RAM area
  000c0000-000c7fff : Video ROM
  000cc000-000cefff : Extension ROM
  000cf000-000cffff : Extension ROM
  000f0000-000fffff : System ROM
  00100000-1ffeffff : System RAM
    00100000-001d567f : Kernel code
    001d5680-00214c9f : Kernel data
  1fff0000-1fff2fff : ACPI Non-volatile Storage
  1fff3000-1fffffff : ACPI Tables
  d0000000-d7ffffff : PCI Bus #01
    d0000000-d7ffffff : nVidia Corporation NV15 (Geforce2 Pro)
  d8000000-dbffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
  dc000000-ddffffff : PCI Bus #01
    dc000000-dcffffff : nVidia Corporation NV15 (Geforce2 Pro)
  df000000-df0fffff : Intel Corporation 82557 [Ethernet Pro 100]
  df100000-df100fff : Brooktree Corporation Bt878
    df100000-df100fff : bttv
  df101000-df101fff : Intel Corporation 82557 [Ethernet Pro 100]
    df101000-df101fff : eepro100
  df102000-df102fff : Brooktree Corporation Bt878
  ffff0000-ffffffff : reserved
  
root@yuri:/usr/local# cat /proc/scsi/scsi
  Attached devices: 
  Host: scsi0 Channel: 00 Id: 03 Lun: 00
    Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
    Type:   CD-ROM                           ANSI SCSI revision: 02
  Host: scsi0 Channel: 00 Id: 04 Lun: 00
    Vendor: PLEXTOR  Model: CD-R   PX-W124TS Rev: 1.04
    Type:   CD-ROM                           ANSI SCSI revision: 02
  Host: scsi0 Channel: 00 Id: 06 Lun: 00
    Vendor: EXABYTE  Model: EXB-8200         Rev: 2423
    Type:   Sequential-Access                ANSI SCSI revision: ffffffff

