Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWJPGST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWJPGST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWJPGST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:18:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3293 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030309AbWJPGSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:18:18 -0400
Date: Mon, 16 Oct 2006 08:10:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [build bug] x86_64, -git: Error: unknown pseudo-op: `.cfi_signal_frame'
Message-ID: <20061016061037.GA12020@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


using latest -git i'm getting this build bug on gcc 3.4:

 arch/x86_64/kernel/entry.S: Assembler messages:
 arch/x86_64/kernel/entry.S:157: Error: unknown pseudo-op: `.cfi_signal_frame'
 arch/x86_64/kernel/entry.S:215: Error: unknown pseudo-op: `.cfi_signal_frame'
 arch/x86_64/kernel/entry.S:333: Error: unknown pseudo-op: `.cfi_signal_frame'
 arch/x86_64/kernel/entry.S:548: Error: unknown pseudo-op: `.cfi_signal_frame'

 gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)

using gcc 4.1 it doesnt happen

 gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)

this is caused by the following commit:

 commit adf1423698f00d00b267f7dca8231340ce7d65ef
 Author: Jan Beulich <jbeulich@novell.com>
 Date:   Tue Sep 26 10:52:41 2006 +0200

reverting that patch solves the build problem and the resulting kernel 
builds and boots fine.

	Ingo
