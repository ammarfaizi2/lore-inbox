Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUDTIoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUDTIoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDTIoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:44:16 -0400
Received: from outbound05.telus.net ([199.185.220.224]:22201 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S262279AbUDTIoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:44:13 -0400
Subject: 2.6 oops
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082450723.3455.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 02:45:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I just built 2.6.6-rc1-bk4 "Zonked Quokka".  Unfortunately on boot
it gave me:

EIP is at internal_add_timer+0x34/0xa4
eax: f8c08134   ebx: f77d801c   ecx: fffc9e5e   edx: c0372380
esi: c0371f00   edi: c0371f00   ebp: 00000046   esp: c032ded0
ds: 007b   es: 007b   ss: 0068
Process swapper(pid: 0, threadinfo=c032c000 task=c02bda40)
Stack: c0371f00 f77d801c c011f2bb c0371f00 f77d801c 00000001 f77d9fd0
f77d9fa4
       f77d9e6c f77d9fd0 f8a085d3 f77d801c fffc9e8f 00000002 c18f6480
f77d9fd0
       00000296 f77d9e6c 00000001 00000000 c032dfa0 f8a07c98 f77d9fa4
00000000
Call Trace:
 [<c011f2bb>] __mod_timer+0xda/0x17d
 [<f8a085d3>] dma_trm_tasklet+0x84/0x172 [ohci1394]
 [<f8a085d3>] ohci_irq_handler+0x4b1/0x80e [ohci1394]
 [<c0105fbe>] handle_IRQ_event+0x3a/0x64
 [<c010633d>] do_IRQ+0xa6/0x162
 [<c010486c>] common_interrupt+0x18/0x20
 [<c027007b>] xfrm_policy_bysel+0x70/0xa3
 [<c0102041>] default_idle+0x23/0x26
 [<c010209f>] cpu_idle+0x2c/0x35
 [<c032e6f2>] start_kernel+0x16b/0x188
 [<c032e44b>] unknown_bootoption+0x0/0x110
 
Code: 89 18 89 43 04 8b 1c 24 8b 74 24 04 83 c4 08 c3 81 fa ff 3f
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I was not able to trap/recover anything else except from
/var/log/messages which showed that it was mounting a drive (sda1) when
it stalled:

Apr 20 00:54:39 localhost gdm[3953]: gdm_slave_xioerror_handler: Fatal X
error - Restarting :0
Apr 20 00:54:41 localhost kernel: reiserfs: using ordered data mode
Apr 20 00:54:41 localhost kernel: Reiserfs journal params: device sda1,
size 8192, journal first block 18, max trans len 1024, max batch 900,
max commit age 30, max trans age 30
Apr 20 00:54:41 localhost kernel: reiserfs: checking transaction log
(sda1) for (sda1)
Apr 20 00:54:41 localhost kernel: Using r5 hash to sort names
Apr 20 00:54:41 localhost kernel: found reiserfs format "3.6" with
standard journal
Apr 20 01:05:46 localhost syslogd 1.4.1: restart.
Apr 20 01:05:46 localhost syslog: syslogd startup succeeded
Apr 20 01:05:46 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.
...
(Please ignore the Fatal X error as I normally <ahem> taint the kernel
with Nvidia binaries)... (there are no binaries tainting the kernel so
far though, as its tough to install drivers after an oops)...
I am running Fedora Core 1 (updated with yum, the addition of /udev
(version 023) and hotplug-2004_03_11).  The next most recent kernel I
built (which works fine) is 2.6.6-rc1-bk1.
TIA, please contact me directly for more information as I'm not on the
list (or just reply to the list for more info, and I will try to get
back to you as soon as I can).  Thanks,

Bob

