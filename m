Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUJAUv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUJAUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUJAUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:48:34 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:23210 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266488AbUJAUn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:43:59 -0400
Date: Fri, 1 Oct 2004 22:45:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 0/5, 2.6.9-rc3] generic irq subsystem, description
Message-ID: <20041001204533.GA18684@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


this is a new release of the generic irq handling subsystem, against
2.6.9-rc3. This snapshot includes new ppc and ppc64 support written and
tested by Christoph Hellwig.

the core bits were reworked quite significantly. Changes:

 - split up kernel/hardirq.c into individual files in kernel/irq/

 - 80-90% of each converted architecture's irq.c file is now eliminated
   by this patch. The most dramatic one is x64's irq.c - a mere 108
   lines remained. The total effect on the 4 architectures covered so
   far: more than 3000 lines of irq.c code removed while kernel/irq/*.c
   remains around 1000 lines of code.

 - more irq.h, interrupt.h, asm/hardirq.h and linux/hardirq.h
   consolidation from Christoph and me.

 - thorough cleanup of the generic irq code.

 - compile-testing of the following architectures: x86, x64, ppc64, ppc, 
   ia64, s390, s390x. The first four were boot-tested as well.

there are 5 patches that will follow in the next 5 mails:

  generic-hardirqs-core.patch
  generic-hardirqs-x86.patch
  generic-hardirqs-x64.patch
  generic-hardirqs-ppc.patch
  generic-hardirqs-ppc64.patch

note that it is still a goal of the patchset to not break the building
of any non-CONFIG_GENERIC_HARDIRQS platform - 3 such platforms were
compile-tested.

comments welcome,

	Ingo
