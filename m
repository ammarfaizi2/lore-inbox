Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFBT4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTFBT4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:56:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49821 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261153AbTFBT4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:56:49 -0400
Date: Mon, 2 Jun 2003 15:10:12 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: multipart/mixed; boundary=Apple-Mail-15--1031998591
Subject: [CHECKER][PATCH] pnpbios dereferencing user pointer
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linux-kernel@vger.kernel.org
Message-Id: <37C2C7CC-9536-11D7-BBCD-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-15--1031998591
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Another simple case of a memcpy that should be copy_from_user...

-- 
Hollis Blanchard
IBM Linux Technology Center

--Apple-Mail-15--1031998591
Content-Disposition: attachment;
	filename=pnpbios-memcpy.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="pnpbios-memcpy.diff"

--- linux-2.5.70/drivers/pnp/pnpbios/proc.c.orig	Mon Mar 24 16:30:11 2003
+++ linux-2.5.70/drivers/pnp/pnpbios/proc.c	Tue May 27 13:18:57 2003
@@ -185,7 +185,10 @@
 		return -EIO;
 	if (count != node->size - sizeof(struct pnp_bios_node))
 		return -EINVAL;
-	memcpy(node->data, buf, count);
+	if (copy_from_user(node->data, buf, count)) {
+		kfree(node);
+		return -EFAULT;
+	}
 	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
 	    return -EINVAL;
 	kfree(node);

--Apple-Mail-15--1031998591--

