Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbRHAXyY>; Wed, 1 Aug 2001 19:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbRHAXyE>; Wed, 1 Aug 2001 19:54:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:29385 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267850AbRHAXyA>;
	Wed, 1 Aug 2001 19:54:00 -0400
Date: Thu, 2 Aug 2001 01:53:27 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill unneeded code from mm/memory.c
Message-ID: <20010802015327.A28374@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

the attached patch kills a one of the two identical conditionals
at the end of vmtruncate.  This piece of code is only in -ac, btw.

Please consider applying.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr ../master/linux-2.4.7-ac3/mm/memory.c linux/mm/memory.c
--- ../master/linux-2.4.7-ac3/mm/memory.c	Thu Aug  2 01:48:23 2001
+++ linux/mm/memory.c	Thu Aug  2 01:50:12 2001
@@ -1041,17 +1041,10 @@
 		}
 	}
 	inode->i_size = offset;
-	if (inode->i_op && inode->i_op->truncate)
-	{
-		/* This doesnt scale but it is meant to be a 2.4 invariant */
-		lock_kernel();
-		inode->i_op->truncate(inode);
-		unlock_kernel();
-	}
-	return 0;
-	
+
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate) {
+		/* This doesnt scale but it is meant to be a 2.4 invariant */
 		lock_kernel();
  		inode->i_op->truncate(inode);
 		unlock_kernel();
