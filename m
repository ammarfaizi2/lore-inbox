Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWBXUt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWBXUt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWBXUtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:49:31 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:33054 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932437AbWBXUtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:49:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=RTciKMy+IvGqixu9NazYhY+wTMB5xch1yVukTEcnUrmgeoM5qYWgx/fVWSfIKmE3Yw9zzvWqJEYkRIGNie30qSvzr2iaJFWAtlfoUHB8uJpOYDlm7+WdhWfXdvmuQsfvfTlcrQVhOiQW1t1M4wddba8h/zXeJ0Gl8ExbQH8i1x4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/13] fix signed vs unsigned in nmi watchdog
Date: Fri, 24 Feb 2006 21:49:24 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242149.24767.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix "signed vs unsigned" in nmi_watchdog_tick.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/nmi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm2-orig/arch/i386/kernel/nmi.c	2006-02-24 19:25:29.000000000 +0100
+++ linux-2.6.16-rc4-mm2/arch/i386/kernel/nmi.c	2006-02-24 20:55:32.000000000 +0100
@@ -557,7 +557,8 @@ void nmi_watchdog_tick (struct pt_regs *
 	 * always switch the stack NMI-atomically, it's safe to use
 	 * smp_processor_id().
 	 */
-	int sum, cpu = smp_processor_id();
+	unsigned int sum;
+	int cpu = smp_processor_id();
 
 	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
 



