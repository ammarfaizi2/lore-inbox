Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbTGBW7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTGBW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:57:52 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:51106 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265531AbTGBW5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:57:25 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jul 2003 16:04:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Potential inf.loop in bootmem.c ...
Message-ID: <Pine.LNX.4.55.0307021510140.4840@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If __alloc_bootmem_core() fails with a goal and unaligned node_boot_start
it'll loop fovever.



- Davide



--- linux-2.5.73/mm/bootmem.c.orig	2003-07-02 14:55:47.000000000 -0700
+++ linux-2.5.73/mm/bootmem.c	2003-07-02 15:31:44.000000000 -0700
@@ -202,7 +201,7 @@
 		;
 	}

-	if (preferred) {
+	if (preferred > offset) {
 		preferred = offset;
 		goto restart_scan;
 	}
