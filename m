Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754186AbWKGK6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbWKGK6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbWKGK6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:58:14 -0500
Received: from the-doors.enix.org ([193.19.211.1]:29632 "EHLO
	the-doors.enix.org") by vger.kernel.org with ESMTP id S1754186AbWKGK6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:58:13 -0500
Date: Tue, 7 Nov 2006 11:58:10 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keep the kernel configuration test undisplayed when V=1
Message-ID: <20061107115810.6d6474a1@thomas.toulouse>
X-Mailer: Sylpheed-Claws 2.5.2 (GTK+ 2.8.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the kernel configuration test undisplayed when V=1

While compiling external modules with V=1, during the compilation
process, one can see something such as:

make: Entering directory `/usr/src/linux-2.6.18.2'
test -e include/linux/autoconf.h -a -e include/config/auto.conf || (            \
echo;                                                           \
echo "  ERROR: Kernel configuration is invalid.";               \
echo "         include/linux/autoconf.h or include/config/auto.conf are missing.";      \
echo "         Run 'make oldconfig && make prepare' on kernel src to fix it.";  \
echo;                                                           \
/bin/false)

Such a display is quite misleading: it took me a while to understand
that there was in fact no error: it was just the code that tests for
the error that was displayed.

In order for others to not be annoyed by the same thing, I suggest to
simply remove the $(Q) before the test, and to force it to be prefixed
by @.

The drawback is that it violates the rule saying that V=1 should
display every command executed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@enix.org>

---
 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18.2/Makefile
===================================================================
--- linux-2.6.18.2.orig/Makefile	2006-11-04 02:33:58.000000000 +0100
+++ linux-2.6.18.2/Makefile	2006-11-07 11:52:28.000000000 +0100
@@ -456,7 +456,7 @@
 PHONY += include/config/auto.conf
 
 include/config/auto.conf:
-	$(Q)test -e include/linux/autoconf.h -a -e $@ || (		\
+	@test -a include/linux/autoconf.h -a -e $@ || (                 \
 	echo;								\
 	echo "  ERROR: Kernel configuration is invalid.";		\
 	echo "         include/linux/autoconf.h or $@ are missing.";	\


-- 
Thomas Petazzoni - thomas.petazzoni@enix.org
http://{thomas,sos,kos}.enix.org - http://www.toulibre.org
http://www.{livret,agenda}dulibre.org
