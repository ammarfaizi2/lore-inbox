Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWFVGsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWFVGsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWFVGsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:48:08 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:59869 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751076AbWFVGsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:48:07 -0400
Date: Thu, 22 Jun 2006 09:48:05 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: alesan@manoweb.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cardbus: revert IO window limit
Message-ID: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch reverts commit 4196c3af25d98204216a5d6c37ad2cb303a1f2bf "cardbus:
limit IO windows to 256 bytes" which breaks Alessio Sangalli's machine boot
when APM support is enabled. See http://lkml.org/lkml/2006/6/16/33 for
description of the problem.

Cc: Alessio Sangalli <alesan@manoweb.com>
Cc: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 28ce3a7..657be94 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -40,7 +40,7 @@ #define ROUND_UP(x, a)		(((x) + (a) - 1)
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(256)
+#define CARDBUS_IO_SIZE		(4*1024)
 #define CARDBUS_MEM_SIZE	(32*1024*1024)
 
 static void __devinit
