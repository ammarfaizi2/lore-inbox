Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUGAMnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUGAMnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUGAMnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:43:46 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:37097 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264815AbUGAMnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:43:41 -0400
Message-ID: <40E407D2.9030706@quark.didntduck.org>
Date: Thu, 01 Jul 2004 08:47:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Sort modules for modpost and modinst
Content-Type: multipart/mixed;
 boundary="------------040300050007090107060106"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040300050007090107060106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Process modules in sorted order during modpost and modules install.

--
				Brian Gerst


--------------040300050007090107060106
Content-Type: text/plain;
 name="modsort-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modsort-1"

diff -urN linux/scripts/Makefile.modinst linux2/scripts/Makefile.modinst
--- linux/scripts/Makefile.modinst	2004-06-29 13:45:26.232647680 -0400
+++ linux2/scripts/Makefile.modinst	2004-06-29 11:36:33.191248664 -0400
@@ -9,7 +9,7 @@
 
 #
 
-__modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
+__modules := $(sort $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 .PHONY: $(modules)
diff -urN linux/scripts/Makefile.modpost linux2/scripts/Makefile.modpost
--- linux/scripts/Makefile.modpost	2004-06-29 13:45:32.643673056 -0400
+++ linux2/scripts/Makefile.modpost	2004-06-29 10:49:20.145937016 -0400
@@ -41,7 +41,7 @@
 symverfile := $(objtree)/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
-__modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
+__modules := $(sort $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
 
 _modpost: $(modules)


--------------040300050007090107060106--
