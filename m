Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTDNJBM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTDNJBM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:01:12 -0400
Received: from cibs9.sns.it ([192.167.206.29]:52744 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S262882AbTDNJBK (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:01:10 -0400
Date: Mon, 14 Apr 2003 11:12:58 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: reiserFS problem with 2.5.67?
Message-ID: <Pine.LNX.4.43.0304141100490.14771-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
this morning I found on one of my desktops this
in the dmesg:

Pass this trace through ksymoops for reporting
Call Trace: [<c01496c0>]  [<c0118c10>]  [<c0118c10>]  [<c01b6208>]  [<c01b62b0>]
[<c01b64b9>]  [<c01b3fa9>]  [<c01b440e>]  [<c01a2d8f>]  [<c01ba6f7>]
[<c01a4032>]  [<c0149302>]  [<c0147a8d>]  [<c0147b10>]  [<c01090af>]

This error occurred this night, and maybe my syslog is more interesting:

Apr 14 01:00:22 Blackdeath kernel: buffer layer error at fs/buffer.c:127
Apr 14 01:00:22 Blackdeath kernel: Pass this trace through ksymoops for reportin
g
Apr 14 01:00:22 Blackdeath kernel: Call Trace: [<c01496c0>]  [<c0118c10>]  [<c01
18c10>]  [<c01b6208>]  [<c01b62b0>]  [<c01b64b9>]  [<c01b3fa9>]  [<c01b440e>]  [
<c01a2d8f>]  [<c01ba6f7>]  [<c01a4032>]  [<c0149302>]  [<c0147a8d>]  [<c0147b10>
]  [<c01090af>]


so I got:

Call Trace: [<c01496c0>]  [<c0118c10>]  [<c0118c10>]  [<c01b6208>]  [<c01b62b0>]
[<c01b64b9>]  [<c01b3fa9>]  [<c01b440e>]  [<c01a2d8f>]  [<c01ba6f7>]
[<c01a4032>]  [<c0149302>]  [<c0147a8d>]  [<c0147b10>]  [<c01090af>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01496c0 <__wait_on_buffer+e0/f0>
Trace; c0118c10 <autoremove_wake_function+0/50>
Trace; c0118c10 <autoremove_wake_function+0/50>
Trace; c01b6208 <reiserfs_unmap_buffer+68/b0>
Trace; c01b62b0 <unmap_buffers+60/70>
Trace; c01b64b9 <indirect2direct+1f9/2e0>
Trace; c01b3fa9 <reiserfs_cut_from_item+3c9/4f0>
Trace; c01b440e <reiserfs_do_truncate+2de/5b0>
Trace; c01a2d8f <reiserfs_truncate_file+df/260>
Trace; c01ba6f7 <journal_end+27/30>
Trace; c01a4032 <reiserfs_file_release+222/440>
Trace; c0149302 <__fput+d2/e0>
Trace; c0147a8d <filp_close+4d/80>
Trace; c0147b10 <sys_close+50/60>
Trace; c01090af <syscall_call+7/b>


System is a PentiumIII 933 Mhz, 256KB L2, 512 MB RAM 133Mhz,
MB has an i810 chipset (working also as graphic card and sound card),
IDE controller is an 82801AA IDE.
I have two disks running at ATA66, TQB is non enbaled in my kernel.

hda in a Maxtor 32049H2 2MB cache

hdc is a WDC WD200BB-60CVB0 2MB cache

BlackDeath:{root}:/var/adm>hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 38792/16/63, sectors = 39102336, start = 0
BlackDeath:{root}:/var/adm>hdparm -v /dev/hdc

/dev/hdc:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 38792/16/63, sectors = 39102336, start = 0


as you can see hdc is not running in DMA mode.

system is a linux 2.5.67, compiled with gcc 3.2.2 and binutils 2.13.90.0.18.
Kernel has been compiled with optimizzation for Pentium III processor. The
system is running with glibc 2.3.2
When the fault occurred, the desktop was running XFree86 4.3.0, and kde 3.1.1a,
locked with the screensaver kfiresaver3d, which used DRI and glx extensions
on the i810 graphic card. I am using 16MB of RAM for graphic card, running X11
at 1280x1024 at 16bpp (this system is a pain, using normal memory for graphics,
but it is just a user desktop I am actually using to test 2.5.67
on IDE).

I hope this helps

Luigi



