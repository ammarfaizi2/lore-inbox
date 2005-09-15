Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbVIOT1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVIOT1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbVIOT1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:27:14 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:59658 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965265AbVIOT1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:27:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ukgMNqJ3yV51K2x+TOofDHeF4hFyjYv/NMw2TRFEWVPSuW5qpGU3RZ25Kt2zg1dsKGdSGMRBAlfzO9LbA6dRYkw6u0urRsVsWEj435ZAlTugvVspfqwAeXIKHRkBlYrwldyvKQeCVawk+mpg9IKBpXlaG0Z65WvPbxAtwW5RQ34=
Date: Thu, 15 Sep 2005 23:37:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org, James Lamanna <jlamanna@gmail.com>
Subject: [PATCH] agp: backend: vfree() checking cleanup
Message-ID: <20050915193724.GA21565@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Lamanna <jlamanna@gmail.com>

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/agp/backend.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/char/agp/backend.c
+++ b/drivers/char/agp/backend.c
@@ -135,7 +135,7 @@ static int agp_find_max(void)
 
 static int agp_backend_initialize(struct agp_bridge_data *bridge)
 {
-	int size_value, rc, got_gatt=0, got_keylist=0;
+	int size_value, rc, got_gatt=0;
 
 	bridge->max_memory_agp = agp_find_max();
 	bridge->version = &agp_current_version;
@@ -173,7 +173,6 @@ static int agp_backend_initialize(struct
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	got_keylist = 1;
 
 	/* FIXME vmalloc'd memory not guaranteed contiguous */
 	memset(bridge->key_list, 0, PAGE_SIZE * 4);
@@ -192,10 +191,8 @@ err_out:
 				gart_to_virt(bridge->scratch_page_real));
 	if (got_gatt)
 		bridge->driver->free_gatt_table(bridge);
-	if (got_keylist) {
-		vfree(bridge->key_list);
-		bridge->key_list = NULL;
-	}
+	vfree(bridge->key_list);
+	bridge->key_list = NULL;
 	return rc;
 }
 

