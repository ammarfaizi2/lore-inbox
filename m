Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUHRVrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUHRVrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267838AbUHRVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:47:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:46510 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267835AbUHRVrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:47:05 -0400
Subject: [PATCH] ppc32: Fix booting on some OldWolrd Macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1092865044.9529.200.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 07:37:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

It seems that on some OldWolrd macs, we don't get the OF stdout device,
thus the new set_preferred_console() dies at boot trying to dereference
a NULL pointer. Here's a fix:

===== arch/ppc/kernel/setup.c 1.59 vs edited =====
--- 1.59/arch/ppc/kernel/setup.c	2004-07-27 08:27:53 +10:00
+++ edited/arch/ppc/kernel/setup.c	2004-08-18 21:38:17 +10:00
@@ -484,6 +484,9 @@
 	char *name;
 	int offset;
 
+	if (of_stdout_device == NULL)
+		return -ENODEV;
+
 	/* The user has requested a console so this is already set up. */
 	if (strstr(saved_command_line, "console="))
 		return -EBUSY;


