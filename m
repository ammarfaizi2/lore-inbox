Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDPOoK>; Mon, 16 Apr 2001 10:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRDPOoB>; Mon, 16 Apr 2001 10:44:01 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:54406 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131986AbRDPOn4>;
	Mon, 16 Apr 2001 10:43:56 -0400
Date: Mon, 16 Apr 2001 16:43:30 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104161443.QAA07696@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.3-ac7 nfsd fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fix for 2.4.3-ac7 nfsd changes: set_bit() needs a pointer
to the lvalue to modify, not the lvalue itself.

/Mikael

--- linux-2.4.3-ac7/fs/nfsd/nfsfh.c.~1~	Mon Apr 16 15:23:54 2001
+++ linux-2.4.3-ac7/fs/nfsd/nfsfh.c	Mon Apr 16 15:57:24 2001
@@ -167,7 +167,7 @@
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	set_bit(D_Disconnected, result->d_flags);
+	set_bit(D_Disconnected, &result->d_flags);
 	d_rehash(result); /* so a dput won't loose it */
 	return result;
 }
