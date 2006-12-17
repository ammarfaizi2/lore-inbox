Return-Path: <linux-kernel-owner+w=401wt.eu-S1752317AbWLQJno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWLQJno (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 04:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbWLQJno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 04:43:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59025 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbWLQJnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 04:43:43 -0500
Date: Sun, 17 Dec 2006 10:41:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061217094143.GA15372@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu> <20061217092828.GA14181@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217092828.GA14181@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


it would also be nice to have more information than this:

 unreferenced object 0xf76f5af8 (size 512):
  [<c0191f23>] memleak_alloc
  [<c018eeaa>] kmem_cache_zalloc
  [<c03277a7>] probe_hwif
  [<c032870c>] probe_hwif_init_with_fixup
  [<c032aea1>] ide_setup_pci_device
  [<c0312564>] amd74xx_probe
  [<c069c4b4>] ide_scan_pcidev
  [<c069c505>] ide_scan_pcibus
  [<c069bdca>] ide_init
  [<c0100532>] init
  [<c0105da3>] kernel_thread_helper
  [<ffffffff>]

it would be nice to record 1) the jiffies value at the time of 
allocation, 2) the PID and the comm of the task that did the allocation. 
The jiffies timestamp would be useful to see the age of the allocation, 
and the PID/comm is useful for context.

plus it would be nice to have a kernel thread (running at nice 19) that 
scans everything every 10 minutes or so, which would output some 
overview 'delta' information into the syslog, along the lines of:

	kmemleak: 2 new object leaks detected, see /debug/memleak for details

that way users could see (and report) new leaks in the dmesg, without 
having to do anything. I'd like to enable kmemleak in the -rt yum 
kernels, so it all has to be as automatic and as informative as 
possible.

	Ingo
