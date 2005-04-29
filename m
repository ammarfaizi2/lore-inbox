Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVD2Leh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVD2Leh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVD2Leg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:34:36 -0400
Received: from av2.karneval.cz ([81.27.192.108]:60728 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S262305AbVD2Le3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:34:29 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name, sam@ravnborg.org
Subject: [PATCH] preserve ARCH and CROSS_COMPILE in the build directory generated Makefile
Date: Fri, 29 Apr 2005 13:35:33 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504291335.34210.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures, that architecture and target cross-tools prefix
is preserved in the Makefile generated in the build directory for
out of source tree kernel compilation. This prevents accidental
screwing of configuration and builds for the case, that make without
full architecture specific options is invoked in the build
directory. It is secure use accustomed "make", "make xconfig",
etc. without fear and special care now.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Index: linux-2.6.11.5/scripts/mkmakefile
===================================================================
--- linux-2.6.11.5.orig/scripts/mkmakefile
+++ linux-2.6.11.5/scripts/mkmakefile
@@ -29,3 +29,9 @@ all:
 
 EOF
 
+if [ -n "${ARCH}" ] ; then
+	echo "ARCH ?= ${ARCH}"
+fi
+if [ -n "${CROSS_COMPILE}" ] ; then
+	echo "CROSS_COMPILE ?= ${CROSS_COMPILE}"
+fi

