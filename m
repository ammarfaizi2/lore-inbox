Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311967AbSCVLfQ>; Fri, 22 Mar 2002 06:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311969AbSCVLfG>; Fri, 22 Mar 2002 06:35:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:17936 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311967AbSCVLer>;
	Fri, 22 Mar 2002 06:34:47 -0500
Date: Fri, 22 Mar 2002 12:52:52 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.7 rm -r in tmpfs problem
Message-ID: <Pine.LNX.4.10.10203221241460.12354-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While doing some testing, I ran into a problem where rm -r doesn't
remove all files in a tmpfs directory is there are lots of files
in that directory.  (rm -rf linux is failing)

	-Mike

If dcache_readdir() isn't the right place to start looking, please
holler.. I've only got a week to play ;-)


execve("/usr/bin/rm", ["rm", "-r", "linux/drivers/sound"], [/* 48 vars */]) = 0
brk(0)                                  = 134542020
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_dev=makedev(3, 6), st_ino=2727, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=190, st_size=95703, st_atime=2002/03/22-11:21:15, st_mtime=2002/03/22-07:02:19, st_ctime=2002/03/22-07:02:19}) = 0
old_mmap(NULL, 95703, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\330"..., 1024) = 1024
fstat64(3, {st_dev=makedev(3, 6), st_ino=188611, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2950, st_size=1502458, st_atime=2002/03/22-11:21:15, st_mtime=2002/02/17-13:14:11, st_ctime=2002/02/17-13:14:11}) = 0
old_mmap(NULL, 1281952, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002f000
mprotect(0x4015e000, 40864, PROT_NONE)  = 0
old_mmap(0x4015e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12e000) = 0x4015e000
old_mmap(0x40164000, 16288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40164000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40168000
munmap(0x40017000, 95703)               = 0
brk(0)                                  = 134542020
brk(0x804f2ec)                          = 134542060
brk(0x8050000)                          = 134545408
ioctl(0, TCGETS, {c_iflags=0x2506, c_oflags=0x5, c_cflags=0x4bf, c_lflags=0x8a3b, c_line=0, c_cc="\x03\x1c\x7f\x15\x04\x00\x01\x00\x11\x13\x1a\x00\x12\x0f\x17\x16\x00\x00\x2f\x00\x00\x00\x00\xe0\xeb\x15\x40\x06\x00\x00\x00\x72"}) = 0
brk(0x8051000)                          = 134549504
brk(0x8052000)                          = 134553600
lstat64("linux/drivers/sound", {st_dev=makedev(0, 10), st_ino=91677, st_mode=S_IFDIR|0755, st_nlink=4, st_uid=1046, st_gid=101, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2002/03/22-11:21:05, st_mtime=2001/01/05-00:16:17, st_ctime=2002/03/22-11:21:13}) = 0
access("linux/drivers/sound", W_OK)     = 0
open(".", O_RDONLY|O_LARGEFILE|O_DIRECTORY) = 3
chdir("linux/drivers/sound")            = 0
lstat64(".", {st_dev=makedev(0, 10), st_ino=91677, st_mode=S_IFDIR|0755, st_nlink=4, st_uid=1046, st_gid=101, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2002/03/22-11:21:05, st_mtime=2001/01/05-00:16:17, st_ctime=2002/03/22-11:21:13}) = 0
brk(0x8053000)                          = 134557696
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_dev=makedev(0, 10), st_ino=91677, st_mode=S_IFDIR|0755, st_nlink=4, st_uid=1046, st_gid=101, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2002/03/22-11:21:05, st_mtime=2001/01/05-00:16:17, st_ctime=2002/03/22-11:21:13}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
brk(0x8055000)                          = 134565888
getdents64(4, {{d_ino=91677, d_off=1, d_reclen=24, d_type=4, d_name="."} {d_ino=24250, d_off=2, d_reclen=24, d_type=4, d_name=".."} {d_ino=97912, d_off=3, d_reclen=40, d_type=0, d_name="ymfpci_image.h"} {d_ino=97911, d_off=4, d_reclen=40, d_type=0, d_name="cs4281_hwdefs.h"} {d_ino=97910, d_off=5, d_reclen=32, d_type=0, d_name="ymfpci.h"} {d_ino=97909, d_off=6, d_reclen=32, d_type=0, d_name="ymfpci.c"} {d_ino=97899, d_off=7, d_reclen=32, d_type=0, d_name="dmasound"} {d_ino=97865, d_off=8, d_reclen=32, d_type=0, d_name="emu10k1"} {d_ino=97864, d_off=9, d_reclen=40, d_type=0, d_name="cs461x_image.h"} {d_ino=97863, d_off=10, d_reclen=32, d_type=0, d_name="cs461x.h"} {d_ino=97862, d_off=11, d_reclen=32, d_type=0, d_name="Hwmcode.h"} {d_ino=97861, d_off=12, d_reclen=32, d_type=0, d_name="aedsp16.c"} {d_ino=97860, d_off=13, d_reclen=32, d_type=0, d_name="pas2.h"} {d_ino=97859, d_off=14, d_reclen=32, d_type=0, d_name="opl3_hw.h"} {d_ino=97858, d_off=15, d_reclen=32, d_type=0, d_name="gus.h"} {d_ino=97857, d_off=16, d1!
, d_reclen=32, d_type=0, d_name="skeleton.c"} {d_ino=97841, d_off=32, d_reclen=32, d_type=0, d_name="sb_ess.h"} {d_ino=97840, d_off=33, d_reclen=32, d_type=0, d_name="waveartist.h"} {d_ino=97839, d_off=34, d_reclen=32, d_type=0, d_name="cs4281.c"} {d_ino=97838, d_off=35, d_reclen=40, d_type=0, d_name="sequencer_syms.c"} {d_ino=97837, d_off=36, d_reclen=32, d_type=0, d_name="awe_hw.h"} {d_ino=97836, d_off=37, d_reclen=32, d_type=0, d_name="miroaci.h"} {d_ino=97835, d_off=38, d_reclen=32, d_type=0, d_name="midi_syms.c"} {d_ino=97834, d_off=39, d_reclen=32, d_type=0, d_name="v_midi.h"} {d_ino=97833, d_off=40, d_reclen=32, d_type=0, d_name="aci.c"} {d_ino=97832, d_off=41, d_reclen=32, d_type=0, d_name="esssolo1.c"} {d_ino=97831, d_off=42, d_reclen=32, d_type=0, d_name="yss225.h"} {d_ino=97830, d_off=43, d_reclen=32, d_type=0, d_name="yss225.c"} {d_ino=97829, d_off=44, d_reclen=32, d_type=0, d_name="wf_midi.c"} {d_ino=97828, d_off=45, d_reclen=32, d_type=0, d_name="wavfront.c"} {d_ino=97827, d_off=46, d_reclen=32, !
d_off=61, d_reclen=32, d_type=0, d_name="README.FIRST"} {d_ino=97811, d_off=62, d_reclen=40, d_type=0, d_name="sound_firmware.c"} {d_ino=97810, d_off=63, d_reclen=32, d_type=0, d_name="cmpci.c"} {d_ino=97809, d_off=64, d_reclen=40, d_type=0, d_name="msnd_pinnacle.c"} {d_ino=97808, d_off=65, d_reclen=32, d_type=0, d_name="hex2hex.c"} {d_ino=97807, d_off=66, d_reclen=32, d_type=0, d_name="ymf_sb.c"} {d_ino=97806, d_off=67, d_reclen=32, d_type=0, d_name="es1371.c"} {d_ino=97805, d_off=68, d_reclen=32, d_type=0, d_name="trident.c"} {d_ino=97804, d_off=69, d_reclen=32, d_type=0, d_name="maestro.c"} {d_ino=97803, d_off=70, d_reclen=32, d_type=0, d_name="mpu401.h"} {d_ino=97802, d_off=71, d_reclen=32, d_type=0, d_name="CHANGELOG"} {d_ino=97801, d_off=72, d_reclen=32, d_type=0, d_name="bin2hex.c"} {d_ino=97800, d_off=73, d_reclen=32, d_type=0, d_name="es1370.c"} {d_ino=97799, d_off=74, d_reclen=32, d_type=0, d_name="sound_core.c"} {d_ino=97798, d_off=75, d_reclen=32, d_type=0, d_name="vidc.c"} {d_ino=97797, d_off=76,l!
en=32, d_type=0, d_name="gus_hw.h"} {d_ino=97781, d_off=92, d_reclen=32, d_type=0, d_name="opl3sa.c"} {d_ino=97780, d_off=93, d_reclen=32, d_type=0, d_name="dev_table.h"} {d_ino=97779, d_off=94, d_reclen=32, d_type=0, d_name="coproc.h"} {d_ino=97778, d_off=95, d_reclen=40, d_type=0, d_name="ad1848_mixer.h"} {d_ino=97777, d_off=96, d_reclen=32, d_type=0, d_name="v_midi.c"} {d_ino=97776, d_off=97, d_reclen=32, d_type=0, d_name="uart6850.c"} {d_ino=97775, d_off=98, d_reclen=32, d_type=0, d_name="uart401.c"} {d_ino=97774, d_off=99, d_reclen=32, d_type=0, d_name="trix.c"} {d_ino=97773, d_off=100, d_reclen=24, d_type=0, d_name="sb.h"} {d_ino=97772, d_off=101, d_reclen=40, d_type=0, d_name="sound_timer.c"} {d_ino=97771, d_off=102, d_reclen=32, d_type=0, d_name="sys_timer.c"} {d_ino=97770, d_off=103, d_reclen=32, d_type=0, d_name="sequencer.c"} {d_ino=97769, d_off=104, d_reclen=32, d_type=0, d_name="sb_mixer.c"} {d_ino=97768, d_off=105, d_reclen=32, d_type=0, d_name="sb_midi.c"} {d_ino=97767, d_off=106, d_reclen=32, l!
en=32, d_type=0, d_name="gus_wave.c"} {d_ino=97751, d_off=122, d_reclen=32, d_type=0, d_name="gus_vol.c"} {d_ino=97750, d_off=123, d_reclen=32, d_type=0, d_name="gus_midi.c"} {d_ino=97749, d_off=124, d_reclen=32, d_type=0, d_name="gus_card.c"}}, 4096) = 4088
<SNIP SNIP SNIP>
lstat64("adlib_card.c", {st_dev=makedev(0, 10), st_ino=97743, st_mode=S_IFREG|0644, st_nlink=1, st_uid=1046, st_gid=101, st_blksize=4096, st_blocks=8, st_size=1366, st_atime=2002/03/22-11:21:05, st_mtime=2000/09/17-18:45:06, st_ctime=2002/03/22-11:21:09}) = 0
access("adlib_card.c", W_OK)            = 0
unlink("adlib_card.c")                  = 0
getdents64(4, {}, 4096)                 = 0
close(4)                                = 0
fchdir(3)                               = 0
close(3)                                = 0
rmdir("linux/drivers/sound")            = -1 ENOTEMPTY (Directory not empty)
write(2, "rm: ", 4rm: )                     = 4
write(2, "cannot remove directory `linux/d"..., 45cannot remove directory `linux/drivers/sound') = 45
write(2, ": Directory not empty", 21: Directory not empty)   = 21
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?

[root]:# /bin/ls linux/drivers/sound
Makefile  ad1848.c  audio.c  dmabuf.c  mpu401.c  os.h  soundcard.c

