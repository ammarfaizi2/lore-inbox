Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVAXCk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVAXCk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVAXCk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:40:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:16048 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261415AbVAXCky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:40:54 -0500
Subject: Problem with cpu_rest() change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 13:40:42 +1100
Message-Id: <1106534442.5272.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo !

Could you explain me precisely what is the race you are fixing by adding
local_irq_disable() to rest_init() ?

This patch is causing lockups on boot on various ppc machines. I think
i've found at least one possible reason for that in the ppc cpu_idle()
code, which may not re-enable interrupts in some cases when
need_resched() is not set, assuming they were enabled on entry. However,
I'm wondering precisely what exact race you are trying to fix as my fix
would cause IRQs to be re-enabled before the call to schedule() when
need_resched() is not set, which goes against the comment you added to
rest_init() about letting them be re-enable by schedule() itself...

Ben.


