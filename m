Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTDEBSZ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDEBSZ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:18:25 -0500
Received: from smtp.tele.fi ([192.89.123.25]:64592 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S261692AbTDEBSY (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:18:24 -0500
Date: Sat, 5 Apr 2003 05:31:16 +0300 (EEST)
From: tchiwam <tchiwam@sgo.fi>
X-X-Sender: tchiwam@is6.invers.fi
To: linux-kernel@vger.kernel.org
Subject: make include/linux/version.h cross compiled
Message-ID: <Pine.LNX.4.44.0304050525450.3622-100000@is6.invers.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

	I have had some troubles trying to compile linux from a platform
that is not using gnu expr (sh-utils) the term "lenght" is not the least
common denominator. If I am not wrong my little patch makes this easier to
cross compiler from foreign arch and should not affect native compiles...

	I leave it to you guys to decide what to do with this. Thank you
for your work.

Philippe Trottier


--- linux-2.4.20/Makefile       Fri Nov 29 01:53:16 2002
+++ linux-2.4.20/Makefile       Fri Apr  4 23:17:10 2003
@@ -347,7 +347,7 @@
        @rm -f .ver1

 include/linux/version.h: ./Makefile
-       @expr length "$(KERNELRELEASE)" \<= $(uts_len) > /dev/null || \
+       @expr `expr "$(KERNELRELEASE)" : '.*'` \<= $(uts_len) > /dev/null
|| \
          (echo KERNELRELEASE \"$(KERNELRELEASE)\" exceeds $(uts_len)
characters >&2; fa
lse)
        @echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
        @echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 +
$(PATCHLEVEL) \\*
 256 + $(SUBLEVEL)` >> .ver


