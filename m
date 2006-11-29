Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756498AbWK2L34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbWK2L34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757667AbWK2L3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:29:55 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:49802 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1757664AbWK2L3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:29:55 -0500
Message-ID: <364799788.25059@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061129112948.751104000@intel.ustc.edu.cn>
References: <20061129111416.430835000@intel.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 19:14:17 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch 1/2] readahead sysctl parameters fix
Content-Disposition: inline; filename=readahead-sysctl-parameters-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- do no extra readahead when (readahead_ratio == 1)
- define readahead_hit_rate inside CONFIG_ADAPTIVE_READAHEAD ifdefs

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.19-rc6-mm1.orig/include/linux/mm.h
+++ linux-2.6.19-rc6-mm1/include/linux/mm.h
@@ -1074,7 +1074,7 @@ extern int readahead_ratio;
 
 static inline int prefer_adaptive_readahead(void)
 {
-	return readahead_ratio > 1;
+	return readahead_ratio != 1;
 }
 
 /* Do stack extension */
--- linux-2.6.19-rc6-mm1.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.19-rc6-mm1/Documentation/sysctl/vm.txt
@@ -234,7 +234,7 @@ plenty of memory(>>2MB per reader), a bi
 readahead_ratio also selects the readahead logic:
 	VALUE	CODE PATH
 	-------------------------------------------
-	    0	disable readahead totally
+	    0	read as is, no extra readahead
 	    1	select the stock readahead logic
 	2-100	select the adaptive readahead logic
 
--- linux-2.6.19-rc6-mm1.orig/mm/readahead.c
+++ linux-2.6.19-rc6-mm1/mm/readahead.c
@@ -40,10 +40,10 @@
 /* Set read-ahead size to ##% of the thrashing-threshold. */
 int readahead_ratio = 50;
 EXPORT_SYMBOL_GPL(readahead_ratio);
-#endif
 
 /* Readahead as long as cache hit ratio keeps above 1/##. */
 int readahead_hit_rate = 0;
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
 
 /*
  * Detailed classification of read-ahead behaviors.

--
