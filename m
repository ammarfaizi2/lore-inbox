Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTEOVEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTEOVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:04:38 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:36616 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S264236AbTEOVEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:04:34 -0400
Subject: 2.4.21rc2 crashes mounting HFS CDROM on SCSI drive
To: linux-kernel@vger.kernel.org
Date: Thu, 15 May 2003 23:17:23 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19GQ6N-00023N-00@petersfehn.Informatik.Uni-Oldenburg.DE>
From: "Ingo Wilken" <Ingo.Wilken@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System 1:
	AMD K6/2-400, 256MB RAM, Symbios 53c875
	Plextor 40X SCSI CDROM, Yamaha 8824 SCSI CD-RW
	Debian 3.0 with custom kernel 2.4.21-rc2
System 2:
	AMD Duron-800, 512MB RAM, Symbios 53c860
	Plextor 40X SCSI CDROM, Yamaha 2100 SCSI CD-RW
	Debian 3.0 with custom kernel 2.4.21-pre6
System 3:
	Intel Pentium III Mobile, 256MB RAM, internal ATAPI CDROM
	Debian 3.0 with custom kernel 2.4.21-pre6

All kernels are built from vanilla sources from kernel.org without
additional patches.

On both SCSI systems, mounting any HFS CD (i.e., in Apple format, not ISO)
results in a crash of the CDROM driver - locking the CD-drive, but the
rest of the system continues to run (including other SCSI CDROM drives,
only the drive with the HFS CD is unuseable until a reboot).
See below for the crash message.

Mounting the same CDs on system 3 with the ATAPI CDROM works just fine.

Creating an image of the CDs on the SCSI systems, then mounting this
image via the loop device also works:
	dd if=/dev/sr0 of=somefile bs=2048
	mount somefile /maccdrom -t hfs -o loop


Crash message from the K6/2:

May 15 23:35:36 carbon kernel: kernel BUG at buffer.c:2510!
May 15 23:35:36 carbon kernel: invalid operand: 0000
May 15 23:35:36 carbon kernel: CPU:    0
May 15 23:35:36 carbon kernel: EIP:    0010:[grow_buffers+61/276]    Not tainted
May 15 23:35:36 carbon kernel: EFLAGS: 00010206
May 15 23:35:36 carbon kernel: eax: 000007ff   ebx: 00000000   ecx: 00000800   edx: ccca3120
May 15 23:35:36 carbon kernel: esi: 00000b01   edi: 00000b01   ebp: 00000000   esp: c9fbfdb4
May 15 23:35:36 carbon kernel: ds: 0018   es: 0018   ss: 0018
May 15 23:35:36 carbon kernel: Process mount (pid: 315, stackpage=c9fbf000)
May 15 23:35:36 carbon kernel: Stack: 00000000 00000b01 00000200 00000000 00002120 c0130289 00000b01 00000000 
May 15 23:35:36 carbon kernel:        00000200 00000b01 ccca2c00 00000000 00000001 c013047e 00000b01 00000000 
May 15 23:35:36 carbon kernel:        00000200 00000000 d0886232 00000b01 00000000 00000200 00000b01 00000001 
May 15 23:35:36 carbon kernel: Call Trace:    [getblk+49/80] [bread+22/96] [<d0886232>] [<d08854ae>] [<d08860ae>]
May 15 23:35:36 carbon kernel:   [<d086bbf7>] [get_sb_bdev+442/544] [<d0889db0>] [<d0889db0>] [alloc_vfsmnt+118/160] [do_kern_mount+84/256]
May 15 23:35:36 carbon kernel:   [<d0889db0>] [do_add_mount+102/300] [do_mount+293/320] [copy_mount_options+80/160] [sys_mount+124/188] [system_call+51/64]
May 15 23:35:36 carbon kernel: 
May 15 23:35:36 carbon kernel: Code: 0f 0b ce 09 ff 75 1c c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e 


If there's anything I can do to pin this down, let me know.
Please Cc: all replies to me, as I do not read the kernel mailing
lists (too much traffic).


Regards,
Ingo
