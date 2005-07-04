Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVGDP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVGDP75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVGDP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:59:56 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:5346 "EHLO
	luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S261357AbVGDPxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:53:35 -0400
Date: Mon, 4 Jul 2005 11:53:50 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       kbuild-devel@lists.sourceforge.net
Subject: [PATCH]Fix menuconfig error message
Message-ID: <20050704155350.GB2082@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you try to run `make menuconfig' on a system that lacks ncurses
development libs, you get an error message telling you to install
ncurses-devel. Some popular distributions don't have an ncurses-devel
package. This patch generalizes the error message. Patch is against
2.6.12.

This patch fixes a silly typo conflating RPM-based systems with Debian
derivatives and adds the name of the Debian package to install.

MAINTAINERS doesn't list a maintainer for menuconfig or lxdialog,
so I sent this to lkml, kbuild-devel, and to the kconfig maintainer.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>


--- a/scripts/lxdialog/Makefile	2005-07-04 09:54:44.000000000 -0400
+++ b/scripts/lxdialog/Makefile	2005-07-04 11:50:00.000000000 -0400
@@ -35,8 +35,11 @@
 		echo -e "\007" ;\
 		echo ">> Unable to find the Ncurses libraries." ;\
 		echo ">>" ;\
-		echo ">> You must install ncurses-devel in order" ;\
-		echo ">> to use 'make menuconfig'" ;\
+		echo ">> You must install ncurses development libraries" ;\
+		echo ">> to use 'make menuconfig'. If you have an RPM-based" ;\
+		echo ">> distribution you should install the ncurses-devel" ;\
+		echo ">> Debian users will probably want to install the
+		echo ">> libncurses5-dev package." ;\
 		echo ;\
 		exit 1 ;\
 	fi
-- 
Rule of Feline Frustration:
	When your cat has fallen asleep on your lap and looks utterly
content and adorable, you will suddenly have to go to the bathroom.
