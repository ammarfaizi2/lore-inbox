Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbUDRLJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbUDRLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:09:36 -0400
Received: from ozlabs.org ([203.10.76.45]:49113 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264156AbUDRLJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:09:35 -0400
Date: Sun, 18 Apr 2004 21:06:58 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: [PATCH] Oprofilefs cant handle > 99 cpus
Message-ID: <20040418110658.GC26086@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Oprofilefs cant handle > 99 cpus. This should fix it.

Anton

===== oprofile_stats.c 1.6 vs edited =====
--- 1.6/drivers/oprofile/oprofile_stats.c	Mon Jan 19 17:33:51 2004
+++ edited/oprofile_stats.c	Sun Apr 18 19:46:35 2004
@@ -55,7 +55,7 @@
 			continue;
 
 		cpu_buf = &cpu_buffer[i]; 
-		snprintf(buf, 6, "cpu%d", i);
+		snprintf(buf, 10, "cpu%d", i);
 		cpudir = oprofilefs_mkdir(sb, dir, buf);
  
 		/* Strictly speaking access to these ulongs is racy,
