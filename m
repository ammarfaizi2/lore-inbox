Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVAGTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVAGTjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAGThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:37:06 -0500
Received: from king.bitgnome.net ([66.207.162.30]:12227 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S261556AbVAGTaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:30:06 -0500
Date: Fri, 7 Jan 2005 13:29:34 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: linux-kernel@vger.kernel.org
Subject: lost patch for fs/reiserfs/fix_node.c
Message-ID: <20050107192934.GA42646@king.bitgnome.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Any reason the attached patch from Oleg Drokin never made
it even in 2.6.10 now?  I see the supposedly harmless errors this
patch is meant to correct and it seems like an oversight it never
made it into the tree.

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
He hoped and prayed that there wasn't an afterlife. Then he
realized there was a contradiction involved here and merely
hoped that there wasn't an afterlife.
 -- Douglas Adams
----end random quote of the moment----

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="indirect_item.patch"

--- linux-2.6.10/fs/reiserfs/fix_node.c.orig	2004-12-24 15:34:30.000000000 -0600
+++ linux-2.6.10/fs/reiserfs/fix_node.c	2005-01-07 13:20:43.000000000 -0600
@@ -510,9 +510,10 @@
 	// s2bytes
 	snum012[4] = op_unit_num (&vn->vn_vi[split_item_num]) - snum012[4] - bytes_to_r - bytes_to_l - bytes_to_S1new;
 
-	if (vn->vn_vi[split_item_num].vi_index != TYPE_DIRENTRY)
+	if (vn->vn_vi[split_item_num].vi_index != TYPE_DIRENTRY &&
+	    vn->vn_vi[split_item_num].vi_index != TYPE_INDIRECT)
 	    reiserfs_warning (tb->tb_sb, "vs-8115: get_num_ver: not "
-			      "directory item");
+			      "directory or indirect item");
     }
 
     /* now we know S2bytes, calculate S1bytes */

--ikeVEW9yuYc//A+q--
