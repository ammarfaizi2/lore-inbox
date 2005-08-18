Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVHRVRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVHRVRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVHRVRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:17:16 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49600
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932454AbVHRVRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:17:15 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1124378663.23647.346.camel@tglx.tec.linutronix.de>
References: <20050818060126.GA13152@elte.hu>
	 <1124378663.23647.346.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 18 Aug 2005 23:17:44 +0200
Message-Id: <1124399864.23647.363.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 17:24 +0200, Thomas Gleixner wrote:
> finally found the deadlock. It was caused by IRQ flood, which was
> introduced by the end_irq() changes.

Found another one to back out. It creaped in with the same patch. 

It's slow and just conceals bad configured PICs and crappy demux
handlers.


tglx


--- linux-2.6.13-rc6-rt9/arch/ppc/syslib/open_pic.c	2005-08-18 17:37:39.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/arch/ppc/syslib/open_pic.c	2005-08-18 23:02:12.000000000 +0200
@@ -816,10 +816,6 @@ static void openpic_set_sense(u_int irq,
 }
 #endif /* notused */
 
-#ifdef CONFIG_PREEMPT_RT
-#define __SLOW_VERSION__
-#endif
-
 /* No spinlocks, should not be necessary with the OpenPIC
  * (1 register = 1 interrupt and we have the desc lock).
  */


