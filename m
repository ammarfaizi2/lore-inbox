Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQJ1Grz>; Sat, 28 Oct 2000 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbQJ1Gro>; Sat, 28 Oct 2000 02:47:44 -0400
Received: from gondor.apana.org.au ([203.14.152.114]:13573 "EHLO
	gondor.apana.org.au") by vger.kernel.org with ESMTP
	id <S131023AbQJ1Grg>; Sat, 28 Oct 2000 02:47:36 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 28 Oct 2000 17:46:52 +1100
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] a buglet in fbcon_getxy
Message-ID: <20001028174652.A32140@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is probably responsible for
	http://bugs.debian.org/72378

The patch should apply cleanly for both 2.2 and 2.4 test.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/video/fbcon.c
===================================================================
RCS file: /home/gondor/herbert/src/CVS/debian/kernel-source/drivers/video/fbcon.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 fbcon.c
--- drivers/video/fbcon.c	2000/09/04 17:39:22	1.1.1.5
+++ drivers/video/fbcon.c	2000/10/28 04:50:14
@@ -1806,12 +1806,13 @@
     	    y += softback_lines;
     	ret = pos + (conp->vc_cols - x) * 2;
     } else if (conp->vc_num == fg_console && softback_lines) {
-    	unsigned long offset = (pos - softback_curr) / 2;
+    	unsigned long offset = pos - softback_curr;
     	
+    	if (pos < softback_curr)
+    	    offset += softback_end - softback_buf;
+    	offset /= 2;
     	x = offset % conp->vc_cols;
     	y = offset / conp->vc_cols;
-    	if (pos < softback_curr)
-	    y += (softback_end - softback_buf) / conp->vc_size_row;
 	ret = pos + (conp->vc_cols - x) * 2;
 	if (ret == softback_end)
 	    ret = softback_buf;

--cNdxnHkX5QqsyA0e--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
