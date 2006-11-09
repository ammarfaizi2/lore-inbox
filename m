Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161782AbWKIBvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161782AbWKIBvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161784AbWKIBvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:51:36 -0500
Received: from mga06.intel.com ([134.134.136.21]:46692 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161782AbWKIBvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:51:35 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="158544491:sNHT21521724"
Date: Wed, 8 Nov 2006 17:29:05 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com, greg@kroah.com
Subject: [patch 3/4] x86_64: add genapic_force
Message-ID: <20061108172905.D10294@unix-os.sc.intel.com>
References: <20061108172017.A10294@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061108172017.A10294@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Wed, Nov 08, 2006 at 05:20:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add genapic_force. Used by the next Intel quirks patch.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/x86_64/kernel/genapic.c b/arch/x86_64/kernel/genapic.c
index 8e78a75..b007433 100644
--- a/arch/x86_64/kernel/genapic.c
+++ b/arch/x86_64/kernel/genapic.c
@@ -33,7 +33,7 @@ extern struct genapic apic_flat;
 extern struct genapic apic_physflat;
 
 struct genapic *genapic = &apic_flat;
-
+struct genapic *genapic_force;
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
@@ -46,6 +46,13 @@ void __init clustered_apic_check(void)
 	u8 cluster_cnt[NUM_APIC_CLUSTERS];
 	int max_apic = 0;
 
+	/* genapic selection can be forced because of certain quirks.
+	 */
+	if (genapic_force) {
+		genapic = genapic_force;
+		goto print;
+	}
+
 #if defined(CONFIG_ACPI)
 	/*
 	 * Some x86_64 machines use physical APIC mode regardless of how many
diff --git a/include/asm-x86_64/genapic.h b/include/asm-x86_64/genapic.h
index a0e9a4b..b80f4bb 100644
--- a/include/asm-x86_64/genapic.h
+++ b/include/asm-x86_64/genapic.h
@@ -30,6 +30,6 @@ struct genapic {
 };
 
 
-extern struct genapic *genapic;
+extern struct genapic *genapic, *genapic_force, apic_flat;
 
 #endif
