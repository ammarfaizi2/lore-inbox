Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUHOLzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUHOLzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUHOLzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:55:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7109 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266626AbUHOLzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:55:18 -0400
Date: Sun, 15 Aug 2004 13:56:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040815115649.GA26259@elte.hu>
References: <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814072009.GA6535@elte.hu>
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


i've uploaded the -P0 patch:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0

those who had APIC (and USB, under SMP) problems under previous
versions, are the problems still present in -P0?
 
Changes:

 - make redirected softirqs and hardirqs preemptible by default. I
   reviewed a number of softirq users and it appears to be safe. 
   Process-level enable/disable_bh still disables preemption, but the
   handlers themselves run in a preemptible way. This preemptability
   should fix e.g. the IDE latencies. It could also fix some of the 
   /dev/random related latencies.

 - fixed a bug in hardirq redirection - we didnt re-disable interrupts

 - updated the IO-APIC changes - hopefully it's more robust now

	Ingo
