Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbRK0V5i>; Tue, 27 Nov 2001 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRK0V53>; Tue, 27 Nov 2001 16:57:29 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:43210 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S282978AbRK0V5Z>;
	Tue, 27 Nov 2001 16:57:25 -0500
Message-ID: <E8139C9A62384F49A7EBF9CCCD2243C101B88A@umr-mail2.umr.edu>
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux@3ware.com'" <linux@3ware.com>
Subject: Problems with 3ware 3dm and 2.4.16...
Date: Tue, 27 Nov 2001 15:57:03 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent this to 3ware, they are going to look into it, but I figured I'd
ask here as well. I've got 3 machines with this problem.

When running 2.4.10, everything works fine, as soon as I move to 2.4.16
though, the 3ware 3dm process no longer works, it claims to get a ioctl
error 'no such device or address'. Interesting thing is - from the below
output, looks like the ioctl worked.

The drive itself (sda) is working just fine, and I'm getting the AEN notices
about drive status in kmesg logs. I have not tried anything more recent
prior to 2.4.16 though.

I did try backing the 3w-xxxx.[ch] off to the version in 2.4.10, which
didn't help. This problem occurs when built with gcc302 or rh71's kgcc (egcs
1.1.2).

Does anyone have a working 2.4.16+3ware setup?

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216


-----Original Message-----
From: Neulinger, Nathan 
Sent: Tuesday, November 27, 2001 2:05 PM
To: 'linux@3ware.com'
Subject: Problems with 3dm and 2.4.16...


I just tried moving a couple machines to 2.4.16, and found that 3dm now does
not work. At startup, it is getting an error on the ioctl(4, ...) call. 

Any idea what might be happening? It's been working fine with 2.4.10.

Here's the relevant chunk of strace:


2963  open("/proc/scsi/3w-xxxx",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
2963  fstat64(3, {st_dev=makedev(0, 3), st_ino=4337, st_mode=S_IFDIR|0555,
st_nlink=2, st_uid=0, st_gid=0,
 st_blksize=4096, st_blocks=0, st_size=0, st_atime=2001/11/27-14:02:53,
st_mtime=2001/11/27-14:02:53, st_c
time=2001/11/27-14:02:53}) = 0
2963  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
2963  getdents64(3, {{d_ino=4337, d_off=1, d_reclen=24, d_type=4,
d_name="."} {d_ino=4335, d_off=2, d_recl
en=24, d_type=4, d_name=".."} {d_ino=4338, d_off=3, d_reclen=24, d_type=8,
d_name="0"}}, 4096) = 72
2963  open("/proc/scsi/3w-xxxx/0", O_RDONLY) = 4
2963  fstat64(4, {st_dev=makedev(0, 3), st_ino=4338, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0,
 st_blksize=4096, st_blocks=0, st_size=0, st_atime=2001/11/27-14:02:53,
st_mtime=2001/11/27-14:02:53, st_c
time=2001/11/27-14:02:53}) = 0
2963  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40000000
2963  read(4, "scsi0: 3ware Storage Controller\nDriver version:
1.02.00.010\nCurrent commands posted:     
    0\nMax commands posted:           173\nCurrent pending commands:
0\nMax pending commands:      
      0\nLast sgl length:                 0\nMax sgl length:
62\nLast sector count:       
        8\nMax sector count:              128\nResets:
0\nAborts:                
          0\nAEN\'s:                           2\n", 4096) = 445
2963  close(4)                          = 0
2963  munmap(0x40000000, 4096)          = 0
2963  open("/dev/sdp", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdo", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdn", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdm", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdl", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdk", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdj", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdi", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdh", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdg", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdf", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sde", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdd", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdc", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sdb", O_RDWR)          = -1 ENXIO (No such device or
address)
2963  open("/dev/sda", O_RDWR)          = 4
2963  ioctl(4, FIBMAP, 0xbfffee40)      = 327680
2963  fstat64(1, {st_dev=makedev(0, 7), st_ino=2, st_mode=S_IFCHR|0620,
st_nlink=1, st_uid=0, st_gid=5, st
_blksize=1024, st_blocks=0, st_rdev=makedev(136, 0),
st_atime=2001/11/27-14:02:53, st_mtime=2001/11/27-14:
02:53, st_ctime=2001/11/27-13:58:24}) = 0
2963  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40000000
2963  ioctl(1, TCGETS, {c_iflags=0x506, c_oflags=0x1805, c_cflags=0x4bd,
c_lflags=0x8a3b, c_line=0, c_cc="
\x03\x1c\x7f\x15\x04\x00\x01\x00\x11\x13\x1a\x00\x12\x0f\x17\x16\x00\x00\x2f
\x00\x00\x00\x00\x00\x00\x00\x
00\x54\xed\x0f\x08\x00"}) = 0
2963  write(1, "ioctl(4) failed: No such device or address\n", 43) = 43
2963  close(4)                          = 0
2963  getdents64(3, {}, 4096)           = 0
2963  close(3)                          = 0
2963  getuid32()                        = 0
2963  open("/etc/3dmd.conf", O_RDONLY)  = 3
2963  fstat64(3, {st_dev=makedev(8, 6), st_ino=54373, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0
, st_blksize=4096, st_blocks=8, st_size=229, st_atime=2001/11/27-14:02:53,
st_mtime=2001/08/03-11:39:49, s
t_ctime=2001/11/27-10:46:08}) = 0
2963  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40001000
2963  read(3, "EMAIL Yes\nSERVER smtp.umr.edu\nSENDER sysmon\nRCPT
servers@umr.edu\nAUDIO Yes\nCALL3WARE N



-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
