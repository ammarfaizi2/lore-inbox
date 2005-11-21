Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVKUWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVKUWbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVKUWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:31:12 -0500
Received: from [205.233.219.253] ([205.233.219.253]:27604 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751179AbVKUWbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:31:10 -0500
Date: Mon, 21 Nov 2005 17:28:14 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] csr1212: add check for !valid
Message-ID: <20051121222814.GR20781@conscoop.ottawa.on.ca>
References: <20051120231000.GE16060@stusta.de> <438223D9.8010504@s5r6.in-berlin.de> <20051121214130.GL20781@conscoop.ottawa.on.ca> <438243E2.6050807@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438243E2.6050807@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't read the keyval if there's already a valid one in place.  May not be
necessary but shouldn't hurt.

Signed-off-by: Jody McIntyre <scjdy@steamballoon.com>


Index: linux/drivers/ieee1394/csr1212.c
===================================================================
--- linux.orig/drivers/ieee1394/csr1212.c
+++ linux/drivers/ieee1394/csr1212.c
@@ -1618,7 +1618,8 @@ int csr1212_parse_csr(struct csr1212_csr
 	 * and make cache regions for them */
 	for (dentry = csr->root_kv->value.directory.dentries_head;
 	     dentry; dentry = dentry->next) {
-		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
+		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM &&
+			!dentry->kv->valid) {
 			ret = _csr1212_read_keyval(csr, dentry->kv);
 			if (ret != CSR1212_SUCCESS)
 				return ret;
