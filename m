Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWJaAmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWJaAmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWJaAmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:42:44 -0500
Received: from mx0.karneval.cz ([81.27.192.123]:27493 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1422651AbWJaAmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:42:40 -0500
Message-id: <350625042580122316@karneval.cz>
Subject: [PATCH 7/9] Char: sx, fix return in module init
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:42:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, fix return in module init

if pci_register_driver fails, but eisa_driver_register doesn't, we don't
call misc_deregister, but returns error. Return OK in such cases.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit c1124b32f6ab775db247b56206e3bc6f28f3f741
tree fa9a86433f5ca2c984ccd46a2c730fb9ed34feb7
parent d6a49f7c30c60781420537fea54e8133ab2ed35f
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:44:54 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:44:54 +0100

 drivers/char/sx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 4414cd8..339f278 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2661,6 +2661,7 @@ #endif
 		retval = 0;
 	} else if (retval) {
 #ifdef CONFIG_EISA
+		retval = retval1;
 		if (retval1)
 #endif
 			misc_deregister(&sx_fw_device);
