Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUGSNwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUGSNwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGSNwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:52:10 -0400
Received: from msgdirector3.onetel.net.uk ([212.67.96.159]:15199 "EHLO
	msgdirector3.onetel.net.uk") by vger.kernel.org with ESMTP
	id S265256AbUGSNwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:52:06 -0400
From: Chris Lingard <chris@ukpost.com>
To: zippel@linux-m68k.org
Subject: PATCH Trivial fix for xconfig
Date: Mon, 19 Jul 2004 14:51:55 +0100
User-Agent: KMail/1.6.2
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407191451.55828.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All versions of Linux 2-6

When qt is installed in /usr, then there is no need to set and
export QTDIR; but make xconfig expects this.

This patch adds /usr to the script, and removes two header search
paths that would need QTDIR set.

diff -Naur linux-2.6.7.old/scripts/kconfig/Makefile 
linux-2.6.7/scripts/kconfig/Makefile
--- linux-2.6.7.old/scripts/kconfig/Makefile    2004-04-05 18:19:04.000000000 
+0100
+++ linux-2.6.7/scripts/kconfig/Makefile        2004-07-19 13:35:28.914128104 
+0100
@@ -112,7 +112,7 @@

 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-       @set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
+       @set -e; for d in $$QTDIR /usr; do \
          if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
        done; \
        if [ -z "$$DIR" ]; then \

Signed off Chris Lingard chris@ukpost.com
