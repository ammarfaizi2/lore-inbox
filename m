Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTEaSmB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTEaSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:42:01 -0400
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:30141
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S264383AbTEaSl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:41:58 -0400
Subject: Some oddities from 2.5.67 to 2.5.70-mm3
From: Edward Tandi <ed@efix.biz>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1054407348.2543.25.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 31 May 2003 19:55:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying the 2.5.x series of kernels periodically. I have to
say it appears to be getting much better recently and it is nearly at
the point where I can use it to replace my 2.4 kernel. There are just a
few things that remain a problem for me.

I have included a brief report below. Any help with the 3 issues below
would be great.

Ed-T.


Configuration
-------------

Mandrake 9.1, Asus A7V8X (KT400), Athlon 1500XP, 1GB RAM, NVidia Ti4600,
Tulip based Network card.

Working: Network+NFS+ypbind, Audio, Gnome2, XMMS, mplayer, Browsers,
Evolution, UT2003, Half-Life under Winex3.0 and all apps under
CrossoverOffice. Almost everything works in fact.


Not working (3 items below)
---------------------------

1) gnome-terminal only works as user root
As a normal user, running '> gnome-terminal' brings up the window and
the command returns to the console without destroying the window. No
prompt appears in the window.

Output from strace:
socket(PF_UNIX, SOCK_STREAM, 0)         = 16
fcntl64(16, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
fcntl64(16, F_SETFD, FD_CLOEXEC)        = 0
connect(16, {sa_family=AF_UNIX,
path="/tmp/orbit-ed/linc-9be-0-37de7a363048"}, 39) = 0
writev(16, [{"GIOP\1\2\1\0\264\0\0\0", 12},
{"@\366\377\277\1\0\0\0\0\0\0\0\34\0\0\0\0\0\0\0I\350\250"..., 180}], 2)
= 192
writev(16, [{"GIOP\1\2\1\5\4\0\0\0", 12}, {"@\366\377\277", 4}], 2) = 16
close(16)                               = 0
write(10, "\1\v\1\0\1\0\0\0\0\0\0\0\0\0\0\0", 16) = 16
close(10)                               = 0
exit_group(0)                           = ?

As root I get the following warning from stdout/stderr:
(gnome-terminal:2860): GnomeUI-WARNING **: While connecting to session
manager:
Authentication Rejected, reason : None of the authentication protocols
specified are supported and host-based authentication failed.

2) xosview freezes
Window does not appear but command does not terminate.

Output from strace:
gettimeofday({1054402703, 859349}, NULL) = 0
open("/proc/stat", O_RDONLY)            = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40017000
read(4, "cpu  119092 0 2877 71609 3723\ncp"..., 8192) = 628
read(4, "", 7168)                       = 0
read(4, "", 8192)                       = 0

> cat /proc/stat
cpu  132749 0 2987 76060 3723
cpu0 132749 0 2987 76060 3723
intr 2370847 2155207 6827 0 0 0 0 3 1800 0 63850 35514 85105 52 0 22424
65 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
ctxt 2049582
btime 1054400731
processes 2802
procs_running 2
procs_blocked 0


3) Gamepad/rmmod issue

For some reason the system appears to be ignoring module parameters and
gets the type of my gamepad wrong. It may be because it is loading a new
module for which I don't have settings for in /etc/modules.conf. The
kernel appears to have two check-boxes for pc-joysticks. The biggest
problem is that I cannot remove the modules. '> rmmod analog' or any
other module for that matter gives:

Can't open 'analog': No such file or directory

rmmod _is_ supposed to be compatible with 2.5.x series kernels. From the
man page:
BACKWARDS COMPATIBILITY
 This version of rmmod is for kernels 2.5.48 and above.  If it detects a
 kernel with support for old-style modules (for which much of  the  work
 was  done in userspace), it will attempt to run rmmod.old in its place,
 so it is completely transparent to the user.

Also, "module unloading" is checked in the kernel build.


Other oddities
--------------

1) from /var/log/messages:
/sbin/mingetty[2583]: /dev/tty4: cannot open tty: Inappropriate ioctl
for device

2) Excessive anticipatory scheduler messages. from dmesg:
scsi2 : SCSI emulation for USB Mass Storage devices
anticipatory scheduling elevator
  Vendor: Datafab   Model: KECF-USB          Rev: 0113
    Type:   Direct-Access                      ANSI SCSI revision: 02
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
anticipatory scheduling elevator

In fact it continues to be printed all over the place.

3) from dmesg:
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
named appears to be working however.


