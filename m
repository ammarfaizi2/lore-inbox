Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbUKHJed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbUKHJed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKHJdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:33:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:34989 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261800AbUKHJRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:17:39 -0500
Date: Mon, 8 Nov 2004 11:19:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
Message-ID: <20041108101938.GA13628@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <200411081015.47750.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081015.47750.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> RT-V0.7.19-dmesg_after_boot_rl3.log is a freshly booted dmesg output
> after logging on via ssh. RT-V0.7.19-proc_acpi_TAB.log is captured via
> netconsole. This log started after logging in locally, then typing in
> "cat /proc/acpi", then first <TAB> gives an additional "/", 2nd <TAB>
> gives no visual effect, 3rd <TAB> produces whats in the log.

could you try this with vanilla -mm3 too? The crash seems to be generic:

 [<c011ae89>] do_page_fault+0x3b7/0x64e (220)
 [<c0107c63>] error_code+0x2b/0x30 (100)
 [<c01991e4>] proc_lookup+0x81/0xc9 (52)
 [<c01762e8>] real_lookup+0xb2/0xd6 (36)
 [<c017660f>] do_lookup+0x82/0x8d (32)
 [<c0176d8f>] link_path_walk+0x775/0x1071 (108)
 [<c01779b2>] path_lookup+0xa5/0x1b0 (32)
 [<c0177c5f>] __user_walk+0x30/0x4d (32)
 [<c01720eb>] vfs_stat+0x1f/0x5a (92)
 [<c0172784>] sys_stat64+0x1e/0x3d (100)
 [<c0107191>] sysenter_past_esp+0x52/0x71 (-4028)

while -RT made it a bit more murky by emitting an assert while the
kernel tried to crash in a critical section, it doesnt seem to be a 
genuine -RT related crash.

(if it doesnt trigger in vanilla -mm3 then could you try -RT with
PREEMPT_REALTIME disabled?)

	Ingo
