Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVBWPgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVBWPgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVBWPgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:36:07 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:40931 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261287AbVBWPfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:35:52 -0500
Date: Thu, 24 Feb 2005 00:35:42 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc4-mm1] mips: fixed confliction types for
 pcibios_align_resource
Message-Id: <20050224003542.18cb80b4.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes confliction types for pcibios_align_resource.

  CC      arch/mips/pci/pci.o
arch/mips/pci/pci.c:55: error: conflicting types for 'pcibios_align_resource'
include/linux/pci.h:729: error: previous declaration of 'pcibios_align_resource' was here
make[1]: *** [arch/mips/pci/pci.o] Error 1
make: *** [arch/mips/pci] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/pci.c a/arch/mips/pci/pci.c
--- a-orig/arch/mips/pci/pci.c	Sun Feb 13 12:06:55 2005
+++ a/arch/mips/pci/pci.c	Thu Feb 24 00:11:17 2005
@@ -50,8 +50,7 @@
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+pcibios_align_resource(void *data, struct resource *res, u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
