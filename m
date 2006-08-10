Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWHJTub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWHJTub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWHJTuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:50:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:10732 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932654AbWHJThW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:22 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [122/145] i386: Fix warning in mpparse.c
Message-Id: <20060810193721.714BF13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:21 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Fix

linux/arch/i386/kernel/mpparse.c: In function #MP_bus_info#:
linux/arch/i386/kernel/mpparse.c:232: warning: comparison is always false due to limited range of data type

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/mpparse.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c
+++ linux/arch/i386/kernel/mpparse.c
@@ -229,12 +229,14 @@ static void __init MP_bus_info (struct m
 
 	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
 
+#if MAX_MP_BUSSES < 256
 	if (m->mpc_busid >= MAX_MP_BUSSES) {
 		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
 			" is too large, max. supported is %d\n",
 			m->mpc_busid, str, MAX_MP_BUSSES - 1);
 		return;
 	}
+#endif
 
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
