Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWFFIKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWFFIKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFFIKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:10:07 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:20205 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932135AbWFFIKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:10:06 -0400
Date: Tue, 6 Jun 2006 10:09:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm3] lock validator: add local_irq_enable_in_hardirq() to ide-floppy.c
Message-ID: <20060606080932.GB28752@elte.hu>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060606100303.4c9e89da@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060606100303.4c9e89da@werewolf.auna.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5019]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* J.A. Magallón <jamagallon@ono.com> wrote:

> One more, could not find it already reported (if yes, sorry for the 
> noise). It is not in lockdep-combo as 20060606.

indeed i missed that. The patch below should fix it.

------------------
Subject: lock validator: add local_irq_enable_in_hardirq() to ide-floppy.c
From: Ingo Molnar <mingo@elte.hu>

ide-floppy.c enables hardirqs in IRQ context. (build-tested)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ide/ide-floppy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/ide/ide-floppy.c
===================================================================
--- linux.orig/drivers/ide/ide-floppy.c
+++ linux/drivers/ide/ide-floppy.c
@@ -839,7 +839,7 @@ static ide_startstop_t idefloppy_pc_intr
 			"transferred\n", pc->actually_transferred);
 		clear_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 
 		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {
 			/* Error detected */
