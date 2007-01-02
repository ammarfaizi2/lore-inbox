Return-Path: <linux-kernel-owner+w=401wt.eu-S932865AbXABLhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbXABLhP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbXABLhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:37:15 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3689 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbXABLhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:37:14 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: vio of_node_put cleanup
Date: Tue, 2 Jan 2007 12:38:36 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021238.36297.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for of_node_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/kernel/vio.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/vio.c linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/vio.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/vio.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/vio.c	2007-01-02 01:55:31.000000000 +0100
@@ -199,10 +199,8 @@ EXPORT_SYMBOL(vio_unregister_driver);
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	if (dev->archdata.of_node) {
-		/* XXX should free TCE table */
-		of_node_put(dev->archdata.of_node);
-	}
+	/* XXX should free TCE table */
+	of_node_put(dev->archdata.of_node);
 	kfree(to_vio_dev(dev));
 }
 


-- 
Regards,

	Mariusz Kozlowski
