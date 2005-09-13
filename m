Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVIMLwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVIMLwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVIMLwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:52:37 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:1160 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932614AbVIMLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:52:37 -0400
Message-ID: <3974.192.168.6.50.1126612308.squirrel@simlinux>
Date: Tue, 13 Sep 2005 13:51:48 +0200 (CEST)
Subject: [patch 2.6.14-rc1] i386: Correct Pentium optimization
From: simrw@sim-basis.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050913135148_72863"
X-Priority: 3 (Normal)
Importance: Normal
X-SIMBasis-MailScanner-Information: Please contact the ISP for more information
X-SIMBasis-MailScanner: Found to be clean
X-SIMBasis-MailScanner-From: simrw@sim-basis.de
X-ID: VrMRYcZcreHDSHZz-auTnXIKztNad2PqRdizAmbGMEaVmMGOwfwLZ0@t-dialin.net
X-TOI-MSGID: f33dabe8-a768-49c6-8b30-9200828c7031
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050913135148_72863
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

GCC 3.x apparently does not allow the -mtune option when specifying
-march=i686. This means that P-2/3/4/M never get optimzed.
Change the i386 Makefile to cater for this.

Signed-off-by: Roger While <simrw@sim-basis.de>

Patch also as attachment as Squirrel is sure to mangle.

Roger While

diff -Naur linux-2.6.14/arch/i386/Makefile
linux-2.6.14patch/arch/i386/Makefile
--- linux-2.6.14/arch/i386/Makefile     2005-09-13 13:16:22.000000000 +0200
+++ linux-2.6.14patch/arch/i386/Makefile        2005-09-13
13:11:47.000000000 +0200
@@ -41,10 +41,10 @@
 cflags-$(CONFIG_M586TSC)       += -march=i586
 cflags-$(CONFIG_M586MMX)       += $(call
cc-option,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)          += -march=i686
-cflags-$(CONFIG_MPENTIUMII)    += -march=i686 $(call
cc-option,-mtune=pentium2)
-cflags-$(CONFIG_MPENTIUMIII)   += -march=i686 $(call
cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUMM)     += -march=i686 $(call
cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUM4)     += -march=i686 $(call
cc-option,-mtune=pentium4)
+cflags-$(CONFIG_MPENTIUMII)    += $(call
cc-option,-march=pentium2,-march=i686)
+cflags-$(CONFIG_MPENTIUMIII)   += $(call
cc-option,-march=pentium3,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)     += $(call
cc-option,-march=pentium-m,-march=i686)
+cflags-$(CONFIG_MPENTIUM4)     += $(call
cc-option,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)           += -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are
pointless.
 # They make zero difference whatsosever to performance at this time.
------=_20050913135148_72863
Content-Type: text/plain; name="pentiumgcc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pentiumgcc.patch"

diff -Naur linux-2.6.14/arch/i386/Makefile linux-2.6.14patch/arch/i386/Makefile
--- linux-2.6.14/arch/i386/Makefile	2005-09-13 13:16:22.000000000 +0200
+++ linux-2.6.14patch/arch/i386/Makefile	2005-09-13 13:11:47.000000000 +0200
@@ -41,10 +41,10 @@
 cflags-$(CONFIG_M586TSC)	+= -march=i586
 cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
-cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
+cflags-$(CONFIG_MPENTIUMII)	+= $(call cc-option,-march=pentium2,-march=i686)
+cflags-$(CONFIG_MPENTIUMIII)	+= $(call cc-option,-march=pentium3,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)	+= $(call cc-option,-march=pentium-m,-march=i686)
+cflags-$(CONFIG_MPENTIUM4)	+= $(call cc-option,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
------=_20050913135148_72863--


