Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULEH3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULEH3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbULEH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:29:14 -0500
Received: from picard.ine.co.th ([203.152.41.3]:52409 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261274AbULEH3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:29:02 -0500
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
References: <1102072834.31282.1450.camel@cpu0>
	 <20041203113704.GD2714@holomorphy.com> <1102225183.3779.15.camel@cpu0>
	 <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102231736.3779.85.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 14:28:56 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hmm, ok my eat mem was useless. Could not get the system to
crash ...

Thank I was thinking and it occured to me that each time I was
experiencing the crashes thgere was heavy file system activity.

So I tried two things:

tar cf /dev/null <large directory 500+MB>

That went ok, than I did:

tar cf archive.tar <large directory 500+MB>

And that gave me:

Unable to handle kernel paging request at 0000000000001170 RIP:
<ffffffff8015df54>{kmem_getpages+132}
PML4 17102c067 PGD 171058067 PMD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: nvidia ipv6 autofs4 sunrpc binfmt_misc dm_mod button
battery ac ohci_hcy
Pid: 3454, comm: tar Tainted: P   2.6.9RU1.1
RIP: 0010:[<ffffffff8015df54>] <ffffffff8015df54>{kmem_getpages+132}
RSP: 0018:000001017100da38  EFLAGS: 00010213
RAX: ffffffff7fffffff RBX: 000001017ffc9680 RCX: 0000000000000000
RDX: 000001000000f500 RSI: 000001000000f580 RDI: 000001000000f840
RBP: 0000010037ffe000 R08: 000001016ac59000 R09: 000001017ffc96c8
R10: 0000000000001000 R11: 0000000000000000 R12: 000001017ffc9680
R13: 000001017ffc96a8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000002a95572b00(0000) GS:ffffffff80512980(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001170 CR3: 0000000037f08000 CR4: 00000000000006e0
Process tar (pid: 3454, threadinfo 000001017100c000, task
000001017fc5a7d0)
Stack: 000001016b3ca088 0000000000001f7d 0000000000000001
ffffffff8015e720
       000001017ffc9708 0000000000000001 0000005000000050
0000000000000000
       0000000000000000 0000000000001000
Call Trace:<ffffffff8015e720>{cache_alloc_refill+656}
<ffffffff8015e416>{kmem_cache_alloc+
       <ffffffff8017ac91>{alloc_buffer_head+17}
<ffffffff8017b307>{create_buffers+39}
       <ffffffff8017b3a4>{create_empty_buffers+20}
<ffffffff8017baa5>{__block_prepare_writ
       <ffffffff801bb8f0>{ext3_get_block+0}
<ffffffff8017be0a>{block_prepare_write+26}
       <ffffffff801b9a25>{ext3_prepare_write+101}
<ffffffff80157e12>{generic_file_buffered
       <ffffffff80191f4e>{inode_update_time+158}
<ffffffff80158686>{generic_file_aio_write
       <ffffffff8015875f>{generic_file_aio_write+127}
<ffffffff801b7f33>{ext3_file_write+3
       <ffffffff80177a7d>{do_sync_write+173}
<ffffffff80186dc9>{may_open+105}
       <ffffffff80136360>{autoremove_wake_function+0}
<ffffffff803803e9>{thread_return+41}
       <ffffffff8019418e>{dnotify_parent+46}
<ffffffff80177b94>{vfs_write+228}
       <ffffffff80177cc3>{sys_write+83}
<ffffffff801105d6>{system_call+126}


Code: 48 8b 91 70 11 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
RIP <ffffffff8015df54>{kmem_getpages+132} RSP <000001017100da38>
CR2: 0000000000001170
 Killed
[rudi@cpu10 /home]$ <1>Unable to handle kernel paging request at
0000000000001170 RIP:
<ffffffff8015ab8a>{free_pages+154}
PML4 179d73067 PGD 0
Oops: 0000 [2] SMP
CPU 1
Modules linked in: nvidia ipv6 autofs4 sunrpc binfmt_misc dm_mod button
battery ac ohci_hcy
Pid: 2078, comm: syslogd Tainted: P   2.6.9RU1.1
RIP: 0010:[<ffffffff8015ab8a>] <ffffffff8015ab8a>{free_pages+154}
RSP: 0018:000001017cdf9dd0  EFLAGS: 00010213
RAX: ffffffff7fffffff RBX: 000001016ac5b010 RCX: 0000000000000000
RDX: 000001007fc3b838 RSI: 0000000000000000 RDI: 000001016ac5b000
RBP: 000001016ac5b010 R08: 000001000000f000 R09: 000001017fd01f48
R10: 000001017fd01f40 R11: ffffffff8031b400 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
FS:  0000002a957a3b00(0000) GS:ffffffff80512980(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000001170 CR3: 0000000037f08000 CR4: 00000000000006e0
Process syslogd (pid: 2078, threadinfo 000001017cdf8000, task
000001017e8757d0)
Stack: ffffffff8018b543 000001017e8cac80 0000000000000002
0000000000000001
       ffffffff8018ba43 0000000000000000 0000000000000000
0000000000000001
       0000000000000000 0000000000000000
Call Trace:<ffffffff8018b543>{poll_freewait+67}
<ffffffff8018ba43>{do_select+1027}
       <ffffffff8018b550>{__pollwait+0}
<ffffffff80199868>{__writeback_single_inode+728}
       <ffffffff8018bde5>{sys_select+885}
<ffffffff801105d6>{system_call+126}


Code: 48 8b 91 70 11 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
RIP <ffffffff8015ab8a>{free_pages+154} RSP <000001017cdf9dd0>
CR2: 0000000000001170



-- 
rudi               
=============================================================
Rudolf Usselmann,  ASICS World Services,  http://www.asics.ws
Your Partner for IP Cores, Design, Verification and Synthesis

