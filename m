Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUBXUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUBXUR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:17:26 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:16296 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S262436AbUBXURS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:17:18 -0500
Subject: [oops] XFS? 2.6.3 build with gcc 3.3.3 running on Opteron
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077653836.7783.55.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 15:17:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this oops, looks like it might be XFS related.  But I'm no good
at decoding these things.

As the subject says this is a plain vanilla 2.6.3 kernel built with the
just released gcc 3.3.3.  All file systems are XFS.

Thanks.


Bad page state at prep_new_page
flags:0x10000000000000 mapping:0000000000000000 mapped:1 count:0
Backtrace:

Call Trace:<ffffffff8013e6fb>{bad_page+75} <ffffffff8013eabf>{prep_new_page+47}
       <ffffffff8013f08c>{buffered_rmqueue+300} <ffffffff8013f141>{__alloc_pages+161}
       <ffffffff80149c92>{do_wp_page+306} <ffffffff801bb360>{xfs_dir2_put_dirent64_direct+0}
       <ffffffff8014af8d>{handle_mm_fault+333} <ffffffff8011d63d>{do_page_fault+413}
       <ffffffff80131a68>{do_sigaction+472} <ffffffff8010f511>{error_exit+0}

Trying to fix it up, but a reboot is needed
Unable to handle kernel paging request at 0000004c564c4850 RIP:
<ffffffff8014f75f>{page_remove_rmap+207}PML4 33c37067 PGD 0
Oops: 0000 [1]
CPU 1
Pid: 7748, comm: spamd Not tainted
RIP: 0010:[page_remove_rmap+207/384] <ffffffff8014f75f>{page_remove_rmap+207}
RSP: 0018:000001004d47ddc8  EFLAGS: 00010206
RAX: 0000000000000007 RBX: 0000010001f57ad0 RCX: 0000004c564c4850
RDX: 0000000000000006 RSI: 000001003bf06458 RDI: 00000100594a2728
RBP: 000000000008b000 R08: 0000004c564c4850 R09: 00000100594a2728
R10: 0000000000000002 R11: 0000000000000002 R12: 0000010001f57ad0
R13: 0000000000200000 R14: 00000100038231c0 R15: 0000000031189067
FS:  0000002a95f99a40(0000) GS:ffffffff80418580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000004c564c4850 CR3: 000000000387f000 CR4: 00000000000006a0
Process spamd (pid: 7748, stackpage=10077e23d70)
Stack: 000000000008b000 0000010001f57ad0 000001003bf06458 ffffffff80148975
       00000100437235d8 0000000001c00000 000001002e817070 00000000022a1000
       00000100038231c0 fffffffffe36cfff
Call Trace:<ffffffff80148975>{zap_pte_range+421} <ffffffff80148ae6>{zap_pmd_range+198}
       <ffffffff80148b50>{unmap_page_range+80} <ffffffff80148cb1>{unmap_vmas+305}
       <ffffffff8014d772>{exit_mmap+290} <ffffffff80123548>{mmput+88}
       <ffffffff801278cc>{do_exit+476} <ffffffff80127bdb>{do_group_exit+235}
       <ffffffff8010eba4>{system_call+124}

Code: 4c 8b 01 49 83 e0 f8 74 04 41 0f 18 08 8b 01 83 e0 07 83 f8
RIP <ffffffff8014f75f>{page_remove_rmap+207} RSP <000001004d47ddc8>
CR2: 0000004c564c4850
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff801235e6>{mm_release+86}PML4 33c37067 PGD 2e817067 PMD 0
Oops: 0000 [2]
CPU 1
Pid: 7748, comm: spamd Not tainted
RIP: 0010:[mm_release+86/224] <ffffffff801235e6>{mm_release+86}
RSP: 0018:000001004d47dbd8  EFLAGS: 00010202
RAX: 0000010077e22d70 RBX: 0000010077e22d70 RCX: 0000000007fffffc
RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000002a95f99ad0
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff80444740
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001004d47dd18
FS:  0000002a95f99a40(0000) GS:ffffffff80418580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 000000000387f000 CR4: 00000000000006a0
Process spamd (pid: 7748, stackpage=10077e23d70)
Stack: 0000000000000001 0000000000000000 0000010077e22d70 0000004c564c4850
       0000000000000009 ffffffff801277f9 0000000000000216 0000000000000001
       000000008010f187 0000004c564c4850
Call Trace:<ffffffff801277f9>{do_exit+265} <ffffffff8011d867>{do_page_fault+967}
       <ffffffff8013f530>{__pagevec_free+32} <ffffffff8010f511>{error_exit+0}
       <ffffffff8014f75f>{page_remove_rmap+207} <ffffffff80148975>{zap_pte_range+421}
       <ffffffff80148ae6>{zap_pmd_range+198} <ffffffff80148b50>{unmap_page_range+80}
       <ffffffff80148cb1>{unmap_vmas+305} <ffffffff8014d772>{exit_mmap+290}
       <ffffffff80123548>{mmput+88} <ffffffff801278cc>{do_exit+476}
       <ffffffff80127bdb>{do_group_exit+235} <ffffffff8010eba4>{system_call+124}


Code: 41 8b 45 28 ff c8 7e 63 48 c7 83 88 02 00 00 00 00 00 00 65
RIP <ffffffff801235e6>{mm_release+86} RSP <000001004d47dbd8>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:


-- 
Chris

