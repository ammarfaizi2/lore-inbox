Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135635AbRD1VFr>; Sat, 28 Apr 2001 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135636AbRD1VFh>; Sat, 28 Apr 2001 17:05:37 -0400
Received: from relay.freedom.net ([207.107.115.209]:22020 "HELO relay")
	by vger.kernel.org with SMTP id <S135635AbRD1VFZ>;
	Sat, 28 Apr 2001 17:05:25 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQElylX+CBYdAXe4jt+G3/y3HWGiIz+hFg7Yaq5NS95q6/2co5HYrUZT
Date: Sat, 28 Apr 2001 15:05:04 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: Writing to Pana DVD-RAM
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010428210534Z135635-410+639@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To recap: running Panasonic LF-D101 DVDRAM drive on SCSI (AHA2740) and
getting segfaults.  On-disk format is UDF2.0, as 2.1 won't mount.

Mount, ls, umount, mount, ls, umount, etc - no problem.

Mount, cp <20Mfile>, umount, mount, ls, (20Mfile), umount, mount, ls, (20Mfile),
rpm -q 20Mfile, umount, etc - no problem.

Mount, rm <20Mfile>, Segmentation Fault, umount, (device busy), umount, (device busy), etc.  Reboot without reset and bootup hangs at Running Linuxconf hooks.  Boot to Windows & try to access DVDRAM & it says "Not formatted, would you like to format?"  Power-cycle =only= the DVDRAM & then it works fine.  The Linux CD driver is messing up the controller in the drive.

Reset system & boots fine to Linux.  Mount, ls, (no files), umount, mount, ls, (no files), umount, etc.

Again copy file to, & it seems fine.

(Help - Jens has been too busy)
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


Keywords: DVDRAM DVD-RAM LF-D101 LFD101 cdrecord


The log is:
Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 20:59:31 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 20:59:50 hydra last message repeated 3 times
Apr 15 21:00:17 hydra mon[1258]: failure for servers http 987390017 localhost
Apr 15 21:01:11 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 21:03:25 hydra last message repeated 2 times
Apr 15 21:03:40 hydra kernel: kernel BUG at inode.c:890!
Apr 15 21:03:40 hydra kernel: invalid operand: 0000
Apr 15 21:03:40 hydra kernel: CPU:    0
Apr 15 21:03:40 hydra kernel: EIP:    0010:[iput_free+216/352]
Apr 15 21:03:40 hydra kernel: EIP:    0010:[<c01461c8>]
Apr 15 21:03:40 hydra kernel: EFLAGS: 00010286
Apr 15 21:03:40 hydra kernel: eax: 0000001b   ebx: cb1ad640   ecx: 00000004
edx: c5508840
Apr 15 21:03:40 hydra kernel: esi: c0319560   edi: cb4f2740   ebp: bffff678   esp:
c9d5ff20
Apr 15 21:03:40 hydra kernel: ds: 0018   es: 0018   ss: 0018
Apr 15 21:03:40 hydra kernel: Process rm (pid: 2254, stackpage=c9d5f000)
Apr 15 21:03:40 hydra kernel: Stack: c02a1610 c02a16f3 0000037a 00000000
00000012 c3920000 cffb3560 cb4f2740
Apr 15 21:03:40 hydra kernel:        cb1ad640 c0144a3c cb1ad640 00000184
fffffff0 c39229c0 cb4f2740 00000000
Apr 15 21:03:40 hydra kernel:        c39229c0 c013e31c cb4f2740 cfc83d40
c9d5ff9c 00000000 ffffffeb cb4f2740
Apr 15 21:03:40 hydra kernel: Call Trace: [error_table+39488/42452]
[error_table+39715/42452] [d_delete+76/112] [vfs_unlink+316/368]
[sys_unlink+150/272] [do_page_fault+0/1088] [system_call+51/56]
Apr 15 21:03:40 hydra kernel: Call Trace: [<c02a1610>] [<c02a16f3>]
[<c0144a3c>] [<c013e31c>] [<c013e3e6>] [<c0112de0>] [<c0108ffb>]
Apr 15 21:03:40 hydra kernel:
Apr 15 21:03:40 hydra kernel: Code: 0f 0b 83 c4 0c eb 69 90 39 1b 74 3c f6 83 f8
00 00 00 07 75
Apr 15 21:04:18 hydra mon[1258]: failure for servers http 987390258 localhost


ver_linux
Linux hydra.darkmatter.com 2.4.2-0.1.49 #1 Sun Apr 15 18:12:33 MDT 2001 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         via82cxxx_audio ac97_codec binfmt_misc autofs
nls_iso8859-1 nls_cp437
cdrecord             1.9-6

