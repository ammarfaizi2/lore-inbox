Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWAFPQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWAFPQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWAFPQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:16:46 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:410 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751459AbWAFPQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:45 -0500
Date: Fri, 6 Jan 2006 12:07:26 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: ak@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: Sparse warnings fix.
Message-Id: <20060106120726.6693406e.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following sparse warnings:

arch/x86_64/kernel/mce_amd.c:321:29: warning: Using plain integer as NULL pointer
arch/x86_64/kernel/mce_amd.c:410:41: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 arch/x86_64/kernel/mce_amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/mce_amd.c b/arch/x86_64/kernel/mce_amd.c
index 1f76175..ed5bc57 100644
--- a/arch/x86_64/kernel/mce_amd.c
+++ b/arch/x86_64/kernel/mce_amd.c
@@ -318,7 +318,7 @@ static struct kobj_type threshold_ktype 
 static __cpuinit int threshold_create_bank(unsigned int cpu, int bank)
 {
 	int err = 0;
-	struct threshold_bank *b = 0;
+	struct threshold_bank *b = NULL;
 
 #ifdef CONFIG_SMP
 	if (cpu_core_id[cpu] && shared_bank[bank]) {	/* symlink */
@@ -407,7 +407,7 @@ static __cpuinit void threshold_remove_b
 	if (shared_bank[bank] && atomic_read(&b->kobj.kref.refcount) > 2) {
 		sprintf(name, "bank%i", bank);
 		sysfs_remove_link(&per_cpu(device_threshold, cpu).kobj, name);
-		per_cpu(threshold_banks, cpu)[bank] = 0;
+		per_cpu(threshold_banks, cpu)[bank] = NULL;
 	} else {
 		kobject_unregister(&b->kobj);
 		kfree(per_cpu(threshold_banks, cpu)[bank]);


-- 
Luiz Fernando N. Capitulino
