Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWBLBdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWBLBdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 20:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWBLBdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 20:33:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750929AbWBLBdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 20:33:46 -0500
Date: Sat, 11 Feb 2006 20:33:29 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: oops in page_to_pfn in 2.6.16rc2-git9
Message-ID: <20060212013328.GA11444@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit this oops whilst trying to mount a corrupted vfat image
over loopback.

(The taint flag was from p8023 -- patch already sent to netdev
 fixing the missing license tag)

		Dave


 Unable to handle kernel paging request at 0000000101730440 RIP:
 <ffffffff80122521>{page_to_pfn+0}
 PGD 30106067 PUD 0
 Oops: 0000 [4] SMP
 last sysfs file: /devices/system/cpu/cpu0/crash_notes
 CPU 3
 Modules linked in: vfat fat p8023 loop radeon drm nfsd exportfs ipv6 autofs4 nfs lockd nfs_acl sunrpc video button battery ac lp parport_pc parport floppy nvram ud[159964.828891] Pid: 0, comm: swapper Tainted: P      2.6.15-1.1907_FC5 #1
 RIP: 0010:[<ffffffff80122521>] <ffffffff80122521>{page_to_pfn+0}
 RSP: 0018:ffff810002697cf0  EFLAGS: 00010006
 RAX: 0000000000001000 RBX: ffff810000562388 RCX: 000000001cdcc000
 RDX: 0000000000000000 RSI: ffff81003d54e068 RDI: 0000000101730440
 RBP: 000000001cdcd000 R08: 0000000000000000 R09: 0000000000011220
 R10: ffff810002023d60 R11: 0000000000000096 R12: ffff8100007160b0
 R13: ffff8100005623d8 R14: 0000000000001000 R15: ffff81003fd74f18
 FS:  0000000000000000(0000) GS:ffff81003fe1cdf0(0000) knlGS:0000000000000000
 CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 CR2: 0000000101730440 CR3: 0000000030198000 CR4: 00000000000006e0
 Process swapper (pid: 0, threadinfo ffff810002692000, task ffff81003fe25100)
 Stack: ffffffff801f78c3 0000000000011220 ffffffff8015f97b ffff810007918000
        0000810037c14000 ffff8100079189a0 0000004e00000087 0000000000000001
        ffff8100101b07b8 ffff81003fd6d6f8
 Call Trace: <IRQ> <ffffffff801f78c3>{blk_rq_map_sg+210}
        <ffffffff8015f97b>{mempool_alloc+66} <ffffffff8800872b>{:scsi_mod:scsi_prep_fn+728}
        <ffffffff801f55cc>{elv_next_request+144} <ffffffff88008144>{:scsi_mod:scsi_request_fn+115}
        <ffffffff801f7eaa>{blk_run_queue+53} <ffffffff88007237>{:scsi_mod:scsi_next_command+46}
        <ffffffff88007367>{:scsi_mod:scsi_end_request+190} <ffffffff88007571>{:scsi_mod:scsi_io_completion+508}
        <ffffffff880438e5>{:libata:ata_scsi_qc_complete+124}
        <ffffffff880304d3>{:sd_mod:sd_rw_intr+589} <ffffffff88007801>{:scsi_mod:scsi_device_unbusy+84}
        <ffffffff801f87c2>{blk_done_softirq+113} <ffffffff80137e0d>{__do_softirq+85}
        <ffffffff8010bec2>{call_softirq+30} <ffffffff8010d248>{do_softirq+44}
        <ffffffff8010d4e7>{do_IRQ+64} <ffffffff80109ab7>{mwait_idle+0}
        <ffffffff8010aece>{ret_from_intr+0} <EOI> <ffffffff80109ab7>{mwait_idle+0}
        <ffffffff8033e242>{thread_return+0} <ffffffff80109aed>{mwait_idle+54}
        <ffffffff80109a94>{cpu_idle+151} <ffffffff80118f8f>{start_secondary+1140}

 Code: 48 8b 07 48 c1 e8 38 48 8b 04 c5 20 bd 52 80 48 2b b8 20 0a

