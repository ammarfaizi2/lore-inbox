Return-Path: <linux-kernel-owner+w=401wt.eu-S1161338AbXAHQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbXAHQTG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbXAHQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:19:06 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:30734 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161338AbXAHQTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:19:04 -0500
X-IronPort-AV: i="4.13,159,1167638400"; 
   d="scan'208"; a="455797760:sNHT194173840"
To: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: guest crash on 2.6.20-rc4
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 08 Jan 2007 08:18:57 -0800
Message-ID: <ada4pr1mqz2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jan 2007 16:18:58.0445 (UTC) FILETIME=[B36BABD0:01C73340]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a 64-bit Fedora 6 install as a guest on a host running
2.6.20-rc4 with the kvm-10 userspace release.  The CPU is a Xeon 5160
and I have 6 GB of RAM.  The guest is given 512 MB of memory.  I left
the guest idle overnight, and the makewhatis cron job seems to have
triggered this:

    Unable to handle kernel paging request at ffff81000ba04000 RIP:
     [<ffffffff8025f402>] clear_page+0x16/0x44
    PGD 8063 PUD 9063 PMD 800000000ba001e3 PTE aad8a7d881d984d9
    Oops: 0003 [1] SMP
    last sysfs file: /block/hda/removable
    CPU 0
    Modules linked in: autofs4 hidp nfs lockd fscache nfs_acl rfcomm l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables dm_multipath video sbs i2c_ec i2c_core button battery asus_acpi ac ipv6 parport_pc lp parport floppy pcspkr ne2k_pci 8390 serio_raw ide_cd cdrom dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
    Pid: 4687, comm: makewhatis Not tainted 2.6.18-1.2869.fc6 #1
    RIP: 0010:[<ffffffff8025f402>]  [<ffffffff8025f402>] clear_page+0x16/0x44
    RSP: 0018:ffff810003e85c40  EFLAGS: 00010216
    RAX: 0000000000000000 RBX: ffff8100012e9140 RCX: 000000000000003f
    RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff81000ba04000
    RBP: 0000000000000001 R08: ffff81001fdc4d8e R09: 00000000000021e6
    R10: 0000000000000000 R11: 0000000000000001 R12: ffff8100012e9100
    R13: ffff81000000b500 R14: ffff81000000c400 R15: 0000000000000001
    FS:  00002aaaaaac6db0(0000) GS:ffffffff805e4000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
    CR2: ffff81000ba04000 CR3: 0000000003c05000 CR4: 00000000000006e0
    Process makewhatis (pid: 4687, threadinfo ffff810003e84000, task ffff81001f3a77f0)
    Stack:  ffffffff8020a632 ffff81000000c400 0000004400000000 ffff81000000c400
     000284d000000000 0000000000000001 0000000000000001 00000000000084d0
     ffff81000000c400 00000000000084d0 ffff81000000c400 ffff81001f3a77f0
    Call Trace:
    Inexact backtrace:
     [<ffffffff8020a632>] get_page_from_freelist+0x351/0x3c4
     [<ffffffff8020f00b>] __alloc_pages+0x76/0x2c3
     [<ffffffff8022b9d3>] get_zeroed_page+0x21/0x74
     [<ffffffff8022e5be>] __pud_alloc+0x14/0x90
     [<ffffffff80208091>] copy_page_range+0x122/0x6c1
     [<ffffffff802224de>] dup_fd+0x208/0x2a8
     [<ffffffff8021f5ec>] copy_process+0xd28/0x159d
     [<ffffffff80230fd9>] do_fork+0x69/0x163
     [<ffffffff802623a4>] _spin_lock_irqsave+0x9/0xe
     [<ffffffff8025bcce>] system_call+0x7e/0x83
     [<ffffffff8025bfdb>] ptregscall_common+0x67/0xac
    
    
    Code: 48 89 07 48 89 47 08 48 89 47 10 48 89 47 18 48 89 47 20 48
    RIP  [<ffffffff8025f402>] clear_page+0x16/0x44
     RSP <ffff810003e85c40>
    CR2: ffff81000ba04000

I just let yum update the guest to the 2.6.18-1.2869.fc6 kernel, but
I'm more suspicious of the MMU changes to kvm...

I don't see anything come up in the host logs when this happens.

Let me know if there is other debugging info that would be helpful.

 - R.
