Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133103AbRDLLOI>; Thu, 12 Apr 2001 07:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133102AbRDLLN7>; Thu, 12 Apr 2001 07:13:59 -0400
Received: from proxy.eu.intermec.com ([193.14.168.10]:19102 "EHLO
	yar.eu.intermec.com") by vger.kernel.org with ESMTP
	id <S133099AbRDLLNs>; Thu, 12 Apr 2001 07:13:48 -0400
Message-ID: <3AD58DE9.2C348241@intermec.com>
Date: Thu, 12 Apr 2001 13:13:45 +0200
From: Daniel Deimert <daniel.deimert@intermec.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
CC: alan@redhat.com
Subject: PROBLEM: Linux 2.2.19 system crash with Oops in scsi_do_cmd during 
 mirror rebuild on megaraid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Linux 2.2.19 system crash with Oops in scsi_do_cmd during mirror rebuild
on megaraid

[2.] Full description of the problem/report:

Seconds after starting a rebuild of a mirrored partition on a megaraid
controller, the
system crashed. It might be reproducable but since this is a production
system I have
not attempted to do it again.

Before I attempted to rebuild the mirror set, I got several kernel
messages like this
    kernel: scsidisk I/O error: dev 08:11, sector 71077808
This is on a mirrored partition that the megaraid utility verified to be
flawless.
After the crash, fsck could not repair the file system completely - when
it tried
to write new block descriptors, it got "short write" write errors.
Again, the
megaraid bios said the mirror set was healthy and the individual disks
had not
returned any hardware errors. "mke2fs" had no problems to write
anywhere, and it
also stopped the error messages.

[3.] Keywords (i.e., modules, networking, kernel):

filesystem, scsi, megaraid, kupdate

[4.] Kernel version (from /proc/version):

Linux version 2.2.19 (root@localhost) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Apr 3 21:56:41 CEST 2001



[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

I had to type this in by hand and some of it had scrolled of screen so
you will have
to forgive any minor errors--  couldn't you guys please put one of the
crash
dump patches into the mainstream kernel?


kernel: EFLAGS: 00010092
kernel: eax: 00000000   ebx: bff78078   ecx: bff7bba8   edx: bff7a534
kernel: esi: bff7b68c   edi: bff78800   ebp: bffdfe10   esp: bffdfdb8
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kupdate (pid: ?, process nr: ?, stackpage=bffdf000)
kernel: Stack: 801edbbb bffbdc00 801f23fc 00000b40 bffdfef0 bffbdc00
bffdfee8 bfff7400
kernel:        00000002 00000000 ffffffff 00000000 00000001 00000000
80222ef7 002f9956
kernel:        63222f40 00000009 00000000 bffd7aa0 8025480d bffdfe20
bf4462a0 801fa4e4
kernel: Call Trace: [scsi_do_cmd+1190/1264] [scsi_old_done+0/1404]
[__delay+19/36]
kernel:             [RCSid+3757/51072] [requeue_sd_request+4072/4088]
[rw_intr+0/1604]
kernel:             [scsi_do_cmd+1190/1264] [scsi_old_done+0/1404]
[tcp_v4_do_rcv+112/380]
kernel:             [sys_pipe+12/120] [make_request+1870/1992]
[ll_rw_block+335/440]
kernel:             [sync_old_buffers+214/452] [tvecs+12075/14016]
[kupdate+132/136]
kernel:             [get_options+0/116] [kernel_thread+35/48]
kernel: Code: 80 78 45 81 0f 85 a0 00 00 00 c7 46 60 00 00 00 c7 46 64


[7.] Environment
DELL 6300
DELL PERC Megaraid firmware [U.84:1.63]
Red Hat Linux 6.2
Linux 2.2.19 stock tar.gz
Intel e100 network card driver module v1.5.5 loaded
Intel iANS network module v1.2.29 loaded

Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.24
util-linux             2.10m
modutils               2.1.121
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.3.10
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.4
Net-tools              1.53
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded         e100 ians


[X.] Other notes


--
Daniel.Deimert@intermec.com     Intermec Printers, Gothenburg, Sweden
http://www.intermec.com/



