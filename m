Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVBUW1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVBUW1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVBUW1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:27:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9629 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262143AbVBUW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:27:38 -0500
Message-ID: <421A604B.9090302@pobox.com>
Date: Mon, 21 Feb 2005 17:27:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata kfree fix
Content-Type: multipart/mixed;
 boundary="------------080600070009090607070607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600070009090607070607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes double-kfree that caused slab corruption.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

--------------080600070009090607070607
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.116 vs edited =====
--- 1.116/drivers/scsi/libata-core.c	2005-02-01 20:23:51 -05:00
+++ edited/drivers/scsi/libata-core.c	2005-02-20 23:34:32 -05:00
@@ -2800,7 +2800,7 @@
 			return 1;
 
 		/* fall through */
-	
+
 	default:
 		return 0;
 	}
@@ -3743,16 +3743,13 @@
 	if (legacy_mode) {
 		if (legacy_mode & (1 << 0))
 			ata_device_add(probe_ent);
-		else
-			kfree(probe_ent);
 		if (legacy_mode & (1 << 1))
 			ata_device_add(probe_ent2);
-		else
-			kfree(probe_ent2);
-	} else {
+	} else
 		ata_device_add(probe_ent);
-	}
+
 	kfree(probe_ent);
+	kfree(probe_ent2);
 
 	return 0;
 

--------------080600070009090607070607--
