Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWFMTyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWFMTyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWFMTyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:54:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:2015 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932118AbWFMTyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:54:31 -0400
Date: Tue, 13 Jun 2006 21:54:30 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] x86_64 apic.h cpu_relax() (was: [RFC -mm] more cpu_relax() places?)
Message-ID: <20060613195430.GC24167@rhlx01.fht-esslingen.de>
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
> Hi all,
> 
> while reviewing 2.6.17-rc6-mm1, I found some places that might
> want to make use of cpu_relax() in order to not block secondary
> pipelines while busy-polling (probably especially useful on SMT CPUs):

Patch no. 3 of 3.

This one is adding a cpu_relax() that already existed in the i386 version.
Any reason this wasn't there, too?

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/include/asm-x86_64/apic.h linux-2.6.17-rc6-mm2.my/include/asm-x86_64/apic.h
--- linux-2.6.17-rc6-mm2.orig/include/asm-x86_64/apic.h	2006-06-13 19:28:16.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/include/asm-x86_64/apic.h	2006-06-13 19:34:08.000000000 +0200
@@ -49,7 +49,8 @@
 
 static __inline__ void apic_wait_icr_idle(void)
 {
-	while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY );
+	while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY )
+		cpu_relax();
 }
 
 static inline void ack_APIC_irq(void)
