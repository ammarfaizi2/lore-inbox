Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTGRMtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTGRMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:49:20 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:10732 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S271750AbTGRMtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:49:19 -0400
Date: Fri, 18 Jul 2003 07:03:59 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Benjamin Reed <breed@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
Message-ID: <Pine.LNX.4.44.0307180656090.19070-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Cisco Airo card driver calls schedule while atomic in the function
issuecommand in drivers/net/wireless/airo.c line 2388.


Jul 17 15:27:10 localhost kernel: bad: scheduling while atomic!
Jul 17 15:27:10 localhost kernel: Call Trace:
Jul 17 15:27:10 localhost kernel:  [<c0119754>] schedule+0x3c4/0x3d0
Jul 17 15:27:10 localhost kernel:  [<d18cbb51>] sendcommand+0xa1/0xe0 [airo]
Jul 17 15:27:10 localhost kernel:  [<d18cba80>] issuecommand+0x60/0x90 [airo]
Jul 17 15:27:10 localhost kernel:  [<d18cc001>] PC4500_accessrid+0x41/0x80 [airo]
Jul 17 15:27:10 localhost kernel:  [<d18cc0a3>] PC4500_readrid+0x63/0x130 [airo]
Jul 17 15:27:10 localhost kernel:  [<d18c95d9>] readStatsRid+0x29/0x50 [airo]
Jul 17 15:27:10 localhost kernel:  [<d18c9c0a>] airo_get_stats+0x2a/0xe0 [airo]
Jul 17 15:27:10 localhost kernel:  [<c013e194>] check_poison_obj+0x54/0x1d0
Jul 17 15:27:10 localhost kernel:  [<c013e194>] check_poison_obj+0x54/0x1d0
Jul 17 15:27:10 localhost kernel:  [<c013fa94>] kmem_cache_alloc+0x114/0x160
Jul 17 15:27:10 localhost kernel:  [<c01848ce>] proc_alloc_inode+0x1e/0x80
Jul 17 15:27:10 localhost kernel:  [<c01848fd>] proc_alloc_inode+0x4d/0x80
Jul 17 15:27:10 localhost kernel:  [<c016def7>] alloc_inode+0xd7/0x190
Jul 17 15:27:10 localhost kernel:  [<c0184887>] proc_read_inode+0x17/0x40
Jul 17 15:27:10 localhost kernel:  [<c016f941>] wake_up_inode+0x11/0x30
Jul 17 15:27:10 localhost kernel:  [<c01f070a>] vsnprintf+0x21a/0x440
Jul 17 15:27:10 localhost kernel:  [<c0173bd5>] seq_printf+0x45/0x60
Jul 17 15:27:10 localhost kernel:  [<c02846eb>] dev_seq_printf_stats+0xeb/0x100
Jul 17 15:27:10 localhost kernel:  [<c0284726>] dev_seq_show+0x26/0x80
Jul 17 15:27:10 localhost kernel:  [<c0173689>] seq_read+0x1c9/0x300
Jul 17 15:27:10 localhost kernel:  [<c0154bd3>] vfs_read+0xd3/0x140
Jul 17 15:27:10 localhost kernel:  [<c0154e7f>] sys_read+0x3f/0x60
Jul 17 15:27:10 localhost kernel:  [<c01094fb>] syscall_call+0x7/0xb

Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  


