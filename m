Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUEMSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUEMSfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUEMSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:32:58 -0400
Received: from village.ehouse.ru ([193.111.92.18]:1040 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264386AbUEMScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:32:11 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs (3/5): binary search microoptimisation
Date: Thu, 13 May 2004 22:21:18 +0400
User-Agent: KMail/1.6.1
Cc: Will Dyson <will_dyson@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <E1BOL04-0003ou-02@mail.ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move value initialisation out of the loop body.

===== fs/befs/btree.c 1.6 vs edited =====
--- 1.6/fs/befs/btree.c	Sun Jul 13 19:55:50 2003
+++ edited/fs/befs/btree.c	Thu May 13 19:45:39 2004
@@ -372,12 +372,12 @@
 		thiskey = befs_bt_get_key(sb, node, mid, &keylen);
 		eq = befs_compare_strings(thiskey, keylen, findkey,
 					  findkey_len);
-		*value = fs64_to_cpu(sb, valarray[mid]);
 
 		if (eq == 0) {
 			befs_debug(sb, "<--- befs_find_key() found %s at %d",
 				   thiskey, mid);
 
+			*value = fs64_to_cpu(sb, valarray[mid]);
 			return BEFS_BT_MATCH;
 		}
 		if (eq > 0)
@@ -387,6 +387,8 @@
 	}
 	if (eq < 0)
 		*value = fs64_to_cpu(sb, valarray[mid + 1]);
+	else
+		*value = fs64_to_cpu(sb, valarray[mid]);
 	befs_debug(sb, "<--- befs_find_key() found %s at %d", thiskey, mid);
 	return BEFS_BT_PARMATCH;
 }

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

