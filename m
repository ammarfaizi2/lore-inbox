Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbULVOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbULVOwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbULVOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:52:43 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:36061 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S261550AbULVOwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:52:41 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: linux-kernel@vger.kernel.org
Subject: Patch to get swap_token working without CONFIG_SWAP
Date: Wed, 22 Dec 2004 15:52:35 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412221552.35700.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some embedded devices won't have CONFIG_SWAP defined, this breaks rmap.c 
near line 386. This fixes it:

#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

--- linux-2.6/mm/rmap.c~fix-rmapswap
+++ linux-2.6/mm/rmap.c
@@ -395,8 +395,10 @@
 {
        int referenced = 0;

+#ifdef CONFIG_SWAP
        if (!swap_token_default_timeout)
                ignore_token = 1;
+#endif

        if (page_test_and_clear_young(page))
                referenced++;
