Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJREgM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 00:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTJREgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 00:36:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:20101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261336AbTJREgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 00:36:09 -0400
Date: Fri, 17 Oct 2003 21:34:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: VEROK Istvan <vi@inf.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when copying from IDE CD
Message-Id: <20031017213448.3f013ca2.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.00.10310180608050.11842-100000@kempelen.iit.bme.hu>
References: <Pine.GSO.4.00.10310180608050.11842-100000@kempelen.iit.bme.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Oct 2003 06:16:46 +0200 (MET DST) VEROK Istvan <vi@inf.bme.hu> wrote:

| I'm having reproducible oopses when copying from an IDE CD drive.  I saw
| this first with 2.6.0-test5 (I didn't run 2.6.x much before then, so I'm
| not saying that's when it appeared), and now with -test7 and -test8.
| The following screen dump was taken down by hand from -test7:
|  
| -------------------------------
| [<c0130f54>] update_process_times+0x44/0x50
| [<c0130dc6>] update_wall_time+0x16/0x40
| [<c01314d0>] do_timer+0xe0/0xf0
| [<c011332b>] timer_interrupt+0x17f/0x3e0
| [<c010ca6b>] handle_IRQ_event+0x3b/0x70
| [<c010d124>] do_IRQ_0x1c4/0x3b0
| [<c010af88>] common_interrupt+0x18/0x20
| [<c0130f54>] update_process_times+0x44/0x50
| [<c02d0889>] ide_intr+0x2d9/0x610
| [<c011332b>] timer_interrupt+0x17b/0x3e0
| [<c02e1440>] cdrom_read_intr+0x0/0x3e0
| [<c010ca6b>] handle_IRQ_event+0x3b/0x70
| [<c010d0a4>] do_IRQ+0x144/0x3b0
| [<c0105000>] _stext+0x0/0x100
| [<c010af88>] common_interrupt+0x18/0x20
| [<c0105000>] _stext+0x0/0x100
| [<c0107426>] default_idle+0x26/0x40
| [<c01074b4>] cpu_idle+0x34/0x40
| [<c048a836>] start_kernel+0x1c6/0x230
| [<c048a520>] unknown_bootoption+0x0/0x110
|  
| Code: f3 66 6d 5f 5d c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55
|  <0>Kernel panic: Fatal exception in interrupt
| In interrupt handler - not syncing
| -------------------------------
|  
| With -test8, the only difference is that the update_process_times line
| is missing from the middle, and
| mark_offset_tsc+0x38d/0x550
| is visible at the top instead.
|  
| Could this be the sign of malfunctioning hardware?
| 
| $ dmesg | grep CD
| hdd: FX4830T, ATAPI CD/DVD-ROM drive
| hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
| Uniform CD-ROM driver Revision: 3.12
| $ gcc -v
| gcc version 3.3.2 20030908 (Debian prerelease)
|  
| I haven't got any experience in reporting kernel panics, so please tell
| me what more info to include to make this a meaningful report.
|  
| TIA,
| Istvan
| 
| 
| PS: I'm not subscribed, please CC me.

Can you supply any more of the oops message?  It's missing a good bit
before the call trace that you listed.
Maybe check the kernel message file for the rest of it?

Thanks,
--
~Randy
