Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLDVzj>; Mon, 4 Dec 2000 16:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQLDVz3>; Mon, 4 Dec 2000 16:55:29 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:40302 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129183AbQLDVzN>; Mon, 4 Dec 2000 16:55:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14892.2974.153654.949301@somanetworks.com>
Date: Mon, 4 Dec 2000 16:24:46 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: georgn@somanetworks.com, linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: [PATCH] Makefile
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When making the docs, the top-level Makefile unconditionally chmod's
three scripts.

Under BitKeeper, things are normally left read-only and the above mode
change is flagged as an error in subsequent BK operations.

BK is can and does track file modes, so BK users can:

	bk chmod +x scripts/docgen scripts/gen-all-syms scripts/kernel-doc
	(bk commit)

The following patch will not harm BK users and behave as always for
others.


===== Makefile 1.37 vs edited =====
--- 1.37/Makefile	Fri Nov 17 04:47:41 2000
+++ edited/Makefile	Mon Dec  4 16:15:16 2000
@@ -423,9 +423,15 @@
 	sync
 
 sgmldocs: 
-	chmod 755 $(TOPDIR)/scripts/docgen
-	chmod 755 $(TOPDIR)/scripts/gen-all-syms
-	chmod 755 $(TOPDIR)/scripts/kernel-doc
+	if [ ! -x $(TOPDIR)/scripts/docgen ]; then \
+		chmod 755 $(TOPDIR)/scripts/docgen ; \
+	fi ;
+	if [ ! -x $(TOPDIR)/scripts/gen-all-syms ]; then \
+		chmod 755 $(TOPDIR)/scripts/gen-all-syms ; \
+	fi
+	if [ ! -x $(TOPDIR)/scripts/kernel-doc ]; then \
+		chmod 755 $(TOPDIR)/scripts/kernel-doc ; \
+	fi
 	$(MAKE) -C $(TOPDIR)/Documentation/DocBook books
 
 psdocs: sgmldocs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
