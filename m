Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUJDV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUJDV0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUJDVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:25:33 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:29598 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S268582AbUJDVXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:23:22 -0400
Message-ID: <4161B6AF.1010705@drdos.com>
Date: Mon, 04 Oct 2004 14:46:39 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: 2.6.9-rc2-mm4 stat -f sickness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9-rc2-mm4 the command "stat -f /dev/<device>" always returns
EXT2_SUPER_MAGIC and other bogus information even if other filesystems
are mounted on the device.  

Trace info attached.   Reported mount info, strace info, and stat -f
info included.

mount info

/dev/hda3 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/hda1 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
/dev/sda1 on /pfs type dsfs (rw)
/dev/sda2 on /storage type dsfs (rw)

df -h (df says .....)

Filesystem            Size  Used Avail Use% Mounted on
/dev/hda3             9.7G  7.2G  2.0G  79% /
/dev/hda1             190M  9.5M  171M   6% /boot
none                  1.5G     0  1.5G   0% /dev/shm
/dev/sda1             936G  936G     0 100% /pfs
/dev/sda2             936G  936G     0 100% /storage

stat -f /dev/sda1 (bogus info)
 
  File: "/dev/sda1"
    ID: 0        Namelen: 255     Type: ext2/ext3
Blocks: Total: 2520130    Free: 651513     Available: 523496     Size: 4096
Inodes: Total: 1281696    Free: 878949    

strace of stat -f /dev/sda1 (bogus info)

execve("/usr/bin/stat", ["stat", "-f", "/dev/sda1"], [/* 26 vars */]) = 0
uname({sys="Linux", node="datascout4", ...}) = 0
brk(0)                                  = 0x8052000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=123802, ...}) = 0
old_mmap(NULL, 123802, PROT_READ, MAP_PRIVATE, 3, 0) = 0x37fcc000
close(3)                                = 0
open("/lib/libselinux.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\350\261"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=60776, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x37fcb000
old_mmap(0x47898000, 64532, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x37fbb000
old_mmap(0x37fc9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x37fc9000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\v\327"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1455084, ...}) = 0
old_mmap(0x46d5c000, 1158124, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x37ea0000
old_mmap(0x37fb5000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x115000) = 0x37fb5000
old_mmap(0x37fb9000, 7148, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x37fb9000
close(3)                                = 0
mprotect(0x37fb5000, 8192, PROT_READ)   = 0
mprotect(0x38000000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x37fcbae0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x37fcc000, 123802)              = 0
brk(0)                                  = 0x8052000
brk(0x8073000)                          = 0x8073000
open("/proc/mounts", O_RDONLY)          = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x37fea000
read(3, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 285
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x37fea000, 4096)                = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40263984, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x37ca0000
close(3)                                = 0
statfs64("/dev/sda1", 84, {f_type="EXT2_SUPER_MAGIC", f_bsize=4096, f_blocks=2520130, f_bfree=651513, f_bavail=523496, f_files=1281696, f_ffree=878950, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
fstat64(1, {st_mode=S_IFREG|0644, st_size=2718, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x37c9f000
write(1, "  File: \"/dev/sda1\"\n    ID: 0   "..., 189  File: "/dev/sda1"
    ID: 0        Namelen: 255     Type: ext2/ext3
Blocks: Total: 2520130    Free: 651513     Available: 523496     Size: 4096
Inodes: Total: 1281696    Free: 878950    
) = 189
close(1)                                = 0
munmap(0x37c9f000, 4096)                = 0
exit_group(0)                           = ?


Get the can of RAID.  Monster bugs.



Jeff

