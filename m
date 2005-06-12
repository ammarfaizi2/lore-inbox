Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFMC3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFMC3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFMC3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:29:54 -0400
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:24036 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261323AbVFMC3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:29:48 -0400
X-IronPort-AV: i="3.93,192,1115006400"; 
   d="txt'?scan'208"; a="368571411:sNHT22222482"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: Andi Kleen <ak@muc.de>
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Sun, 12 Jun 2005 15:29:50 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506071836.12076.martin@cs.uga.edu> <m1wtp1ch07.fsf@muc.de>
In-Reply-To: <m1wtp1ch07.fsf@muc.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u0IrCIwX5V1dao1"
Message-Id: <200506121529.50259.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_u0IrCIwX5V1dao1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hardware memhole mapping never seems to work, or causes lockups right away.  I 
need to test it further though.

I have discovered that with the following features enabled:

1.  Software memhole mapping
2.  Continuous,

linux sees the entire 4GB of memory.  However, when things start getting 
requested from the upper half, there are Oopses generated.  Attached are two 
Oopses that occurred under the test scenario described.  

These results were achieved with a tainted kernel, but does that matter since 
we've already determined it happens untainted?  I need to start X in order to 
launch big memory apps.

I suppose I could write a program to consume/probe the upper memory half.  
Anyone know of a good/quicky way to do that?  

I'm really not sure what to do or where to go from here.  

Cheers,
Jacob Martin


--Boundary-00=_u0IrCIwX5V1dao1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="OOPS.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="OOPS.txt"

Jun 12 20:51:13 optimator Unable to handle kernel paging request at 0000000000001cb0 RIP: 
Jun 12 20:51:13 optimator <ffffffff8015faa7>{cache_grow+647}
Jun 12 20:51:13 optimator PGD 109f6f067 PUD 10c943067 PMD 0 
Jun 12 20:51:13 optimator Oops: 0000 [1] SMP 
Jun 12 20:51:13 optimator CPU 0 
Jun 12 20:51:13 optimator Modules linked in: nvidia smsc47b397 i2c_sensor i2c_isa i2c_core
Jun 12 20:51:13 optimator Pid: 10608, comm: as Tainted: P      2.6.12-rc6
Jun 12 20:51:13 optimator RIP: 0010:[<ffffffff8015faa7>] <ffffffff8015faa7>{cache_grow+647}
Jun 12 20:51:13 optimator RSP: 0018:ffff81010c76da68  EFLAGS: 00010093
Jun 12 20:51:13 optimator RAX: ffffffff7fffffff RBX: 0000000000000038 RCX: 0000000000000000
Jun 12 20:51:13 optimator RDX: ffff810107de9000 RSI: 0000000000000001 RDI: 0000000000000001
Jun 12 20:51:13 optimator RBP: ffff810107de9000 R08: ffff81000000f000 R09: 0000000000000000
Jun 12 20:51:13 optimator R10: 0000000000080563 R11: 0000000000000000 R12: ffff81017ffd4cc0
Jun 12 20:51:13 optimator R13: ffff810107de9000 R14: 0000000000000000 R15: 00000000ffffffff
Jun 12 20:51:13 optimator FS:  00002aaaab18bdc0(0000) GS:ffffffff805ba440(0000) knlGS:0000000000000000
Jun 12 20:51:13 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 12 20:51:13 optimator CR2: 0000000000001cb0 CR3: 0000000115f1e000 CR4: 00000000000006e0
Jun 12 20:51:13 optimator Process as (pid: 10608, threadinfo ffff81010c76c000, task ffff81010c9b61b0)
Jun 12 20:51:13 optimator Stack: ffff81017ffd4d38 0000000000000003 000000202c235fa8 000000000000001b 
Jun 12 20:51:13 optimator ffff81017ffcc200 ffff81017ffd4cc0 ffff81017ffd4cd8 ffff81017ffc9800 
Jun 12 20:51:13 optimator ffff81017ffd4d38 ffffffff8015fd85 
Jun 12 20:51:13 optimator Call Trace:<ffffffff8015fd85>{cache_alloc_refill+437} <ffffffff8015f816>{kmem_cache_alloc+54}
Jun 12 20:51:13 optimator <ffffffff8024d5d3>{radix_tree_node_alloc+19} <ffffffff8024d7f3>{radix_tree_insert+307}
Jun 12 20:51:13 optimator <ffffffff80157af6>{add_to_page_cache+86} <ffffffff80159994>{generic_file_buffered_write+420}
Jun 12 20:51:13 optimator <ffffffff801c075d>{__ext3_journal_stop+45} <ffffffff8019da61>{__mark_inode_dirty+241}
Jun 12 20:51:13 optimator <ffffffff80194d52>{inode_update_time+178} <ffffffff8015a388>{__generic_file_aio_write_nolock+968}
Jun 12 20:51:13 optimator <ffffffff80158a60>{file_read_actor+0} <ffffffff8015a43f>{generic_file_aio_write+127}
Jun 12 20:51:13 optimator <ffffffff801b65a3>{ext3_file_write+35} <ffffffff8017ac8d>{do_sync_write+173}
Jun 12 20:51:13 optimator <ffffffff80120fc7>{do_page_fault+1159} <ffffffff8014a9c0>{autoremove_wake_function+0}
Jun 12 20:51:13 optimator <ffffffff8017ad84>{vfs_write+196} <ffffffff8017aee3>{sys_write+83}
Jun 12 20:51:13 optimator <ffffffff8010ea86>{system_call+126} 
Jun 12 20:51:13 optimator 
Jun 12 20:51:13 optimator Code: 48 8b 91 b0 1c 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00 
Jun 12 20:51:13 optimator RIP <ffffffff8015faa7>{cache_grow+647} RSP <ffff81010c76da68>
Jun 12 20:51:13 optimator CR2: 0000000000001cb0
Jun 12 20:51:13 optimator <1>Unable to handle kernel paging request at 0000000000001cb0 RIP: 
Jun 12 20:51:13 optimator <ffffffff801666fa>{pte_alloc_map+170}
Jun 12 20:51:13 optimator PGD 127efb067 PUD 10ee9b067 PMD 0 
Jun 12 20:51:13 optimator Oops: 0000 [2] SMP 
Jun 12 20:51:13 optimator CPU 1 
Jun 12 20:51:13 optimator Modules linked in: nvidia smsc47b397 i2c_sensor i2c_isa i2c_core
Jun 12 20:51:13 optimator Pid: 10618, comm: cc1plus Tainted: P      2.6.12-rc6
Jun 12 20:51:13 optimator RIP: 0010:[<ffffffff801666fa>] <ffffffff801666fa>{pte_alloc_map+170}
Jun 12 20:51:13 optimator RSP: 0000:ffff81010947ddb8  EFLAGS: 00010293
Jun 12 20:51:13 optimator RAX: ffffffff7fffffff RBX: 00002aaaabc00000 RCX: 0000000000000018
Jun 12 20:51:13 optimator RDX: ffff810107e63000 RSI: 0000000000000000 RDI: ffff81000000f440
Jun 12 20:51:13 optimator RBP: ffff810115479af0 R08: ffff81000000f000 R09: 0000000000000000
Jun 12 20:51:13 optimator R10: 00000000000810bd R11: 0000000000000000 R12: 0000000000000000
Jun 12 20:51:13 optimator R13: ffff81012fdb6dc0 R14: ffff81012fdb6e28 R15: ffff810115479af0
Jun 12 20:51:13 optimator FS:  00002aaaaaff36e0(0000) GS:ffffffff805ba4c0(0000) knlGS:0000000000000000
Jun 12 20:51:13 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 12 20:51:13 optimator CR2: 0000000000001cb0 CR3: 000000010fa09000 CR4: 00000000000006e0
Jun 12 20:51:13 optimator Process cc1plus (pid: 10618, threadinfo ffff81010947c000, task ffff81017f20ea00)
Jun 12 20:51:13 optimator Stack: ffff81010fa092a8 00002aaaabc00000 ffff810136eb64e8 ffff81012fdb6dc0 
Jun 12 20:51:13 optimator 0000000000000001 ffffffff80169285 0000000000000000 ffff81012fdb6e28 
Jun 12 20:51:13 optimator 00002aaaabc0d000 00002aaaaaff3000 
Jun 12 20:51:13 optimator Call Trace:<ffffffff80169285>{handle_mm_fault+293} <ffffffff80120f79>{do_page_fault+1081}
Jun 12 20:51:13 optimator <ffffffff8024e6d1>{__up_write+49} <ffffffff8010f485>{error_exit+0}
Jun 12 20:51:13 optimator 
Jun 12 20:51:13 optimator 
Jun 12 20:51:13 optimator Code: 48 8b 8e b0 1c 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66 
Jun 12 20:51:13 optimator RIP <ffffffff801666fa>{pte_alloc_map+170} RSP <ffff81010947ddb8>
Jun 12 20:51:13 optimator CR2: 0000000000001cb0

--Boundary-00=_u0IrCIwX5V1dao1--
