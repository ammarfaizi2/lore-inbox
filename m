Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUFPNoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUFPNoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUFPNoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:44:14 -0400
Received: from [213.78.111.21] ([213.78.111.21]:12672 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S266278AbUFPNml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:42:41 -0400
From: Chris Lingard <chris@ukpost.com>
To: Michael Elizabeth Chastain <mec@shout.net>
Subject: make xconfig needs QTDIR; though qt is in /usr
Date: Wed, 16 Jun 2004 14:42:38 +0100
User-Agent: KMail/1.6.2
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O5E0An2NEhep906"
Message-Id: <200406161442.38245.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_O5E0An2NEhep906
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All versions of Linux-2.6

I install qt and all other stuff in /usr; and do not set
QTDIR, as it is not needed.

Can /usr be added to the scripts/kconfig/Makefile?
I attach a patch.  The last two variables of:

@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \

seem pointless as it is looking for a header file.

The patch just adds /usr to the end; but I suggest that the
line could be

@set -e; for d in $$QTDIR /usr; do \

Chris Lingard

--Boundary-00=_O5E0An2NEhep906
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.7-qtdir_in_usr"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.7-qtdir_in_usr"

diff -Naur linux-2.6.7.old/scripts/kconfig/Makefile linux-2.6.7/scripts/kconfig/Makefile
--- linux-2.6.7.old/scripts/kconfig/Makefile	2004-04-05 18:19:04.000000000 +0100
+++ linux-2.6.7/scripts/kconfig/Makefile	2004-06-16 13:33:38.988229264 +0100
@@ -112,7 +112,7 @@
 
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
+	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt* /usr; do \
 	  if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
 	done; \
 	if [ -z "$$DIR" ]; then \

--Boundary-00=_O5E0An2NEhep906--
