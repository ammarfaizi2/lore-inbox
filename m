Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbUC3S7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUC3S7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:59:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11648 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263854AbUC3S7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:59:05 -0500
Date: Tue, 30 Mar 2004 20:54:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched patch] more sync wakeups, 2.6.5-rc3-mm1
Message-ID: <20040330185409.GA4214@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch extends sync wakeups to the process sys_exit() path
too: the chldwait wakeup can be done sync, since we know that the
process is going to exit (and thus deschedule).

the most visible effect of this change is strace's behavior on SMP
systems: it now stays on a single CPU, together with the traced child. 
(previously it would run in parallel to the child, bouncing around
madly.)

compiled & tested.

	Ingo
