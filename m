Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267840AbTBEH1G>; Wed, 5 Feb 2003 02:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267841AbTBEH1G>; Wed, 5 Feb 2003 02:27:06 -0500
Received: from [66.111.45.40] ([66.111.45.40]:50842 "EHLO saltbox.argot.org")
	by vger.kernel.org with ESMTP id <S267840AbTBEH1F>;
	Wed, 5 Feb 2003 02:27:05 -0500
Date: Tue, 4 Feb 2003 23:36:37 -0800
From: Joshua Kwan <joshk@saltbox.argot.org>
To: jkmaline@cc.hut.fi
Cc: linux-kernel@vger.kernel.org
Subject: 2.5 kernel + hostap_cs + X11 = scheduling while atomic
Message-ID: <20030205073637.GA10725@saltbox.argot.org>
Reply-To: joshk@triplehelix.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jouni and LKML folks,

In kernel 2.5.59 I built the hostap modules as stated in the Makefile.
(make -C /usr/src/linux SUBDIRS=$PWD/driver/modules modules, etc.)

However, a combination of running said kernel, hostap_cs, and X11 produces
this nasty infinite string of errors:

bad: scheduling while atomic!
Call Trace:
 [<c011bafd>] do_schedule+0x33a/0x33f
 [<c01264a1>] schedule_timeout+0x5f/0xb3
 [<c0175a7f>] proc_alloc_inode+0x4c/0x75
 [<c0126439>] process_timeout+0x0/0x9
 [<d294853d>] hfa384x_cmd+0x3eb/0x2d6b7eae [hostap_cs]
 [<c016474d>] get_new_inode_fast+0x48/0xf0
 [<c011bb52>] default_wake_function+0x0/0x3e
 [<c011bb52>] default_wake_function+0x0/0x3e
 [<c0137b46>] get_page_cache_size+0x12/0x1d
 [<d2948a30>] hfa384x_get_rid+0x36/0x2d6b7606 [hostap_cs]
 [<d29388b5>] hostap_get_wireless_stats+0xa6/0x2d6c77f1 [hostap]
 [<c0168f45>] seq_printf+0x45/0x56
 [<c02bd9b6>] wireless_seq_show+0xd6/0xf7
 [<c0141dd5>] do_mmap_pgoff+0x40e/0x6dc
 [<c0168a56>] seq_read+0x1c9/0x2ee
 [<c014d20f>] vfs_read+0xbc/0x127
 [<c014d496>] sys_read+0x3e/0x55
 [<c01093cb>] syscall_call+0x7/0xb

This will repeat itself over and over again in the same order, same everything.
The second I kill X the messages stop completely. I use the radeon accelerated X
server using an Intel AGP bridge (kernel supported.)

Any ideas? It seems like it would be a problem in hostap_cs's main loop. Or it
could be a kernel problem, which is why I'm forwarding it to LKML :) Why would
it only happen when X11 is active though?

Thanks for any insight anyone might have on this issue. Lately, I left my machine
on and went to go eat lunch. When i came back, /var/log/syslog was overflowing with
these errors and had filled up /var completely. Had to purge them all manually :)

Regards

Josh
