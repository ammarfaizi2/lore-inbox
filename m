Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbULKR4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbULKR4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbULKR4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:56:15 -0500
Received: from sirius.livecd.pl ([83.243.111.250]:48141 "EHLO sirius.livecd.pl")
	by vger.kernel.org with ESMTP id S261991AbULKRuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:50:55 -0500
Date: Sat, 11 Dec 2004 18:50:41 +0100
From: Lukas Pawelczyk <havner@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: problems with writing cds as user - 2.6.10-rc3
Message-ID: <20041211175041.GA15582@pld-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux sirius 2.6.10
X-Location: Bialoleka/Poland 52.3000N, 21.1670E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

I'm unable to use cdrecord as user:

$ cdrecord -v gracetime=2 dev=/dev/hdc speed=10 blank=fast
<...>
Disk type:    Phase change
Manuf. index: 40
Manufacturer: INFODISC Technology Co., Ltd.
cdrecord: Cannot init drive.

User have rw to /dev/hdc (660 root:cdwrite, user is in cdrecord group)
It works ok as root.

Previous kernel I had was 2.6.8.1 (+ some cdrecord related patches,
and everything worked there on the same system) so i cannot tell with
which change it broke.

kernel 2.6.10-rc3 + 20041210_0507
hdc: TEAC CD-W552E, ATAPI CD/DVD-ROM drive
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

full cdrecord output and strace in attachments.

-- 
Regards    Havner                      {jid,mail}:havner(at)pld-linux.org
PLD developer && PLD 2.0 release manager         http://www.pld-linux.org
PLD LiveCD author                             http://livecd.pld-linux.org
                   "Quis custodiet ipsos custodes?"

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=cdrecord_out
Content-Transfer-Encoding: 8bit

cdrecord: Warning: Running on Linux-2.6.10
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
SCSI buffer size: 64512
Cdrecord-Clone 2.01 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.8'.
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'TEAC    '
Identifikation : 'CD-W552E        '
Revision       : '1.05'
Device seems to be: Generic mmc CD-RW.
Current: 0x000A
Profile: 0x0008 
Profile: 0x0009 
Profile: 0x000A (current)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: 
Drive buf size : 1951488 = 1905 KB
cdrecord: Operation not permitted. prevent/allow medium removal: scsi sendcmd: no error
CDB:  1E 00 00 00 01 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 40s
cdrecord: Cannot init drive.
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 3
  Reference speed: 6
  Is not unrestricted
  Is erasable
  Disk sub type: High speed Rewritable (CAV) media (1)
  ATIP start of lead in:  -11745 (97:25/30)
  ATIP start of lead out: 107930 (24:01/05)
  1T speed low:  4 1T speed high: 10
  2T speed low:  4 2T speed high:  0 (reserved val  6)
  power mult factor: 1 5
  recommended erase/write power: 5
  A1 values: 24 1A D8
  A2 values: 26 B2 4A
Disk type:    Phase change
Manuf. index: 40
Manufacturer: INFODISC Technology Co., Ltd.

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=cdrecord_strace

15814 execve("/usr/bin/cdrecord", ["cdrecord", "-v", "gracetime=2", "dev=/dev/hdc", "speed=10", "blank=fast"], [/* 43 vars */]) = 0
15814 uname({sys="Linux", node="sirius", ...}) = 0
15814 brk(0)                            = 0x809c000
15814 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
15814 open("/etc/ld.so.cache", O_RDONLY) = 5
15814 fstat64(5, {st_mode=S_IFREG|0644, st_size=74225, ...}) = 0
15814 mmap2(NULL, 74225, PROT_READ, MAP_PRIVATE, 5, 0) = 0xb7fd8000
15814 close(5)                          = 0
15814 open("/lib/tls/libc.so.6", O_RDONLY) = 5
15814 read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 Q\1\000"..., 512) = 512
15814 fstat64(5, {st_mode=S_IFREG|0755, st_size=1131968, ...}) = 0
15814 mmap2(NULL, 1141916, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 5, 0) = 0xb7ec1000
15814 mprotect(0xb7fd1000, 27804, PROT_NONE) = 0
15814 mmap2(0xb7fd2000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x110) = 0xb7fd2000
15814 mmap2(0xb7fd6000, 7324, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fd6000
15814 close(5)                          = 0
15814 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ec0000
15814 mprotect(0xb7fd2000, 4096, PROT_READ) = 0
15814 set_thread_area({entry_number:-1 -> 6, base_addr:0xb7ec0aa0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
15814 munmap(0xb7fd8000, 74225)         = 0
15814 geteuid32()                       = 501
15814 getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
15814 brk(0)                            = 0x809c000
15814 brk(0x80bd000)                    = 0x80bd000
15814 open("/etc/cdrecord.conf", O_RDONLY) = 5
15814 fstat64(5, {st_mode=S_IFREG|0644, st_size=1090, ...}) = 0
15814 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fea000
15814 _llseek(5, 0, [0], SEEK_SET)      = 0
15814 read(5, "#ident @(#)cdrecord.dfl\t1.4 02/0"..., 4096) = 1090
15814 close(5)                          = 0
15814 munmap(0xb7fea000, 4096)          = 0
15814 fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 4), ...}) = 0
15814 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fea000
15814 write(1, "Cdrecord-Clone 2.01 (i686-pc-lin"..., 79) = 79
15814 uname({sys="Linux", node="sirius", ...}) = 0
15814 write(2, "cdrecord: Warning: Running on Li"..., 43) = 43
15814 write(2, "cdrecord: There are unsettled is"..., 63) = 63
15814 write(2, "cdrecord: If you have unexpected"..., 76) = 76
15814 fstat64(2, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 4), ...}) = 0
15814 write(1, "TOC Type: 1 = CD-ROM\n", 21) = 21
15814 mlockall(MCL_CURRENT|MCL_FUTURE)  = -1 ENOMEM (Cannot allocate memory)
15814 write(2, "cdrecord: Cannot allocate memory"..., 66) = 66
15814 write(2, "cdrecord: WARNING: This causes a"..., 65) = 65
15814 sched_get_priority_max(SCHED_RR)  = 99
15814 sched_setscheduler(0, SCHED_RR, { 99 }) = -1 EPERM (Operation not permitted)
15814 write(2, "cdrecord: Operation not permitte"..., 68) = 68
15814 getpid()                          = 15814
15814 setpriority(PRIO_PROCESS, 15814, -20) = -1 EACCES (Permission denied)
15814 write(2, "cdrecord: Permission denied. WAR"..., 79) = 79
15814 write(2, "cdrecord: WARNING: This causes a"..., 65) = 65
15814 mmap2(NULL, 4198400, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0xb7abf000
15814 write(2, "scsidev: \'/dev/hdc\'\n", 20) = 20
15814 write(2, "devname: \'/dev/hdc\'\n", 20) = 20
15814 write(2, "scsibus: -2 target: -2 lun: -2\n", 31) = 31
15814 write(2, "Warning: Open by \'devname\' is un"..., 63) = 63
15814 open("/dev/hdc", O_RDWR|O_NONBLOCK) = 5
15814 fcntl64(5, F_GETFL)               = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
15814 fcntl64(5, F_SETFL, O_RDWR|O_LARGEFILE) = 0
15814 ioctl(5, 0x2282, 0xbfffcc78)      = 0
15814 write(2, "Linux sg driver version: 3.5.27\n", 32) = 32
15814 ioctl(5, 0x2201, 0xbfffcb04)      = 0
15814 fstat64(5, {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
15814 geteuid32()                       = 501
15814 getuid32()                        = 501
15814 write(1, "Using libscg version \'schily-0.8"..., 35) = 35
15814 ioctl(5, 0x2272, 0xbfffce68)      = 0
15814 ioctl(5, 0x2272, 0xbfffce64)      = 0
15814 write(2, "SCSI buffer size: 64512\n", 24) = 24
15814 ioctl(5, 0x2272, 0xbfffce48)      = 0
15814 ioctl(5, 0x2272, 0xbfffce44)      = 0
15814 brk(0x80e0000)                    = 0x80e0000
15814 brk(0x80df000)                    = 0x80df000
15814 ioctl(5, 0x2203, 0xbfffcea4)      = 0
15814 write(1, "atapi: 1\n", 9)         = 9
15814 gettimeofday({1102787365, 633564}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffce10)      = 0
15814 gettimeofday({1102787365, 633854}, NULL) = 0
15814 gettimeofday({1102787365, 633896}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcc10)      = 0
15814 gettimeofday({1102787365, 634099}, NULL) = 0
15814 gettimeofday({1102787365, 634131}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcc30)      = 0
15814 gettimeofday({1102787365, 634460}, NULL) = 0
15814 gettimeofday({1102787365, 634517}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc990)      = 0
15814 gettimeofday({1102787365, 634723}, NULL) = 0
15814 gettimeofday({1102787365, 634754}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9b0)      = 0
15814 gettimeofday({1102787365, 635512}, NULL) = 0
15814 gettimeofday({1102787365, 635553}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc800)      = 0
15814 gettimeofday({1102787365, 635758}, NULL) = 0
15814 gettimeofday({1102787365, 635790}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc6a0)      = 0
15814 gettimeofday({1102787365, 636539}, NULL) = 0
15814 gettimeofday({1102787365, 636571}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc800)      = 0
15814 gettimeofday({1102787365, 636773}, NULL) = 0
15814 gettimeofday({1102787365, 636804}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc6a0)      = 0
15814 gettimeofday({1102787365, 637510}, NULL) = 0
15814 gettimeofday({1102787365, 637543}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc950)      = 0
15814 gettimeofday({1102787365, 637747}, NULL) = 0
15814 gettimeofday({1102787365, 637778}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc7f0)      = 0
15814 gettimeofday({1102787365, 639222}, NULL) = 0
15814 gettimeofday({1102787365, 639265}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc990)      = 0
15814 gettimeofday({1102787365, 639573}, NULL) = 0
15814 write(1, "Device type    : Removable CD-RO"..., 34) = 34
15814 write(1, "Version        : 0\n", 19) = 19
15814 write(1, "Response Format: 1\n", 19) = 19
15814 write(1, "Vendor_info    : \'TEAC    \'\n", 28) = 28
15814 write(1, "Identifikation : \'CD-W552E      "..., 36) = 36
15814 write(1, "Revision       : \'1.05\'\n", 24) = 24
15814 write(1, "Device seems to be: Generic mmc "..., 39) = 39
15814 gettimeofday({1102787365, 640924}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc900)      = 0
15814 gettimeofday({1102787365, 651121}, NULL) = 0
15814 gettimeofday({1102787365, 651166}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc930)      = 0
15814 gettimeofday({1102787365, 660840}, NULL) = 0
15814 gettimeofday({1102787365, 660875}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc910)      = 0
15814 gettimeofday({1102787365, 670348}, NULL) = 0
15814 gettimeofday({1102787365, 670390}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc940)      = 0
15814 gettimeofday({1102787365, 680024}, NULL) = 0
15814 gettimeofday({1102787365, 680073}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcad0)      = 0
15814 gettimeofday({1102787365, 680279}, NULL) = 0
15814 gettimeofday({1102787365, 680311}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcaf0)      = 0
15814 gettimeofday({1102787365, 681040}, NULL) = 0
15814 gettimeofday({1102787365, 681073}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc940)      = 0
15814 gettimeofday({1102787365, 681275}, NULL) = 0
15814 gettimeofday({1102787365, 681307}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc7e0)      = 0
15814 gettimeofday({1102787365, 681983}, NULL) = 0
15814 gettimeofday({1102787365, 682015}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc940)      = 0
15814 gettimeofday({1102787365, 682216}, NULL) = 0
15814 gettimeofday({1102787365, 682247}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc7e0)      = 0
15814 gettimeofday({1102787365, 682986}, NULL) = 0
15814 gettimeofday({1102787365, 683020}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca90)      = 0
15814 gettimeofday({1102787365, 683223}, NULL) = 0
15814 gettimeofday({1102787365, 683254}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc930)      = 0
15814 gettimeofday({1102787365, 683959}, NULL) = 0
15814 gettimeofday({1102787365, 683993}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcbf0)      = 0
15814 gettimeofday({1102787365, 693553}, NULL) = 0
15814 gettimeofday({1102787365, 693598}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc790)      = 0
15814 gettimeofday({1102787365, 703221}, NULL) = 0
15814 gettimeofday({1102787365, 703260}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc7c0)      = 0
15814 gettimeofday({1102787365, 712816}, NULL) = 0
15814 write(1, "Current: 0x000A\n", 16) = 16
15814 write(1, "Profile: 0x0008 \n", 17) = 17
15814 write(1, "Profile: 0x0009 \n", 17) = 17
15814 write(1, "Profile: 0x000A (current)\n", 26) = 26
15814 gettimeofday({1102787365, 713227}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9b0)      = 0
15814 gettimeofday({1102787365, 713436}, NULL) = 0
15814 gettimeofday({1102787365, 713469}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc850)      = 0
15814 gettimeofday({1102787365, 714241}, NULL) = 0
15814 gettimeofday({1102787365, 714274}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9b0)      = 0
15814 gettimeofday({1102787365, 714480}, NULL) = 0
15814 gettimeofday({1102787365, 714512}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc850)      = 0
15814 gettimeofday({1102787365, 715216}, NULL) = 0
15814 gettimeofday({1102787365, 715249}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb00)      = 0
15814 gettimeofday({1102787365, 715521}, NULL) = 0
15814 gettimeofday({1102787365, 715553}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9a0)      = 0
15814 gettimeofday({1102787365, 716260}, NULL) = 0
15814 gettimeofday({1102787365, 716295}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 716499}, NULL) = 0
15814 gettimeofday({1102787365, 716530}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 717205}, NULL) = 0
15814 gettimeofday({1102787365, 717237}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 717439}, NULL) = 0
15814 gettimeofday({1102787365, 717470}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 718174}, NULL) = 0
15814 gettimeofday({1102787365, 718206}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 718423}, NULL) = 0
15814 gettimeofday({1102787365, 718454}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = 0
15814 gettimeofday({1102787365, 719157}, NULL) = 0
15814 gettimeofday({1102787365, 719204}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787365, 719417}, NULL) = 0
15814 gettimeofday({1102787365, 719448}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 719874}, NULL) = 0
15814 gettimeofday({1102787365, 719905}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787365, 720107}, NULL) = 0
15814 gettimeofday({1102787365, 720139}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 720575}, NULL) = 0
15814 gettimeofday({1102787365, 720607}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb50)      = 0
15814 gettimeofday({1102787365, 720809}, NULL) = 0
15814 gettimeofday({1102787365, 720840}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 721276}, NULL) = 0
15814 gettimeofday({1102787365, 721308}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb50)      = 0
15814 gettimeofday({1102787365, 721509}, NULL) = 0
15814 gettimeofday({1102787365, 721541}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 721929}, NULL) = 0
15814 gettimeofday({1102787365, 721968}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 722171}, NULL) = 0
15814 gettimeofday({1102787365, 722234}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc740)      = 0
15814 gettimeofday({1102787365, 722606}, NULL) = 0
15814 gettimeofday({1102787365, 722639}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 722842}, NULL) = 0
15814 gettimeofday({1102787365, 722873}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc740)      = 0
15814 gettimeofday({1102787365, 723261}, NULL) = 0
15814 gettimeofday({1102787365, 723293}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 723952}, NULL) = 0
15814 gettimeofday({1102787365, 723990}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 724409}, NULL) = 0
15814 gettimeofday({1102787365, 724444}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 724649}, NULL) = 0
15814 gettimeofday({1102787365, 724680}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 724881}, NULL) = 0
15814 gettimeofday({1102787365, 724913}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 724989}, NULL) = 0
15814 gettimeofday({1102787365, 725020}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 725223}, NULL) = 0
15814 gettimeofday({1102787365, 725254}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 725455}, NULL) = 0
15814 gettimeofday({1102787365, 725486}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 725549}, NULL) = 0
15814 gettimeofday({1102787365, 725629}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 725836}, NULL) = 0
15814 gettimeofday({1102787365, 725868}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 726230}, NULL) = 0
15814 gettimeofday({1102787365, 726261}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 726464}, NULL) = 0
15814 gettimeofday({1102787365, 726495}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 726882}, NULL) = 0
15814 gettimeofday({1102787365, 726914}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 727120}, NULL) = 0
15814 gettimeofday({1102787365, 727151}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = 0
15814 gettimeofday({1102787365, 727539}, NULL) = 0
15814 gettimeofday({1102787365, 727571}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 727772}, NULL) = 0
15814 gettimeofday({1102787365, 727802}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 728003}, NULL) = 0
15814 gettimeofday({1102787365, 728035}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 728097}, NULL) = 0
15814 gettimeofday({1102787365, 728127}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 728329}, NULL) = 0
15814 gettimeofday({1102787365, 728359}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 728698}, NULL) = 0
15814 gettimeofday({1102787365, 728729}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 728791}, NULL) = 0
15814 gettimeofday({1102787365, 728822}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 729026}, NULL) = 0
15814 gettimeofday({1102787365, 729057}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 729262}, NULL) = 0
15814 gettimeofday({1102787365, 729293}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 729354}, NULL) = 0
15814 gettimeofday({1102787365, 729396}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 729600}, NULL) = 0
15814 gettimeofday({1102787365, 729661}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 729866}, NULL) = 0
15814 gettimeofday({1102787365, 729897}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 729959}, NULL) = 0
15814 gettimeofday({1102787365, 729990}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 730191}, NULL) = 0
15814 gettimeofday({1102787365, 730222}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 730515}, NULL) = 0
15814 gettimeofday({1102787365, 730547}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 730610}, NULL) = 0
15814 gettimeofday({1102787365, 730641}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 730843}, NULL) = 0
15814 gettimeofday({1102787365, 730873}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787365, 731074}, NULL) = 0
15814 gettimeofday({1102787365, 731104}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9e0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 731166}, NULL) = 0
15814 gettimeofday({1102787365, 731198}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 731409}, NULL) = 0
15814 gettimeofday({1102787365, 731441}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc740)      = 0
15814 gettimeofday({1102787365, 731811}, NULL) = 0
15814 gettimeofday({1102787365, 731843}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787365, 732044}, NULL) = 0
15814 gettimeofday({1102787365, 732075}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc740)      = 0
15814 gettimeofday({1102787365, 732464}, NULL) = 0
15814 gettimeofday({1102787365, 732496}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 732700}, NULL) = 0
15814 gettimeofday({1102787365, 732731}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = 0
15814 gettimeofday({1102787365, 733118}, NULL) = 0
15814 gettimeofday({1102787365, 733150}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 733352}, NULL) = 0
15814 gettimeofday({1102787365, 733394}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 733597}, NULL) = 0
15814 gettimeofday({1102787365, 733628}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 733690}, NULL) = 0
15814 gettimeofday({1102787365, 733720}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 733992}, NULL) = 0
15814 gettimeofday({1102787365, 734023}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787365, 734226}, NULL) = 0
15814 gettimeofday({1102787365, 734256}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc890)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787365, 734318}, NULL) = 0
15814 write(1, "Using generic SCSI-3/mmc   CD-R/"..., 56) = 56
15814 write(1, "Driver flags   : MMC-3 SWABAUDIO"..., 43) = 43
15814 write(1, "Supported modes: \n", 18) = 18
15814 gettimeofday({1102787365, 735186}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcdf0)      = 0
15814 gettimeofday({1102787365, 735553}, NULL) = 0
15814 write(1, "Drive buf size : 1951488 = 1905 "..., 35) = 35
15814 gettimeofday({1102787365, 735784}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787365, 736202}, NULL) = 0
15814 gettimeofday({1102787365, 736286}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787365, 736526}, NULL) = 0
15814 gettimeofday({1102787365, 736558}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcdb0)      = 0
15814 gettimeofday({1102787365, 736783}, NULL) = 0
15814 gettimeofday({1102787365, 736814}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787366, 507045}, NULL) = 0
15814 gettimeofday({1102787366, 507091}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcdc0)      = 0
15814 gettimeofday({1102787366, 507366}, NULL) = 0
15814 gettimeofday({1102787366, 507399}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 507477}, NULL) = 0
15814 write(2, "cdrecord: Operation not permitte"..., 176) = 176
15814 gettimeofday({1102787366, 507733}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787366, 509771}, NULL) = 0
15814 gettimeofday({1102787366, 509803}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcdc0)      = 0
15814 gettimeofday({1102787366, 510009}, NULL) = 0
15814 gettimeofday({1102787366, 510040}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 510102}, NULL) = 0
15814 gettimeofday({1102787366, 510133}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787366, 510338}, NULL) = 0
15814 gettimeofday({1102787366, 510369}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcde0)      = 0
15814 gettimeofday({1102787366, 512626}, NULL) = 0
15814 gettimeofday({1102787366, 512657}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcdc0)      = 0
15814 gettimeofday({1102787366, 512858}, NULL) = 0
15814 gettimeofday({1102787366, 512890}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 513093}, NULL) = 0
15814 gettimeofday({1102787366, 513125}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787366, 513869}, NULL) = 0
15814 gettimeofday({1102787366, 513903}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 514105}, NULL) = 0
15814 gettimeofday({1102787366, 514136}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = 0
15814 gettimeofday({1102787366, 514523}, NULL) = 0
15814 gettimeofday({1102787366, 514556}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffce10)      = 0
15814 gettimeofday({1102787366, 514803}, NULL) = 0
15814 write(1, "Current Secsize: 2048\n", 22) = 22
15814 gettimeofday({1102787366, 514917}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcc90)      = 0
15814 gettimeofday({1102787366, 515741}, NULL) = 0
15814 gettimeofday({1102787366, 515772}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcc90)      = 0
15814 gettimeofday({1102787366, 516545}, NULL) = 0
15814 write(1, "ATIP info from disk:\n", 21) = 21
15814 write(1, "  Indicated writing power: 3\n", 29) = 29
15814 write(1, "  Reference speed: 6\n", 21) = 21
15814 write(1, "  Is not unrestricted\n", 22) = 22
15814 write(1, "  Is erasable\n", 14)   = 14
15814 write(1, "  Disk sub type: High speed Rewr"..., 55) = 55
15814 write(1, "  ATIP start of lead in:  -11745"..., 44) = 44
15814 write(1, "  ATIP start of lead out: 107930"..., 44) = 44
15814 write(1, "  1T speed low:  4 1T speed high"..., 37) = 37
15814 write(1, "  2T speed low:  4 2T speed high"..., 55) = 55
15814 write(1, "  power mult factor: 1 5\n", 25) = 25
15814 write(1, "  recommended erase/write power:"..., 35) = 35
15814 write(1, "  A1 values: 24 1A D8\n", 22) = 22
15814 write(1, "  A2 values: 26 B2 4A\n", 22) = 22
15814 write(1, "Disk type:    Phase change\n", 27) = 27
15814 write(1, "Manuf. index: 40\n", 17) = 17
15814 write(1, "Manufacturer: INFODISC Technolog"..., 44) = 44
15814 gettimeofday({1102787366, 520272}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 521456}, NULL) = 0
15814 gettimeofday({1102787366, 521489}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 522628}, NULL) = 0
15814 gettimeofday({1102787366, 522660}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 523784}, NULL) = 0
15814 gettimeofday({1102787366, 523814}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcca0)      = 0
15814 gettimeofday({1102787366, 524951}, NULL) = 0
15814 gettimeofday({1102787366, 524991}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8b0)      = 0
15814 gettimeofday({1102787366, 525221}, NULL) = 0
15814 gettimeofday({1102787366, 525266}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc750)      = 0
15814 gettimeofday({1102787366, 525666}, NULL) = 0
15814 gettimeofday({1102787366, 525699}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8b0)      = 0
15814 gettimeofday({1102787366, 525903}, NULL) = 0
15814 gettimeofday({1102787366, 525935}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc750)      = 0
15814 gettimeofday({1102787366, 526332}, NULL) = 0
15814 gettimeofday({1102787366, 526365}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 526570}, NULL) = 0
15814 gettimeofday({1102787366, 526601}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787366, 526987}, NULL) = 0
15814 gettimeofday({1102787366, 527020}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 527221}, NULL) = 0
15814 gettimeofday({1102787366, 527262}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 527465}, NULL) = 0
15814 gettimeofday({1102787366, 527498}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 527571}, NULL) = 0
15814 gettimeofday({1102787366, 527603}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 527804}, NULL) = 0
15814 gettimeofday({1102787366, 527835}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 528040}, NULL) = 0
15814 gettimeofday({1102787366, 528071}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 528133}, NULL) = 0
15814 gettimeofday({1102787366, 528164}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 528444}, NULL) = 0
15814 gettimeofday({1102787366, 528477}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787366, 528841}, NULL) = 0
15814 gettimeofday({1102787366, 528873}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffca00)      = 0
15814 gettimeofday({1102787366, 529078}, NULL) = 0
15814 gettimeofday({1102787366, 529109}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc8a0)      = 0
15814 gettimeofday({1102787366, 529499}, NULL) = 0
15814 gettimeofday({1102787366, 529531}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb50)      = 0
15814 gettimeofday({1102787366, 529734}, NULL) = 0
15814 gettimeofday({1102787366, 529765}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = 0
15814 gettimeofday({1102787366, 530152}, NULL) = 0
15814 gettimeofday({1102787366, 530231}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb50)      = 0
15814 gettimeofday({1102787366, 532314}, NULL) = 0
15814 gettimeofday({1102787366, 532353}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb50)      = 0
15814 gettimeofday({1102787366, 532560}, NULL) = 0
15814 gettimeofday({1102787366, 532594}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffc9f0)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 532671}, NULL) = 0
15814 write(2, "cdrecord: Cannot init drive.\n", 29) = 29
15814 gettimeofday({1102787366, 532863}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcd50)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 532929}, NULL) = 0
15814 gettimeofday({1102787366, 532962}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffccc0)      = 0
15814 gettimeofday({1102787366, 533167}, NULL) = 0
15814 gettimeofday({1102787366, 533199}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcb40)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 533272}, NULL) = 0
15814 gettimeofday({1102787366, 533305}, NULL) = 0
15814 ioctl(5, 0x2285, 0xbfffcd30)      = -1 EPERM (Operation not permitted)
15814 gettimeofday({1102787366, 533366}, NULL) = 0
15814 munmap(0xb7fea000, 4096)          = 0
15814 exit_group(-1)                    = ?

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=enviroment

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux sirius 2.6.10 #1 Fri Dec 10 21:23:42 UTC 2004 i686 AMD_Athlon(tm)_XP_processor_1600+ unknown PLD Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15.94.0.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          reiserfsck:
reiser4progs           fsck.reiser4:
xfsprogs               2.6.13
pcmcia-cs              3.2.8
PPP                    2.4.2
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.7
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         vfat fat ipt_REJECT ipt_state nvidia floppy snd_pcm_oss snd_seq_oss snd_seq_midi_event snd_seq snd_mixer_oss snd_via82xx snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp parport gameport button i2c_sensor 8139too mii md5 ipv6 ipt_MASQUERADE iptable_nat iptable_filter ip_tables uhci_hcd ohci_hcd ehci_hcd usbcore xfs tuner bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc i2c_core videodev ip_conntrack_ftp ip_conntrack capability commoncap psmouse ide_cd cdrom ext3 mbcache jbd ide_disk via82cxxx ide_core

--qDbXVdCdHGoSgWSk--
