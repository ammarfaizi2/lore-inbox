Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVLXXBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVLXXBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVLXXBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:01:36 -0500
Received: from mail4.opus-i.net ([209.10.181.136]:3041 "EHLO
	FPNYEXCBE01.opus-i.corp") by vger.kernel.org with ESMTP
	id S1750749AbVLXXBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:01:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: PROBLEM: "can't make software raid0 volumes greater than 4TB"
Date: Sat, 24 Dec 2005 17:59:33 -0500
Message-ID: <14BC3454F4B4614FBC4F3FB19A84C37246E7A1@FPNYEXCBE01.opus-i.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: "can't make software raid0 volumes greater than 4TB"
Thread-Index: AcYI2e+mX3sv40hMQU64kuyjfV+CSgAAzbEgAAAdwSA=
From: "Patrick Freeman" <patrickf@datallegro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    

OS hangs on format with volume greater than 4TB in raid0 only.

[2.] Full description of the problem/report:

Creating software raid0 volumes larger than 4TB returns properly, but first attempt to touch the volume (in this case with mkfs, and I've tried xfs, reiserfs and ext3) either hangs the OS or mkfs does not return.  The case where mkfs does not return appears to be at the 4TB boundary, but significantly above 4TB, mkfs does not return.  Later, I noticed that there was an Oops on reboot, but they were not reported on the terminal while formatting or while starting raid.

I am able to format volumes more than 7TB with raid5 or raid6, so the problem did not appear to be with volume size for mkfs or the filesystem.

When using 10 WD4000YR (400GB drives) to make a software raid0 array, mkfs.xfs returns fine and there are no problems.  Using 11 of the 400GB drives causes mkfs.xfs not to return.  Using 12 of the 400GB drives, causes the OS to hang when using mkfs.xfs (immediate).

The same thing occurs when using 17 WD2500SD (250GB drives, which format to 3.9TB) - no problem.  When using 18 of the 250GB drives, mkfs.xfs does not return.  Using 24 (I did not check 19) drives, the OS hangs immediately when running mkfs.xfs.

I initially noticed the hang when trying to use software raid0 to join two large hardware arrays (totaling over 7TB).

[3.] Keywords (i.e., modules, networking, kernel):

RAID0 mkfs hang

[4.] Kernel version (from /proc/version):

Linux version 2.6.11.4-21.9-smp (geeko@buildhost) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #1 SMP Fri Aug 19 11:58:59 UTC 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

The following oops occurred when trying to join two large hardware arrays into a single raid0 of over 7TB (I included a little more than the Oops).

Nov 29 18:11:31 dev kernel: md: bind<sda>
Nov 29 18:11:31 dev kernel: md: bind<sdb>
Nov 29 18:11:31 dev kernel: raid0: module not supported by Novell, setting U taint flag.
Nov 29 18:11:31 dev kernel: md: raid0 personality registered as nr 2
Nov 29 18:11:31 dev kernel: md2: setting max_sectors to 512, segment boundary to 131071
Nov 29 18:11:31 dev kernel: raid0: looking at sdb
Nov 29 18:11:31 dev kernel: raid0:   comparing sdb(4296872192) with sdb(4296872192)
Nov 29 18:11:31 dev kernel: raid0:   END
Nov 29 18:11:31 dev kernel: raid0:   ==> UNIQUE
Nov 29 18:11:31 dev kernel: raid0: 1 zones
Nov 29 18:11:31 dev kernel: raid0: looking at sda
Nov 29 18:11:31 dev kernel: raid0:   comparing sda(4296872192) with sdb(4296872192)
Nov 29 18:11:31 dev kernel: raid0:   EQUAL
Nov 29 18:11:31 dev kernel: raid0: FINAL 1 zones
Nov 29 18:11:31 dev kernel: raid0: done.
Nov 29 18:11:32 dev kernel: raid0 : md_size is 8593744384 blocks.
Nov 29 18:11:32 dev kernel: raid0 : conf->hash_spacing is 8593744384 blocks.
Nov 29 18:11:32 dev hald[5857]: Timed out waiting for hotplug event 940. Rebasing to 941
Nov 29 18:11:33 dev kernel: raid0 : nb_zone is 2256.
Nov 29 18:11:34 dev kernel: raid0 : Allocating 18048 bytes for hash.
Nov 29 18:11:35 dev kernel: Unable to handle kernel paging request at 000000000001d508 RIP:
Nov 29 18:11:37 dev kernel: <ffffffff88433c0b>{:raid0:raid0_make_request+459}
Nov 29 18:11:39 dev kernel: PGD 212e0b067 PUD 212e0a067 PMD 0
Nov 29 18:11:39 dev kernel: Oops: 0000 [1] SMP
Nov 29 18:11:40 dev kernel: CPU 0
Nov 29 18:11:42 dev kernel: Modules linked in: raid0 ib_ipoib ib_sa_client ib_client_query ib_poll ib_useraccess ib_tavor ib_mad ib_core ib_services mod_rhh mst_pciconf mst_pci mod_vip ipv6 evdev joydev mlxsys st sr_mod edd sg sk98lin e1000 hw_random ehci_hcd uhci_hcd i2c_i801 i2c_core usbcore parport_pc lp parport video1394 ohci1394 raw1394 ieee1394 capability dm_mod reiserfs xfs exportfs ide_cd cdrom ide_disk piix ide_core raid1 arcmsr sd_mod scsi_mod
Nov 29 18:11:43 dev kernel: Pid: 7687, comm: udev_volume_id Tainted: GF    U 2.6.11.4-21.9-smp
Nov 29 18:11:47 dev kernel: RIP: 0010:[<ffffffff88433c0b>] <ffffffff88433c0b>{:raid0:raid0_make_request+459}
Nov 29 18:11:49 dev kernel: RSP: 0018:ffff810212e1d948  EFLAGS: 00010286
Nov 29 18:11:50 dev kernel: RAX: 0000000000000000 RBX: ffff81021cdc5780 RCX: 0000000000000008
Nov 29 18:11:52 dev kernel: RDX: 0000000000003aa1 RSI: 0000000000000008 RDI: ffff81021e5d6e10
Nov 29 18:11:53 dev kernel: RBP: 0000000000000100 R08: 0000000002003a21 R09: ffff8102131b7000
Nov 29 18:11:55 dev kernel: R10: 00000000000001ff R11: 000000000003ffff R12: ffff8102132532c0
Nov 29 18:11:55 dev kernel: R13: ffff81021f6d8040 R14: 0000000000001000 R15: 0000000000000001
Nov 29 18:11:55 dev kernel: FS:  0000000000000000(0000) GS:ffffffff804e3980(0000) knlGS:0000000000000000
Nov 29 18:11:57 dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Nov 29 18:11:57 dev kernel: CR2: 000000000001d508 CR3: 00000002133ad000 CR4: 00000000000006e0
Nov 29 18:11:57 dev kernel: Process udev_volume_id (pid: 7687, threadinfo ffff810212e1c000, task ffff81021cceb070)
Nov 29 18:11:58 dev kernel: Stack: 0000000000000000 ffff81021cdc5780 ffff81021f6d8040 ffff810212e1d9a8
Nov 29 18:11:58 dev kernel:        ffff81021cdc5780 ffffffff80295281 0000000000000000 ffff81021cceb070
Nov 29 18:11:59 dev kernel:        ffffffff8014d720 ffff810212e1d9c0
Nov 29 18:11:59 dev kernel: Call Trace:<ffffffff80295281>{generic_make_request+545} <ffffffff8014d720>{autoremove_wake_function+0}
Nov 29 18:11:59 dev kernel:        <ffffffff8015d384>{mempool_alloc+164} <ffffffff8014d720>{autoremove_wake_function+0}
Nov 29 18:11:59 dev kernel:        <ffffffff8015fa31>{buffered_rmqueue+529} <ffffffff8014d720>{autoremove_wake_function+0}
Nov 29 18:12:00 dev kernel:        <ffffffff8029537d>{submit_bio+221} <ffffffff80183c27>{bio_alloc+359}
Nov 29 18:12:01 dev kernel:        <ffffffff8017fe6b>{submit_bh+283} <ffffffff80182cba>{block_read_full_page+602}
Nov 29 18:12:02 dev kernel:        <ffffffff80185700>{blkdev_get_block+0} <ffffffff80161650>{__do_page_cache_readahead+480}
Nov 29 18:12:03 dev kernel:        <ffffffff802234ae>{prio_tree_insert+494} <ffffffff801617b6>{blockable_page_cache_readahead+22}
Nov 29 18:12:06 dev kernel:        <ffffffff801619da>{page_cache_readahead+490} <ffffffff8015b3c2>{do_generic_mapping_read+354}
Nov 29 18:12:10 dev kernel:        <ffffffff8015a320>{file_read_actor+0} <ffffffff8015bfe7>{__generic_file_aio_read+423}
Nov 29 18:12:12 dev kernel:        <ffffffff8015c1ab>{generic_file_read+187} <ffffffff80120a22>{do_page_fault+1234}
Nov 29 18:12:16 dev kernel:        <ffffffff8014d720>{autoremove_wake_function+0} <ffffffff80224711>{__up_write+49}
Nov 29 18:12:17 dev kernel:        <ffffffff8017ebd4>{vfs_read+244} <ffffffff8017ed43>{sys_read+83}
Nov 29 18:12:18 dev kernel:        <ffffffff8010e9de>{system_call+126}
Nov 29 18:12:20 dev kernel:
Nov 29 18:12:20 dev kernel: Code: 48 8b 14 d0 8b 03 44 21 d0 4a 8d 0c 48 48 8b 42 28 48 89 43
Nov 29 18:12:21 dev kernel: RIP <ffffffff88433c0b>{:raid0:raid0_make_request+459} RSP <ffff810212e1d948>
Nov 29 18:12:21 dev kernel: CR2: 000000000001d508

>>RIP; ffffffff88433c0b <_end+7f0ec0b/7f0db000>   <=====

Trace; ffffffff80295281 <generic_make_request+221/240>
Trace; ffffffff8015d384 <mempool_alloc+a4/190>
Trace; ffffffff8015fa31 <buffered_rmqueue+211/310>
Trace; ffffffff8029537d <submit_bio+dd/100>
Trace; ffffffff8017fe6b <submit_bh+11b/150>
Trace; ffffffff80185700 <blkdev_get_block+0/70>
Trace; ffffffff802234ae <prio_tree_insert+1ee/2a0>
Trace; ffffffff801619da <page_cache_readahead+1ea/2f0>
Trace; ffffffff8015a320 <file_read_actor+0/150>
Trace; ffffffff8015c1ab <generic_file_read+bb/e0>
Trace; ffffffff8014d720 <autoremove_wake_function+0/30>
Trace; ffffffff8017ebd4 <vfs_read+f4/170>
Trace; ffffffff8010e9de <system_call+7e/83>

Code;  ffffffff88433c0b <_end+7f0ec0b/7f0db000>
0000000000000000 <_RIP>:
Code;  ffffffff88433c0b <_end+7f0ec0b/7f0db000>   <=====
   0:   48 8b 14 d0               mov    (%rax,%rdx,8),%rdx   <=====
Code;  ffffffff88433c0f <_end+7f0ec0f/7f0db000>
   4:   8b 03                     mov    (%rbx),%eax
Code;  ffffffff88433c11 <_end+7f0ec11/7f0db000>
   6:   44 21 d0                  and    %r10d,%eax
Code;  ffffffff88433c14 <_end+7f0ec14/7f0db000>
   9:   4a 8d 0c 48               lea    (%rax,%r9,2),%rcx
Code;  ffffffff88433c18 <_end+7f0ec18/7f0db000>
   d:   48 8b 42 28               mov    0x28(%rdx),%rax
Code;  ffffffff88433c1c <_end+7f0ec1c/7f0db000>
  11:   48 89 43 00               mov    %rax,0x0(%rbx)



[6.] A small shell script or example program which triggers the
     problem (if possible)

No shell script required, just create a raid0 software array which is greater than 4TB and try to format it.

[7.] Environment

Do you want the whole output of env?
NNTPSERVER=news
INFODIR=/usr/local/info:/usr/share/info:/usr/info
MANPATH=/usr/share/man:/usr/local/man:/usr/X11R6/man:/opt/gnome/share/man
HOSTNAME=dev
GNOME2_PATH=/usr/local:/opt/gnome:/usr
XKEYSYMDB=/usr/X11R6/lib/X11/XKeysymDB
HOST=dev
TERM=xterm
SHELL=/bin/bash
PROFILEREAD=true
HISTSIZE=1000
SSH_CLIENT=::ffff:10.3.157.125 36178 22
QTDIR=/usr/lib/qt3
SSH_TTY=/dev/pts/0
GROFF_NO_SGR=yes
JRE_HOME=/usr/java/jre1.5.0_05
USER=root
LS_COLORS=no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:
XNLSPATH=/usr/X11R6/lib/X11/nls
HOSTTYPE=x86_64
PAGER=less
XDG_CONFIG_DIRS=/usr/local/etc/xdg/:/etc/xdg/:/etc/opt/gnome/xdg/
MINICOM=-c on
MAIL=/var/mail/root
PATH=/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:/usr/X11R6/bin:/bin:/usr/games:/opt/gnome/bin:/usr/java/jre1.5.0_05/bin
CPU=x86_64
JAVA_BINDIR=/usr/java/jre1.5.0_05/bin
INPUTRC=/etc/inputrc
PWD=/usr/src/linux
JAVA_HOME=/usr/java/jre1.5.0_05
PYTHONSTARTUP=/etc/pythonstart
INGRES_HOME=~ingres/ingres
TEXINPUTS=:/root/.TeX:/usr/share/doc/.TeX:/usr/doc/.TeX
SHLVL=1
HOME=/root
LESS_ADVANCED_PREPROCESSOR=no
OSTYPE=linux
LS_OPTIONS=-a -N --color=tty -T 0
WINDOWMANAGER=/usr/X11R6/bin/kde
GTK_PATH=/usr/local/lib/gtk-2.0:/opt/gnome/lib/gtk-2.0:/usr/lib/gtk-2.0
LESS=-M -I
MACHTYPE=x86_64-suse-linux
LOGNAME=root
GTK_PATH64=/usr/local/lib64/gtk-2.0:/opt/gnome/lib64/gtk-2.0:/usr/lib64/gtk-2.0
XDG_DATA_DIRS=/usr/local/share/:/usr/share/:/etc/opt/kde3/share/:/opt/kde3/share/:/opt/gnome/share/
ACLOCAL_FLAGS=-I /opt/gnome/share/aclocal
LC_CTYPE=en_US.UTF-8
SSH_CONNECTION=::ffff:10.3.157.125 36178 ::ffff:10.3.157.157 22
PKG_CONFIG_PATH=/opt/gnome/lib64/pkgconfig
LESSOPEN=lessopen.sh %s
INFOPATH=/usr/local/info:/usr/share/info:/usr/info:/opt/gnome/share/info
LESSCLOSE=lessclose.sh %s %s
G_BROKEN_FILENAMES=1
JAVA_ROOT=/usr/java/jre1.5.0_05
COLORTERM=1
_=/usr/bin/env
OLDPWD=/root

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dev 2.6.11.4-21.9-smp #1 SMP Fri Aug 19 11:58:59 UTC 2005 x86_64 x86_64
 x86_64 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre1
e2fsprogs              1.36
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.25
Linux C Library        x  1 root root 1446783 Jun 10  2005 /lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   053
Modules Loaded         ib_ipoib ib_sa_client ib_client_query ib_poll ib_useracce
ss ib_tavor ib_mad ib_core ib_services mod_rhh mod_vip mlxsys mst_pciconf mst_pc
i joydev evdev st sr_mod ipv6 edd sg sk98lin e1000 uhci_hcd ehci_hcd usbcore i2c
_i801 hw_random i2c_core parport_pc lp parport video1394 ohci1394 raw1394 ieee13
94 capability dm_mod reiserfs xfs exportfs ide_cd cdrom ide_disk piix ide_core r
aid1 arcmsr sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2793.091
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5521.40
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2793.091
cache size      : 1024 KB
physical id     : 3
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5570.56
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2793.091
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5570.56
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2793.091
cache size      : 1024 KB
physical id     : 3
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5570.56
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

ib_ipoib 68504 0 - Live 0xffffffff88429000
ib_sa_client 37008 1 ib_ipoib, Live 0xffffffff8841e000
ib_client_query 23520 2 ib_ipoib,ib_sa_client, Live 0xffffffff88417000
ib_poll 27344 1 ib_client_query, Live 0xffffffff8840f000
ib_useraccess 13604 0 - Live 0xffffffff8830d000
ib_tavor 43320 6 - Live 0xffffffff88243000
ib_mad 26392 3 ib_client_query,ib_useraccess,ib_tavor, Live 0xffffffff8823b000
ib_core 279192 5 ib_ipoib,ib_sa_client,ib_useraccess,ib_tavor,ib_mad, Live 0xffffffff882c7000
ib_services 19012 8 ib_ipoib,ib_sa_client,ib_client_query,ib_poll,ib_useraccess,ib_tavor,ib_mad,ib_core, Live 0xffffffff88235000
mod_rhh 372924 0 - Live 0xffffffff883b2000
mod_vip 440392 2 ib_tavor,mod_rhh, Live 0xffffffff88345000
mlxsys 107020 2 mod_rhh,mod_vip, Live 0xffffffff882ab000
mst_pciconf 88320 0 - Live 0xffffffff8832e000
mst_pci 85632 0 - Live 0xffffffff88318000
joydev 11392 0 - Live 0xffffffff882a7000
evdev 11776 0 - Live 0xffffffff882a3000
st 39460 0 - Live 0xffffffff88298000
sr_mod 17828 0 - Live 0xffffffff88292000
ipv6 260864 16 - Live 0xffffffff88251000
edd 11168 0 - Live 0xffffffff88231000
sg 39480 0 - Live 0xffffffff88226000
sk98lin 191852 1 - Live 0xffffffff881f6000
e1000 86068 0 - Live 0xffffffff881df000
uhci_hcd 31776 0 - Live 0xffffffff881d6000
ehci_hcd 32776 0 - Live 0xffffffff881ca000
usbcore 118768 3 uhci_hcd,ehci_hcd, Live 0xffffffff881ac000
i2c_i801 9620 0 - Live 0xffffffff881a8000
hw_random 6176 0 - Live 0xffffffff881a5000
i2c_core 24576 1 i2c_i801, Live 0xffffffff8819e000
parport_pc 40936 0 - Live 0xffffffff88193000
lp 12488 0 - Live 0xffffffff8818c000
parport 40588 2 parport_pc,lp, Live 0xffffffff88181000
video1394 19832 0 - Live 0xffffffff8817b000
ohci1394 32900 1 video1394, Live 0xffffffff88171000
raw1394 27800 0 - Live 0xffffffff88169000
ieee1394 106872 3 video1394,ohci1394,raw1394, Live 0xffffffff8814d000
capability 4840 0 - Live 0xffffffff8814a000
dm_mod 56384 0 - Live 0xffffffff8813b000
reiserfs 237936 1 - Live 0xffffffff880ff000
xfs 522416 3 - Live 0xffffffff8807e000
exportfs 6784 1 xfs, Live 0xffffffff8807b000
ide_cd 41376 0 - Live 0xffffffff8806f000
cdrom 38952 2 sr_mod,ide_cd, Live 0xffffffff88064000
ide_disk 18048 6 - Live 0xffffffff8805e000
piix 12804 0 [permanent], Live 0xffffffff88059000
ide_core 141604 3 ide_cd,ide_disk,piix, Live 0xffffffff88035000
raid1 15744 2 - Live 0xffffffff88030000
arcmsr 18888 3 - Live 0xffffffff8802a000
sd_mod 18688 3 - Live 0xffffffff88024000
scsi_mod 140752 5 st,sr_mod,sg,arcmsr,sd_mod, Live 0xffffffff88000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-047f : 0000:00:1f.0
  0400-0403 : PM1a_EVT_BLK
  0404-0405 : PM1a_CNT_BLK
  0408-040b : PM_TMR
  0428-042f : GPE0_BLK
0500-053f : 0000:00:1f.0
0540-055f : 0000:00:1f.3
  0540-054f : i801-smbus
0cf8-0cff : PCI conf1
c880-c89f : 0000:00:1d.0
  c880-c89f : uhci_hcd
cc00-cc1f : 0000:00:1d.1
  cc00-cc1f : uhci_hcd
cc80-cc9f : 0000:00:1d.2
  cc80-cc9f : uhci_hcd
d000-dfff : PCI Bus #08
  dc00-dcff : 0000:08:00.0
    dc00-dcff : sk98lin
e800-e8ff : 0000:0a:0c.0
ec80-ecbf : 0000:0a:04.0
  ec80-ecbf : e1000
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0

# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ca7ff : Video ROM
000f0000-000fffff : System ROM
00100000-dffdffff : System RAM
  00100000-0033a701 : Kernel code
  0033a702-004617a7 : Kernel data
dffe0000-dffeefff : ACPI Tables
dffef000-dfffdbff : ACPI Non-volatile Storage
dfffdc00-dfffffff : reserved
fb800000-fbffffff : PCI Bus #09
  fb800000-fbffffff : 0000:09:00.0
    fb800000-fbffffff : Arbel HCA Driver
fc9fec00-fc9fefff : 0000:00:1d.7
  fc9fec00-fc9fefff : ehci_hcd
fc9ff000-fc9fffff : 0000:00:01.0
fca00000-fcdfffff : PCI Bus #01
  fcafe000-fcafefff : 0000:01:00.1
  fcaff000-fcafffff : 0000:01:00.3
  fcb00000-fccfffff : PCI Bus #02
    fcb00000-fcbfffff : PCI Bus #03
      fcbff000-fcbfffff : 0000:03:0e.0
        fcbff000-fcbfffff : arcmsr
    fcc00000-fccfffff : PCI Bus #04
      fccff000-fccfffff : 0000:04:0e.0
        fccff000-fccfffff : arcmsr
  fcd00000-fcdfffff : PCI Bus #05
    fcd00000-fcdfffff : PCI Bus #06
      fcdff000-fcdfffff : 0000:06:0e.0
        fcdff000-fcdfffff : arcmsr
fce00000-fcefffff : PCI Bus #08
  fcefc000-fcefffff : 0000:08:00.0
    fcefc000-fcefffff : sk98lin
fcf00000-fcffffff : PCI Bus #09
  fcf00000-fcffffff : 0000:09:00.0
    fcf82000-fcf821ff : MSI-X vector table
fd000000-fdffffff : 0000:0a:0c.0
febdf000-febdffff : 0000:0a:0c.0
febe0000-febfffff : 0000:0a:04.0
  febe0000-febfffff : e1000
fec00000-fec85fff : reserved
fee00000-fee00fff : reserved
ffc00000-ffffffff : reserved
220000000-2200003ff : 0000:00:1f.1

[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [4105]

0000:00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fc9ff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [b0] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000

0000:00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fca00000-fcdfffff
        Prefetchable memory behind bridge: 0000000ffff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 0000000ffff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0c) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fce00000-fcefffff
        Prefetchable memory behind bridge: 0000000ffff00000-0000000000000000
        Secondary status: SERR
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcf00000-fcffffff
        Prefetchable memory behind bridge: 00000000fb800000-00000000fbf00000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at c880 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at cc00 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 15
        Region 4: I/O ports at cc80 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at fc9fec00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-febfffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 220000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 0540 [size=32]

0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=01, secondary=02, subordinate=04, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcb00000-fccfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:01:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt Controller A (rev 09) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fcafe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] #10 [0001]
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=01, secondary=05, subordinate=06, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcd00000-fcdfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:01:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B (rev 09) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fcaff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] #10 [0001]
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:02.0 PCI bridge: Intel Corporation 80331 [Lindsay] I/O processor (rev 0a) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcb00000-fcbfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=0, Commitment Limit=0
                : Downstream: Capacity=0, Commitment Limit=0

0000:02:03.0 PCI bridge: Intel Corporation 80331 [Lindsay] I/O processor (rev 0a) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcc00000-fccfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=0, Commitment Limit=0
                : Downstream: Capacity=0, Commitment Limit=0

0000:03:0e.0 RAID bus controller: Areca Technology Corp.: Unknown device 1120
        Subsystem: Areca Technology Corp.: Unknown device 1120
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (32000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at fcbff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcbe0000 [disabled] [size=64K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE+ ERO- RBC=1 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:04:0e.0 RAID bus controller: Areca Technology Corp.: Unknown device 1130
        Subsystem: Areca Technology Corp.: Unknown device 1130
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 (32000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at fccff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcce0000 [disabled] [size=64K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE+ ERO- RBC=1 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:05:01.0 PCI bridge: Intel Corporation 80331 [Lindsay] I/O processor (rev 0a) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fcd00000-fcdfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=0, Commitment Limit=0
                : Downstream: Capacity=0, Commitment Limit=0

0000:06:0e.0 RAID bus controller: Areca Technology Corp.: Unknown device 1120
        Subsystem: Areca Technology Corp.: Unknown device 1120
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (32000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at fcdff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcde0000 [disabled] [size=64K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE+ ERO- RBC=1 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:08:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 17)
        Subsystem: Intel Corporation: Unknown device 5021
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
        Latency: 0, cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fcefc000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at dc00 [size=256]
        Expansion ROM at fcec0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] #10 [0011]

0000:09:00.0 InfiniBand: Mellanox Technologies MT25208 InfiniHost III Ex HCA (rev a0)
        Subsystem: Mellanox Technologies MT25208 InfiniHost III Ex HCA
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fcf00000 (64-bit, non-prefetchable) [size=1M]
        Region 2: Memory at fb800000 (64-bit, prefetchable) [size=8M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Vital Product Data
        Capabilities: [90] Message Signalled Interrupts: 64bit+ Queue=0/5 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [84] #11 [801f]
        Capabilities: [60] #10 [0001]

0000:0a:04.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ec80 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:0a:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at febdf000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

The following information is not representative - I have used these cards as well as others in JBOD mode in order to create software raid arrays from individual disks.  I have seen the problem trying to aggregate two of these cards' volumes into a volume greater than 4TB with software raid0.
# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Areca    Model: ARC-1120-VOL#00  Rev: R001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Areca    Model: ARC-1130-VOL#00  Rev: R001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: Areca    Model: ARC-1130-VOL#00  Rev: R001
  Type:   Direct-Access                    ANSI SCSI revision: 03


Thanks,

Patrick W. Freeman
