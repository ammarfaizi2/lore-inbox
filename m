Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWE3VYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWE3VYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWE3VYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:24:17 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:39821 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932466AbWE3VYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:24:15 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="1815676923:sNHT1485983554"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 14:24:03 -0700
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org> (Andrew Morton's message of "Tue, 30 May 2006 02:29:25 -0700")
Message-ID: <adawtc34364.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 21:24:05.0273 (UTC) FILETIME=[6105B090:01C6842F]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing problems with MSI-X interrupts on 2.6.17-rc5-mm1.  I'll try
to debug the MSI patches in -mm further in the next day or so, but for
now I'll post the symptoms.

When I load the ib_mthca driver with MSI-X interrupts enabled, I get
the following crash as soon as the first interrupt is generated.

[  329.979089] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
[  329.995487]  [<0000000000000000>]
<8>[  330.012818] PGD 119477067 PUD 119b48067 PMD 0
[  330.027009] Oops: 0010 [1] SMP
[  330.036503] last sysfs file: /class/net/ib2/address
<8>[  330.051084] CPU 0
<8>[  330.057932] Modules linked in: ib_mthca ib_srp ib_cm ib_ipoib ib_sa ib_mad ib_core nfs lockd nfs_acl sunrpc ipv6 thermal fan button processor ac battery dm_mod ide_generic ide_disk evdev usbhid ide_cd cdrom amd74xx psmouse serio_raw e1000 pcspkr generic ohci_hcd ehci_hcd ide_core
<8>[  330.134158] Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm1 #7
<8>[  330.151851] RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
<8>[  330.170116] RSP: 0000:ffffffff805d4f98  EFLAGS: 00010016
<8>[  330.187344] RAX: 0000000000005200 RBX: ffffffff80873eb8 RCX: 0000000000000000
<8>[  330.209448] RDX: ffffffff80873eb8 RSI: ffffffff80863e80 RDI: 0000000000000052
<8>[  330.231552] RBP: ffffffff805d4fb0 R08: 0000000000000001 R09: ffffffff804380f7
<8>[  330.253656] R10: ffff81007adc6000 R11: 0000000000000000 R12: 0000000000000052
<8>[  330.275762] R13: 0000000000090000 R14: 0000000000000000 R15: 0000000000000000
<8>[  330.297867] FS:  00002b9e555966d0(0000) GS:ffffffff8085c000(0000) knlGS:0000000000000000
<8>[  330.322823] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
<8>[  330.340777] CR2: 0000000000000000 CR3: 0000000119bd7000 CR4: 00000000000006e0
<8>[  330.362882] Process idle (pid: 0, threadinfo ffffffff80872000, task ffffffff804baa00)
<8>[  330.387061] Stack: ffffffff8020c693 ffffffff80207c93 0000000000000100 ffffffff80873ee0
<8>[  330.411423]        ffffffff80209b89  <EOI> ff6500230f54e8fa 65c900000020250c 00000010250c8b48
<8>[  330.438222]        f700001fd8e98148 7400000003582444
<8>[  330.454231] Call Trace:
<8>[  330.462870]  <IRQ> [<ffffffff8020c693>] do_IRQ+0x5e/0x6f
<8>[  330.479631]  [<ffffffff80207c93>] default_idle+0x0/0x9b
<8>[  330.496080]  [<ffffffff80209b89>] ret_from_intr+0x0/0xf
<8>[  330.512526]  <EOI>Unable to handle kernel paging request at ffffffff82800000 RIP:
[  332.136320]  [<ffffffff8020ad6e>] show_trace+0x145/0x195
<8>[  332.159591] PGD 203027 PUD 205027 PMD 0
[  332.172226] Oops: 0000 [2] SMP
[  332.181720] last sysfs file: /class/net/ib2/address
<
