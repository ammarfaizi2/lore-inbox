Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272543AbRH3Xv7>; Thu, 30 Aug 2001 19:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272545AbRH3Xvu>; Thu, 30 Aug 2001 19:51:50 -0400
Received: from front2.grolier.fr ([194.158.96.52]:55486 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S272543AbRH3Xvd>; Thu, 30 Aug 2001 19:51:33 -0400
Message-ID: <3B8ECEFD.DBA622C4@club-internet.fr>
Date: Fri, 31 Aug 2001 01:40:45 +0200
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] modversions.h can be wrong.
Content-Type: multipart/mixed;
 boundary="------------57A97209D15E564B8F8C7C90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------57A97209D15E564B8F8C7C90
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Linus, Alan,

	Can you apply this patch, it fix a problem with modversions.h
generation. 

If you turn on module version information, doing make dep, everything 
is OK, but if you turn off this feature after, doing a make dep again,
modversions.h isn't regenerated, so all version information header files
are included.

Cheers.
-- 
73's de Daniel, F1RMB.

              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
                        -=- f1rmb@f1rmb.ampr.org (AMPR NET) -=-
--------------57A97209D15E564B8F8C7C90
Content-Type: text/plain; charset=us-ascii;
 name="Rules.make.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Rules.make.diff"

--- linux-2.4.9-ac4.vanilla/Rules.make	Sat May 26 16:32:54 2001
+++ linux-2.4.9-ac4/Rules.make	Fri Aug 31 01:39:45 2001
@@ -122,7 +122,7 @@
 #
 # This make dependencies quickly
 #
-fastdep: dummy
+fastdep: $(TOPDIR)/include/linux/modversions.h
 	$(TOPDIR)/scripts/mkdep $(CFLAGS) $(EXTRA_CFLAGS) -- $(wildcard *.[chS]) > .depend
 ifdef ALL_SUB_DIRS
 	$(MAKE) $(patsubst %,_sfdep_%,$(ALL_SUB_DIRS)) _FASTDEP_ALL_SUB_DIRS="$(ALL_SUB_DIRS)"
@@ -263,7 +263,7 @@
 
 else
 
-$(TOPDIR)/include/linux/modversions.h:
+$(TOPDIR)/include/linux/modversions.h: dummy
 	@echo "#include <linux/modsetver.h>" > $@
 
 endif # CONFIG_MODVERSIONS

--------------57A97209D15E564B8F8C7C90--


