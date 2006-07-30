Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWG3TJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWG3TJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWG3TJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:09:43 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:10729 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932443AbWG3TJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:09:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mHT8CNvGuCFhVTfEtTiEVQqPePCExgkeflWaD4+RyObTrCQpchKGfAlXeWbXZk69yG9kPyODjXoQr0hlKNIr4UTwjIXPZHPKA6DbS7RR4eUtiS9eXfpSpuZEiOM9KQ/fUGXJLNoo0VW+wzY+6c7kYNh2KcovHz23weI43Q1R1fg=
Date: Sun, 30 Jul 2006 21:09:23 +0200
From: Diego Calleja <diegocg@gmail.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide support for VIA 8237a southbridge
Message-Id: <20060730210923.9092774e.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox added (622b20fcb8b42aa4c3c87c0a036f2ad0927b64bc) some PCI IDs 
for some VIA devices, including the 8237a. The driver, however, has not
been changed to support the 8237a, and someone reported it through
bugzilla (http://bugzilla.kernel.org/show_bug.cgi?id=6925)

So I'm taking the one-liner from:
http://forums.viaarena.com/messageview.aspx?catid=28&threadid=72836&enterthread=y
and submitting it. Please merge it if appropiate.



Signed-off-by: Diego Calleja <diegocg@gmail.com>

--- 2.6/drivers/ide/pci/via82cxxx.c.BUGGY	2006-07-30 20:55:18.000000000 +0200
+++ 2.6/drivers/ide/pci/via82cxxx.c	2006-07-30 21:03:25.000000000 +0200
@@ -6,7 +6,7 @@
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235, vt8237
+ *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -81,6 +81,7 @@ static struct via_isa_bridge {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
