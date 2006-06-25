Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWFYNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWFYNJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWFYNJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:19 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:6878 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751257AbWFYNJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:15 -0400
Message-ID: <351240952.86721@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130922.216691316@localhost.localdomain>
References: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 3/6] readahead: kconfig option READAHEAD_ALLOW_OVERHEADS
Content-Disposition: inline; filename=readahead-kconfig-allow-overheads.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a kconfig option READAHEAD_ALLOW_OVERHEADS to enable users
to choose extra features that have overheads.

Features with overheads will be disabled by default.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.17-mm2.orig/mm/Kconfig
+++ linux-2.6.17-mm2/mm/Kconfig
@@ -182,10 +182,15 @@ config ADAPTIVE_READAHEAD
 	  It is known to work well for many desktops, file servers and
 	  postgresql databases. Say Y to try it out for yourself.
 
+config READAHEAD_ALLOW_OVERHEADS
+	bool "Allow extra features with overheads"
+	default n
+	depends on ADAPTIVE_READAHEAD
+
 config DEBUG_READAHEAD
 	bool "Readahead debug and accounting"
 	default y
-	depends on ADAPTIVE_READAHEAD
+	depends on READAHEAD_ALLOW_OVERHEADS
 	select DEBUG_FS
 	help
 	  This option injects extra code to dump detailed debug traces and do

--
