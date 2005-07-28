Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVG1R2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVG1R2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVG1R0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:26:14 -0400
Received: from [151.97.230.9] ([151.97.230.9]:55974 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261724AbVG1RZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:25:19 -0400
Subject: [patch 1/1] uml: avoid unnecessary pcap rebuild
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 18:05:55 +0200
Message-Id: <20050728160555.EA9C23EF@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a Kbuild subtlety, not listing a target file inside targets causes it to
be rebuilt each time, and as a consequence everything depending on it is
rebuilt.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/Makefile~uml-avoid-rebuild arch/um/drivers/Makefile
--- linux-2.6.git/arch/um/drivers/Makefile~uml-avoid-rebuild	2005-07-28 18:05:35.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/Makefile	2005-07-28 18:05:35.000000000 +0200
@@ -19,6 +19,8 @@ harddog-objs := harddog_kern.o harddog_u
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
 
+targets := pcap_kern.o pcap_user.o
+
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
 	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
 #XXX: The call below does not work because the flags are added before the
@@ -26,7 +28,7 @@ $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)
 #$(call if_changed,ld)
 
 # When the above is fixed, don't forget to add this too!
-#targets := $(obj)/pcap.o
+#targets += $(obj)/pcap.o
 
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
_
