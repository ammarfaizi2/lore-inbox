Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTD2JcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTD2JcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 05:32:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:56056 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261296AbTD2JcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 05:32:17 -0400
From: Karl Weigel <xml-22047@gmx.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: linux-2.5.68-bk8: Problem with "make xconfig"
Date: Tue, 29 Apr 2003 11:27:39 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291127.39758.xml-22047@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,


I have difficulties with configuring the kernel with "make xconfig":

  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -O2  -I/usr/lib/qt3/include  -c -o 
scripts/kconfig/qconf.o scripts/kconfig/qconf.cc
scripts/kconfig/qconf.cc: In destructor `virtual ConfigItem::~ConfigItem()':
scripts/kconfig/qconf.cc:291: error: non-lvalue in unary `&'
make[1]: *** [scripts/kconfig/qconf.o] Fehler 1
make: *** [scripts/kconfig/qconf] Fehler 2


After changing the offending line, it did compile and I was able to configure 
the kernel. However, I am not really sure, whether this change is correct:

--- scripts/kconfig/qconf.cc~   2003-03-17 22:43:38.000000000 +0100
+++ scripts/kconfig/qconf.cc    2003-04-29 11:07:57.000000000 +0200
@@ -288,7 +288,7 @@
 ConfigItem::~ConfigItem(void)
 {
        if (menu) {
-               ConfigItem** ip = &(ConfigItem*)menu->data;
+               ConfigItem** ip = (ConfigItem**)&(menu->data);
                for (; *ip; ip = &(*ip)->nextItem) {
                        if (*ip == this) {
                                *ip = nextItem;


My environment is SuSE Linux 8.2 and GCC 3.3
g++ --version
g++ (GCC) 3.3 20030226 (prerelease) (SuSE Linux)
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


I would like to know, whether this modification would be correct with you.


Regards
Karl

