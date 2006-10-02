Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965346AbWJBTFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbWJBTFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbWJBTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:05:31 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:32567 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965346AbWJBTF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:05:28 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Please report all left over "DWARF2 unwinder stucks"
X-Message-Flag: Warning: May contain useful information
References: <200610012201.20544.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 12:05:25 -0700
In-Reply-To: <200610012201.20544.ak@suse.de> (Andi Kleen's message of "Sun, 1 Oct 2006 22:01:20 +0200")
Message-ID: <adazmcev8qy.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 19:05:27.0597 (UTC) FILETIME=[B8EFCDD0:01C6E655]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, I just got this with Linus's -git updated as of this morning
(head is 95f3eff6997ae4a6754c1d874ec0a414d97c44d1).  The soft lockup
is a bug in code I was testing but I was only touching drivers/infiniband, 
so it shouldn't make a difference for this.

Let me know if there's any more info you need.

[  971.926760] BUG: soft lockup detected on CPU#0!
[  971.940287]
[  971.940288] Call Trace:
[  971.952076]  [<ffffffff8026018f>] show_trace+0x34/0x47
[  971.967433]  [<ffffffff802601b4>] dump_stack+0x12/0x17
[  971.982793]  [<ffffffff80294a10>] softlockup_tick+0xdb/0xed
[  971.999517]  [<ffffffff8027e49e>] update_process_times+0x42/0x68
[  972.017521]  [<ffffffff802677d0>] smp_local_timer_interrupt+0x23/0x47
[  972.036770]  [<ffffffff80267c7a>] smp_apic_timer_interrupt+0x38/0x3e
[  972.055761]  [<ffffffff80254ce6>] apic_timer_interrupt+0x66/0x70
[  972.073697] DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x70
[  972.092424]
[  972.096886] Leftover inexact backtrace:
[  972.096887]
[  972.112815]  <IRQ>  [<ffffffff802596dc>] _spin_unlock_irqrestore+0x8/0x9
[  972.132905]  [<ffffffff880a628e>] :ib_ipath:ipath_req_notify_cq+0x4b/0x55
[  972.153190]  [<ffffffff88227e02>] :ib_ipoib:ipoib_poll+0x4a0/0x540
[  972.171661]  [<ffffffff8020b4c1>] net_rx_action+0xa4/0x161
[  972.188056]  [<ffffffff8020f953>] __do_softirq+0x55/0xc4
[  972.203933]  [<ffffffff80316df1>] end_msi_irq_wo_maskbit+0x9/0x16
[  972.222146]  [<ffffffff8025523c>] call_softirq+0x1c/0x30
[  972.238023]  [<ffffffff8026116a>] do_softirq+0x2c/0x7e
[  972.253382]  [<ffffffff80261135>] do_IRQ+0x61/0x6a
[  972.267703]  [<ffffffff8025fa18>] default_idle+0x0/0x47
[  972.283321]  [<ffffffff80254631>] ret_from_intr+0x0/0xa
[  972.298938]  <EOI>  [<ffffffff8025fa41>] default_idle+0x29/0x47
[  972.316688]  [<ffffffff802418a4>] cpu_idle+0x50/0x6f
[  972.331525]  [<ffffffff80520682>] start_kernel+0x211/0x216
[  972.347924]  [<ffffffff8052015a>] _sinittext+0x15a/0x15e
