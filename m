Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVBUEfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVBUEfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVBUEfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:35:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44227 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261804AbVBUEfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:35:33 -0500
Message-ID: <42196505.5020900@pobox.com>
Date: Sun, 20 Feb 2005 23:35:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH #2] Re: slab corruption on 2.6.10-rc4-bk7
References: <20050219221624.GB803@redhat.com> <20050219144147.4c771d4f.akpm@osdl.org> <42196387.2070505@pobox.com>
In-Reply-To: <42196387.2070505@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050400090202030507080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400090202030507080209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Actually, here's a better fix.

	Jeff




--------------050400090202030507080209
Content-Type: text/x-patch;
 name="libata_probe_ent_free_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata_probe_ent_free_fix.patch"

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
 

--------------050400090202030507080209--
