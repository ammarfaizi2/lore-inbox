Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVCQLx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVCQLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbVCQLwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:52:35 -0500
Received: from ozlabs.org ([203.10.76.45]:38810 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263065AbVCQLMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:12:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.26163.113395.168591@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 22:12:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Olaf Hering <olh@suse.de>, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 allow xmon=on,off,early
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allow 'xmon' or 'xmon=early' to enter xmon very early during boot.
allow 'xmon=on' to just enable it, or 'xmon=off' to disable it.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/setup.c test/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2005-03-07 08:21:53.000000000 +1100
+++ test/arch/ppc64/kernel/setup.c	2005-03-17 21:49:31.000000000 +1100
@@ -1361,6 +1361,12 @@
 static int __init early_xmon(char *p)
 {
 	/* ensure xmon is enabled */
+	if (p) {
+		if (strncmp(p, "on", 2) == 0)
+			xmon_init();
+		if (strncmp(p, "early", 5) != 0)
+			return 0;
+	}
 	xmon_init();
 	debugger(NULL);
 
