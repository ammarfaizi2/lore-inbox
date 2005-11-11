Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKKNON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKKNON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVKKNON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:14:13 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:42713 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750729AbVKKNOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:14:12 -0500
X-ORBL: [67.120.235.193]
Message-ID: <43749921.2010603@pacbell.net>
Date: Fri, 11 Nov 2005 05:14:09 -0800
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zippel@linux-m68k.org
Subject: [PATCH] kconfig: Makefile xconfig problem: qconf libs/cflags error
Content-Type: multipart/mixed;
 boundary="------------090608080206050805020803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090608080206050805020803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

$make xconfig generates this error on the last couple kernels: 
(2.6.14-git14, git13)

make xconfig
   HOSTCXX scripts/kconfig/qconf.o
   HOSTLD  scripts/kconfig/qconf
/usr/bin/ld: cannot find -l-ldl
collect2: ld returned 1 exit status
make[1]: *** [scripts/kconfig/qconf] Error 1
make: *** [xconfig] Error 2


The actual problem may be at another level, since I don't see a 
difference between the scripts/kconfig/Makefile & prior ones that work, 
but this patch seems in line with other targets that work and used the 
standard pkg-config --libs --cflags setup.

Signed-off-by: Mickey Stein <yekkim@pacbell.net>

---



--------------090608080206050805020803
Content-Type: text/x-patch;
 name="qconf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qconf.patch"

--- linux-2.6.14-git14/scripts/kconfig/Makefile.orig.xx	2005-11-11 04:10:34.000000000 -0800
+++ linux-2.6.14-git14/scripts/kconfig/Makefile	2005-11-11 04:11:44.000000000 -0800
@@ -129,8 +129,8 @@
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(LIBS_QT) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
+HOSTLOADLIBES_qconf	= `pkg-config qt-mt  --libs` 
+HOSTCXXFLAGS_qconf.o	= `pkg-config qt-mt  --cflags` -D LKC_DIRECT_LINK
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \

--------------090608080206050805020803--
