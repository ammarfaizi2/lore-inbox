Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTFDXJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTFDXJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:09:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3556 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263875AbTFDXJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:09:50 -0400
Date: Wed, 4 Jun 2003 16:23:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 latest: breaks gnome
Message-Id: <20030604162313.30f8a44c.shemminger@osdl.org>
In-Reply-To: <3EDE7398.70005@tmsusa.com>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	<3EDE7398.70005@tmsusa.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a repeat of the gnome login hang with sysrq back trace of interesting processes:

gnome-session S 00000000 2688832   791    735   826               (NOTLB)
Call Trace:
 [<c013fe19>] __get_free_pages+0x35/0x40
 [<c012ab95>] schedule_timeout+0xb9/0xbc
 [<c023c282>] sock_poll+0x26/0x2a
 [<c0170a97>] do_pollfd+0x57/0x98
 [<c0170b7d>] do_poll+0xa5/0xc4
 [<c0170cfc>] sys_poll+0x160/0x237
 [<c015bb97>] sys_read+0x3f/0x5e
 [<c01700fc>] __pollwait+0x0/0xaa
 [<c010b22d>] sysenter_past_esp+0x52/0x71

ssh-agent     S 00000001 5441264   826    791                     (NOTLB)
Call Trace:
 [<c012ab95>] schedule_timeout+0xb9/0xbc
 [<c0170134>] __pollwait+0x38/0xaa
 [<c0299f3f>] unix_poll+0x2b/0x9c
 [<c023c282>] sock_poll+0x26/0x2a
 [<c0170413>] do_select+0x18b/0x2e4
 [<c017058a>] select_bits_alloc+0x1e/0x22
 [<c01700fc>] __pollwait+0x0/0xaa
 [<c017083e>] sys_select+0x2a6/0x4a8
 [<c010b22d>] sysenter_past_esp+0x52/0x71

gconfd-2      S 00000000 4274957916   829      1           831   720 (NOTLB)
Call Trace:
 [<c0170134>] __pollwait+0x38/0xaa
 [<c012ab46>] schedule_timeout+0x6a/0xbc
 [<c012aad0>] process_timeout+0x0/0xc
 [<c0170b7d>] do_poll+0xa5/0xc4
 [<c0170cfc>] sys_poll+0x160/0x237
 [<c0111b1f>] do_gettimeofday+0x1f/0x9c
 [<c01700fc>] __pollwait+0x0/0xaa
 [<c010b22d>] sysenter_past_esp+0x52/0x71

bonobo-activa S 00000001 4272089640   831      1           833   829 (NOTLB)
Call Trace:
 [<c013fe19>] __get_free_pages+0x35/0x40
 [<c0170134>] __pollwait+0x38/0xaa
 [<c012ab95>] schedule_timeout+0xb9/0xbc
 [<c0169b43>] pipe_poll+0x33/0x7a
 [<c0170a97>] do_pollfd+0x57/0x98
 [<c0170b7d>] do_poll+0xa5/0xc4
 [<c0170cfc>] sys_poll+0x160/0x237
 [<c016f0d8>] sys_fcntl64+0x50/0x8c
 [<c01700fc>] __pollwait+0x0/0xaa
 [<c010b22d>] sysenter_past_esp+0x52/0x71

metacity      S 00000001 4274282128   833      1           836   831 (NOTLB)
Call Trace:
 [<f88387e9>] journal_dirty_metadata+0x1c3/0x270 [jbd]
 [<c012ab95>] schedule_timeout+0xb9/0xbc
 [<c0142483>] check_poison_obj+0x3b/0x198
 [<c02995d1>] unix_stream_data_wait+0xed/0x148
 [<c011f5b2>] autoremove_wake_function+0x0/0x4c
 [<c023f62f>] alloc_skb+0x47/0xe0
 [<c011f5b2>] autoremove_wake_function+0x0/0x4c
 [<c023ecad>] sock_alloc_send_pskb+0xd5/0x1fe
 [<c0299bbc>] unix_stream_recvmsg+0x590/0x632
 [<c023ee04>] sock_alloc_send_skb+0x2e/0x32
 [<c013d095>] filemap_nopage+0x1e5/0x2ce
 [<c023bbae>] sock_aio_read+0xc0/0xc8
 [<c015b842>] do_sync_read+0x8a/0xb6
 [<c015b957>] vfs_read+0xe9/0x11a
 [<c015bb97>] sys_read+0x3f/0x5e
 [<c010b22d>] sysenter_past_esp+0x52/0x71

gnome-setting S 00000001 4278248440   836      1                 833 (NOTLB)
Call Trace:
 [<c0271783>] tcp_v4_connect+0x42f/0x68c
 [<c012ab95>] schedule_timeout+0xb9/0xbc
 [<c028452b>] inet_wait_for_connect+0x105/0x256
 [<c011f5b2>] autoremove_wake_function+0x0/0x4c
 [<c011f5b2>] autoremove_wake_function+0x0/0x4c
 [<c0284866>] inet_stream_connect+0x1ea/0x30a
 [<c023b505>] move_addr_to_kernel+0x6b/0x70
 [<c023cd62>] sys_connect+0x78/0x9a
 [<c011a89e>] do_page_fault+0x15e/0x4ab
 [<c023c944>] sys_socket+0x3a/0x56
 [<c023d846>] sys_socketcall+0xb2/0x262
 [<c014efc2>] sys_munmap+0x58/0x78
 [<c010b22d>] sysenter_past_esp+0x52/0x71
