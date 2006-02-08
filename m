Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWBHHs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWBHHs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWBHHs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:48:56 -0500
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:31207 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id S1161064AbWBHHsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:48:55 -0500
Message-ID: <43E9A260.6000202@l4x.org>
Date: Wed, 08 Feb 2006 08:48:48 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051017 Thunderbird/1.0.7 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <43E90573.8040305@l4x.org> <20060207162335.5304ae61.akpm@osdl.org>
In-Reply-To: <20060207162335.5304ae61.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.2.134
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. 
 Have a nice day...
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on ds666.starfleet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jan Dittmer <jdi@l4x.org> wrote:
> 
>>Debian 2.6.15-1-686-smp
>>
>>$ umount /mnt/data
>>Segmentation Fault
>>
>>dmesg:
>>
>>VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
>>Unable to handle kernel NULL pointer dereference at virtual address 00000034
> 
> 
> That was clever.
> 
> 
>> printing eip:
>>f88c7e07
>>*pde = 00000000
>>Oops: 0000 [#1]
>>SMP
>>Modules linked in: xfs rfcomm l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc  ipv6 deflate zlib_deflate twofish serpent aes blowfish des sha256
>>sha1 crypto_n ull af_key raid5 xor dm_mod tun vfat fat loop lp usbmouse eeprom i2c_dev i2c_isa  i2c_core usbkbd usb_storage ehci_hcd button processor
>>ac ide_cd cdrom e100 mii 3w_xxxx e1000 joydev piix serio_raw uhci_hcd generic parport_pc ide_core usbcore  parport pcspkr psmouse rtc ext3 jbd mbcache
>>raid1 md_mod sd_mod aic79xx scsi_tr ansport_spi scsi_mod shpchp pci_hotplug evdev mousedev
>>CPU:    2
>>EIP:    0060:[<f88c7e07>]    Not tainted VLI
>>EFLAGS: 00210282   (2.6.15-1-686-smp)
>>EIP is at ext3_show_options+0x13/0xd5 [ext3]
>>eax: 00000000   ebx: f7f1fe00   ecx: da82c540   edx: 00000000
>>esi: da82c540   edi: da82c540   ebp: 00000400   esp: f7bcbf18
>>ds: 007b   es: 007b   ss: 0068
>>Process mv (pid: 4409, threadinfo=f7bca000 task=e9978a70)
>>Stack: 00000000 dfd74c00 c01646cf da82c540 dfd74c00 da82c540 dfd74c00 00000143
>>       c0167ffd da82c540 dfd74c00 00000000 da82c560 0000000a 00000000 00000009
>>       00000000 00000400 e64cea80 40019000 00000000 c014ca9d e64cea80 40019000
>>Call Trace:
>> [<c01646cf>] show_vfsmnt+0xcf/0xe6
>> [<c0167ffd>] seq_read+0x199/0x26a
>> [<c014ca9d>] vfs_read+0xa1/0x138
> 
> 
> Have you any idea what `mv' was doing in ext3_show_options?  I can only
> think that something was doing `mv /proc/mounts somewhere-else', which is
> odd.

No, but it is indeed called:

execve("/bin/mv", ["mv", "t", "t2"], [/* 25 vars */]) = 0
uname({sys="Linux", node="ds666", ...}) = 0
brk(0)                                  = 0x8058000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f5d000
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=127118, ...}) = 0
old_mmap(NULL, 127118, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f3d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libacl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\23"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=27816, ...}) = 0
old_mmap(NULL, 30788, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f35000
old_mmap(0xb7f3c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0xb7f3c000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libselinux.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2201\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=75508, ...}) = 0
old_mmap(NULL, 76816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f22000
old_mmap(0xb7f34000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12000) = 0xb7f34000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1262704, ...}) = 0
old_mmap(NULL, 1272764, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7deb000
old_mmap(0xb7f18000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12c000) = 0xb7f18000
old_mmap(0xb7f20000, 7100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f20000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libattr.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \v\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=10608, ...}) = 0
old_mmap(NULL, 13564, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7de7000
old_mmap(0xb7dea000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xb7dea000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libdl.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9592, ...}) = 0
old_mmap(NULL, 12404, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7de3000
old_mmap(0xb7de5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xb7de5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libsepol.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\"\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=194624, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7de2000
old_mmap(NULL, 235876, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7da8000
old_mmap(0xb7dd7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2f000) = 0xb7dd7000
old_mmap(0xb7dd8000, 39268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7dd8000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7da7000
mprotect(0xb7f18000, 20480, PROT_READ)  = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7da76c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}) = 0
munmap(0xb7f3d000, 127118)              = 0
access("/etc/selinux/", F_OK)           = -1 ENOENT (No such file or directory)
brk(0)                                  = 0x8058000
brk(0x8079000)                          = 0x8079000
open("/proc/mounts", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f5c000
read(3, "rootfs / rootfs rw 0 0\n/dev/md7 "..., 1024) = 510
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0xb7f5c000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=127118, ...}) = 0
old_mmap(NULL, 127118, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f3d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/i686/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/i686/sse2", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/i686/cmov", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/tls/i686/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/i686", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/tls/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/lib/tls/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/sse2", 0xbfd7302c)     = -1 ENOENT (No such file or directory)
open("/lib/tls/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/cmov", 0xbfd7302c)     = -1 ENOENT (No such file or directory)
open("/lib/tls/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/i686/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/lib/i686/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/sse2", 0xbfd7302c)    = -1 ENOENT (No such file or directory)
open("/lib/i686/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/cmov", 0xbfd7302c)    = -1 ENOENT (No such file or directory)
open("/lib/i686/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686", 0xbfd7302c)         = -1 ENOENT (No such file or directory)
open("/lib/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/sse2/cmov", 0xbfd7302c)    = -1 ENOENT (No such file or directory)
open("/lib/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/sse2", 0xbfd7302c)         = -1 ENOENT (No such file or directory)
open("/lib/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/cmov", 0xbfd7302c)         = -1 ENOENT (No such file or directory)
open("/lib/libsetrans.so.0", O_RDONLY)  = -1 ENOENT (No such file or directory)
stat64("/lib", {st_mode=S_IFDIR|0755, st_size=12288, ...}) = 0
open("/usr/lib/tls/i686/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/i686/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/i686/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/i686/sse2", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/i686/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/i686/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/i686/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/i686", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/sse2", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/lib/i686/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/i686/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/i686/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/i686/sse2", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/i686/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/i686/cmov", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/lib/i686/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/i686", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/lib/sse2/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/sse2/cmov", 0xbfd7302c) = -1 ENOENT (No such file or directory)
open("/usr/lib/sse2/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/sse2", 0xbfd7302c)     = -1 ENOENT (No such file or directory)
open("/usr/lib/cmov/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/cmov", 0xbfd7302c)     = -1 ENOENT (No such file or directory)
open("/usr/lib/libsetrans.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib", {st_mode=S_IFDIR|0755, st_size=163840, ...}) = 0
munmap(0xb7f3d000, 127118)              = 0
geteuid32()                             = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
open("/proc/filesystems", O_RDONLY|O_LARGEFILE) = 3
read(3, "nodev\tsysfs\nnodev\trootfs\nnodev\tb"..., 4095) = 253
close(3)                                = 0
stat64("t2", 0xbfd73608)                = -1 ENOENT (No such file or directory)
lstat64("t", {st_mode=S_IFREG|0644, st_size=44371, ...}) = 0
lstat64("t2", 0xbfd733e4)               = -1 ENOENT (No such file or directory)
rename("t", "t2")                       = 0
close(1)                                = 0
exit_group(0)                           = ?

Jan
