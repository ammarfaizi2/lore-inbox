Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269942AbRHJQPm>; Fri, 10 Aug 2001 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269943AbRHJQPd>; Fri, 10 Aug 2001 12:15:33 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:39944
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S269942AbRHJQPP>; Fri, 10 Aug 2001 12:15:15 -0400
Date: Fri, 10 Aug 2001 12:25:32 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.6 ipconfig for NFS root
Message-ID: <20010810122532.B15114@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this on 2.4.6, 2.4.7 and 2.2.19.  No problems that I could see.

Comments?

--- ../2.4.6-orig/net/ipv4/ipconfig.c	Tue Aug  7 10:02:21 2001
+++ 2.4.6/net/ipv4/ipconfig.c	Tue Aug  7 09:34:54 2001
@@ -1093,7 +1093,11 @@
 	proc_net_create("pnp", 0, pnp_get_info);
 #endif /* CONFIG_PROC_FS */
 
-	if (!ic_enable)
+	if (!ic_enable
+#if defined(IPCONFIG_DYNAMIC) && defined(CONFIG_ROOT_NFS)
+	    && ROOT_DEV != MKDEV(UNNAMED_MAJOR, 255)
+#endif
+	   )
 		return 0;
 
 	DBG(("IP-Config: Entered.\n"));


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
