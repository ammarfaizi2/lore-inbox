Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVATJaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVATJaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVATJ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:29:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:54753 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262092AbVATJ2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:28:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16879.31182.438866.298939@alkaid.it.uu.se>
Date: Thu, 20 Jan 2005 10:28:46 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-r1 freezes dual 2.5 GHz PowerMac G5
In-Reply-To: <a06100502be077de5e936@[129.98.90.227]>
References: <a06100502be077de5e936@[129.98.90.227]>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski writes:
 > I am running Gentoo with a fresh 2.6.11-r1. I have all the kernel 
 > debugging options turned on. Occasionally, I can get past the boot 
 > process, but half the time it freezes somewhere along the way. If 
 > not, I do get to boot, it doesn't take very long for it to freeze.

Did 2.6.10 work Ok? Try the patch below, it fixes 2.6.11-rc1 boot
lockups on both my Beige G3 (locks up in ADB driver) and my G4 eMac
(locks up in radeonfb).

--- linux-2.6.11-rc1/init/main.c.~1~	2005-01-15 03:30:25.000000000 +0100
+++ linux-2.6.11-rc1/init/main.c	2005-01-15 03:31:44.000000000 +0100
@@ -377,7 +377,7 @@ static void noinline rest_init(void)
 	 * Re-enable preemption but disable interrupts to make sure
 	 * we dont get preempted until we schedule() in cpu_idle().
 	 */
-	local_irq_disable();
+//	local_irq_disable();
 	preempt_enable_no_resched();
 	unlock_kernel();
  	cpu_idle();
