Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932976AbWF0CdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbWF0CdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWF0CdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:33:13 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:37783 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S932976AbWF0CdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:33:12 -0400
Subject: [PATCH] voyager: add cpu_present_map
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 21:33:09 -0500
Message-Id: <1151375589.3443.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voyager stopped booting some time in the 2.6.16-2.6.17 timeframe;
the reason was that it doesn't have a cpu_present_map, so add
one.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

I'm not sure how it didn't notice the omission before, but it certainly
notices now.

James


diff --git a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyager_smp.c
index 8165626..3c368fe 100644
--- a/arch/i386/mach-voyager/voyager_smp.c
+++ b/arch/i386/mach-voyager/voyager_smp.c
@@ -661,6 +661,7 @@ #endif
 		print_cpu_info(&cpu_data[cpu]);
 		wmb();
 		cpu_set(cpu, cpu_callout_map);
+		cpu_set(cpu, cpu_present_map);
 	}
 	else {
 		printk("CPU%d FAILED TO BOOT: ", cpu);
@@ -1912,6 +1913,7 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_possible_map);
+	cpu_set(smp_processor_id(), cpu_present_map);
 }
 
 int __devinit


