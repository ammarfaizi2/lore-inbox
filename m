Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932270AbWFDVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWFDVud (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWFDVuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:50:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41916 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932270AbWFDVua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:50:30 -0400
Date: Sun, 4 Jun 2006 23:49:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
        Andrew Morton <akpm@osdl.org>,
        Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm3] lock validator: early_init_irq_lock_type() build fix
Message-ID: <20060604214954.GA6950@elte.hu>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com> <20060604024937.0fb57258.akpm@osdl.org> <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com> <20060604104121.GA16117@elte.hu> <200606042038.k54KcZFm031888@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606042038.k54KcZFm031888@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> Just for grins, I tried building this, and got this error:

the patch below should fix this.

	Ingo

----
Subject: lock validator: early_init_irq_lock_type() build fix
From: Ingo Molnar <mingo@elte.hu>

fix build bug reported by Valdis Kletnieks: if the lock validator
is disabled in the .config then kernel/irq/handle.c would not build.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/irq/handle.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c
+++ linux/kernel/irq/handle.c
@@ -238,6 +238,8 @@ out:
 	return 1;
 }
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+
 /*
  * lockdep: we want to handle all irq_desc locks as a single lock-type:
  */
@@ -250,3 +252,5 @@ void early_init_irq_lock_type(void)
 	for (i = 0; i < NR_IRQS; i++)
 		spin_lock_init_key(&irq_desc[i].lock, &irq_desc_lock_type);
 }
+
+#endif
