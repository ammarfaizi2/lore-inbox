Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTFAN2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264611AbTFAN2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:28:21 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:58888 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S264610AbTFAN2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:28:18 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.70-bk6 make xconfig fails
Date: Sun, 1 Jun 2003 15:41:48 +0200
User-Agent: KMail/1.5.2
Cc: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306011541.48530.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is with gcc 3.3, no error with gcc 2.95.3

  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -O2  -I/opt/qt/include  -c -o 
scripts/kconfig/qconf.o scripts/kconfig/qconf.cc
scripts/kconfig/qconf.cc: In destructor `virtual ConfigItem::~ConfigItem()':
scripts/kconfig/qconf.cc:291: error: non-lvalue in unary `&'
make[1]: *** [scripts/kconfig/qconf.o] Error 1
make: *** [scripts/kconfig/qconf] Error 2

following patch fixes it for gcc 3.3 (and still compiles with gcc 2.95.3).

	Rudmer

--- linux-2.5.70-bk6/scripts/kconfig/qconf.cc.orig	2003-06-01 
15:19:51.000000000 +0200
+++ linux-2.5.70-bk6/scripts/kconfig/qconf.cc	2003-06-01 15:25:01.000000000 
+0200
@@ -288,7 +288,7 @@
 ConfigItem::~ConfigItem(void)
 {
 	if (menu) {
-		ConfigItem** ip = &(ConfigItem*)menu->data;
+		ConfigItem** ip = (ConfigItem**)&menu->data;
 		for (; *ip; ip = &(*ip)->nextItem) {
 			if (*ip == this) {
 				*ip = nextItem;

