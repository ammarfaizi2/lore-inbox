Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031382AbWKUUS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031382AbWKUUS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934411AbWKUUS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:18:29 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:10720 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S934402AbWKUUS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:18:28 -0500
Date: Tue, 21 Nov 2006 12:18:12 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: arch/x86_64/kernel/apic.c(701): remark #593: variable "ver" was
 set but never us
In-Reply-To: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611211214230.25455@attu4.cs.washington.edu>
References: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused GET_APIC_VERSION call from clear_local_APIC() and 
__setup_APIC_LVTT().

Reported by D Binderman <dcb314@hotmail.com>.

Cc: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/x86_64/kernel/apic.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 4d9d5ed..96743aa 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -133,7 +133,6 @@ void clear_local_APIC(void)
 		apic_write(APIC_LVTERR, APIC_LVT_MASKED);
 	if (maxlvt >= 4)
 		apic_write(APIC_LVTPC, APIC_LVT_MASKED);
-	v = GET_APIC_VERSION(apic_read(APIC_LVR));
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 }
@@ -644,10 +643,9 @@ #define APIC_DIVISOR 16
 
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
-	unsigned int lvtt_value, tmp_value, ver;
+	unsigned int lvtt_value, tmp_value;
 	int cpu = smp_processor_id();
 
-	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 
 	if (cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask))
