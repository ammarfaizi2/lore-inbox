Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315680AbSECUGB>; Fri, 3 May 2002 16:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315682AbSECUGA>; Fri, 3 May 2002 16:06:00 -0400
Received: from mnh-1-23.mv.com ([207.22.10.55]:48138 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315680AbSECUF7>;
	Fri, 3 May 2002 16:05:59 -0400
Message-Id: <200205032108.QAA04417@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: UML is now self-hosting!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 16:08:45 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML is now able to run nested inside itself.  This works as of UML 2.4.18-21,
which isn't released yet, but will be soon.  See the log below for the gory 
details, and also see http://user-mode-linux.sf.net/nesting.html for how to
do it yourself.

This is a sign of UML maturity rather than any new magic functionality having
been added.  UML is a demanding process, so even though it uses only the Linux
system call interface, it takes some maturity for a Linux kernel to host it.

The missing pieces were a couple of signal delivery bugs that were still 
lurking.  Once these were fixed, UML booted right up.

				Jeff

Here's the log of the first nested boot.

Notes:
	'usermode:~#' is the UML shell prompt. 
	/dev/ubd/1 has been attached to a tomsrtbt image on the host
	~/linux/2.4/nest/linux is the specially build nested UML. 

Also note the back-to-back UML shutdowns at the very end. 

usermode:~# scp jdike@192.168.0.254:linux/2.4/nest/linux .
jdike@192.168.0.254's password: 
scp: warning: Executing scp1 compatibility.
linux                100% |*****************************|  8227 KB    00:00 ETA
usermode:~# ls -l linux
-rwxr--r--    1 root     root      8424800 May  3 21:09 linux
usermode:~# ./linux ubd0=/dev/ubd/1
tracing thread pid = 146
Linux version 2.4.18-21um (jdike@uml.karaya.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #1 Wed May 1 21:07:32 EDT 2002
On node 0 totalpages: 8192
zone(0): 0 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: ubd0=/dev/ubd/1 root=/dev/ubd0
Calibrating delay loop... 707.26 BogoMIPS
Memory: 32244k available
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Reading /proc/cpuinfo failed, errno = 2
Yes
Checking for host processor xmm support...Reading /proc/cpuinfo failed, errno = 2
No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Initializing stdio console driver
Initializing software serial port version 1
mconsole (version 1) initialized on /root/.uml/yfWc2E/mconsole
Partition check:
 ubda: unknown partition table
UML Audio Relay: May  1 2002 21:17:10
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.84 booting
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
INIT: Entering runlevel: 5


Welcome to the uml version of Tom's root/boot.

This is a customized version, so the notice below is displayed
at Tom's request.

*******************************************************************************
* If you base something on it, use any of the scripts, distribute binaries or *
* libraries from it, or distribute customized versions of it: You must credit *
* tomsrtbt and include a pointer to http://www.toms.net/rb/ and tom@toms.net, *
* and include this notice verbatim. Copyright Tom Oehser 1999. This notice in *
* no way supercedes or nullifies any other protections on the component parts *
* such as the BSD and GPL copyrights which apply to practically everything!!! *
* Within these strictures you may redistribute, incorporate, copy, modify, or *
* do anything else to it or with it that you like. Tomsrtbt has no warranties *
* not even implied fitness or usefulness.  If it breaks you keep both pieces. *
*******************************************************************************





        What you have is...

3c589_cs advansys agetty aha152x aha152x_cs aha1542 aic7xxx ash awk badblocks
bdflush buildit.s busLogic busybox bzip2 cardbus cardmgr cat ce ce.help chain.b
chattr chgrp chmod chown chroot clear clone.s cmp common config cp cpio cut date
dd ddate debugfs df dhcpcd dirname dmesg ds du dumpe2fs e2fsck eata echo echo.c
elvis emacs ex extend false fdflush fdformat fdisk fdomain filesize find
findsuper fmt fsck.ext2 fsck.msdos fstab grep group gzip halt head hexdump
hexedit host.conf hostname hosts i82365 ifconfig ifport ile image init init.old
inittab insmod install.s ioctl.save issue kill killall5 ksyms ld ld-linux length
less libc libcom_err libe2p libext2fs libss libtermcap libuuid lilo lilo.conf ln
loadkeys login losetup ls lsattr man mawk md5sum memtest miterm mkdir mkdosfs
mke2fs mkfifo mkfs.minix mklost+found mknod mkswap mnsed more more.help mount mt
mtab mv nc ncr53c8xx network networks nmclan_cs ntfs passwd pax pcmcia
pcmcia_core pcnet_cs ping plip ppa printf profile protocols ps pwd qlogic_cs
qlogicfas rc.0 rc.6 rc.M rc.S rc.custom rc.custom.gz rc.custom~ reboot rescuept
reset resolv.conf rm rmdir rmmod route rsh rshd script scsi scsi_info seagate
sed serial serial_cs services setserial settings.s sh shared shutdown slattach
sleep snarf sort split stty swapoff swapon sync tail tar tcic tee telnet telnetd
termcap test tomcr.txt tomshexd tomsrtbt.FAQ touch true tune2fs umount undeb
undeb-- unpack.s unrpm-- update utmp vi vi.help view wc wtmplock

        ...Login as root.

 ttys/0 tomsrtbt login: root
Password: ile rev.2.01
Today is Pungenday, the 50th day of Discord in the YOLD 3168
Celebrate Discoflux
# ps uax
1       S       (init) init 
2       S       (keventd) 
3       S       (ksoftirqd_CPU0) 
4       S       (kswapd) 
5       S       (bdflush) 
6       S       (kupdated) 
7       S       (mtdblockd) 
55      S       (ile) ile /bin/sh -c . /etc/profile -si 
59      S       (sh) /bin/sh -c . /etc/profile -si 
61      S       (ps) /bin/sh /usr/bin/ps uax 
62      R       (ps) /bin/sh /usr/bin/ps uax 
63      R       (sed) sed -e s/\ / /g 
# halt
INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal

halt
System halted.
nbd: module cleaned up.

usermode:~# halt

Broadcast message from root (vc/0) Fri May  3 21:24:09 2002...

The system is going down for system halt NOW !!
INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
INIT: Sending processes the KILL signal
Stopping internet superserver: inetd.
Stopping OpenBSD Secure Shell server: sshd.
Saving the System Clock time to the Hardware Clock...
hwclock: Can't open /dev/tty1, errno=2: No such file or directory.
hwclock is unable to get I/O port access:  the iopl(3) call failed.
Hardware Clock updated to Fri May  3 21:25:17 CEST 2002.
Stopping portmap daemon: portmap.
Stopping NFS kernel daemon: mountd nfsd.
Unexporting directories for NFS kernel daemon...done.
Stopping NFS common utilities: statd.
Stopping system log daemon: klogd syslogd.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces: done.
Deactivating swap... done.
Unmounting local filesystems... done.
* route del -host 192.168.0.253 dev tap0
* bash -c echo 0 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
* arp -i eth0 -d 192.168.0.253 pub
Power down.
nbd: module cleaned up.

um 1012: 

