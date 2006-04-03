Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWDCXCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWDCXCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWDCXCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:02:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:30948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964914AbWDCXCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:02:32 -0400
X-Authenticated: #31060655
Message-ID: <4431A986.1070402@gmx.net>
Date: Tue, 04 Apr 2006 01:02:30 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix unneeded rebuilds in drivers/net/chelsio after moving
 source tree
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net> <20060331152226.GB8992@mars.ravnborg.org> <4431A338.3000709@gmx.net>
In-Reply-To: <4431A338.3000709@gmx.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some uneeded rebuilds under drivers/net/chelsio after moving
the source tree. The makefiles used $(TOPDIR) for include paths, which 
is unnecessary. Changed to use relative paths.

Compile tested, produces byte-identical code to the previous makefiles.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

-- 
http://www.hailfinger.org/

--- linux-2.6.16/drivers/net/chelsio/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/net/chelsio/Makefile	2006-04-04 00:45:21.000000000 +0200
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_CHELSIO_T1) += cxgb.o
 
-EXTRA_CFLAGS += -I$(TOPDIR)/drivers/net/chelsio $(DEBUG_FLAGS)
+EXTRA_CFLAGS += -Idrivers/net/chelsio $(DEBUG_FLAGS)
 
 
 cxgb-objs := cxgb2.o espi.o pm3393.o sge.o subr.o mv88x201x.o




