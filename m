Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbTIDSbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTIDSbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:31:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:2528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265442AbTIDSbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:31:48 -0400
Date: Thu, 4 Sep 2003 11:31:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ikconfig - resolve rebuild permissions
Message-Id: <20030904113133.3f950a51.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ikconfig is enabled then the following annoying permission
problem happens.
 $ make 
 $ su
 #  make install
 $ make

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  CC      kernel/configs.o
mv: overwrite `kernel/configs.o', overriding mode 0644? 

This patch fixes it by removing the configs.o file when
needed.

It applies against 2.6.0-test4 but is also needed even with the
ikconfig patch already in -mm5

diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Thu Sep  4 10:33:49 2003
+++ b/kernel/Makefile	Thu Sep  4 10:33:49 2003
@@ -36,5 +36,6 @@
 
 $(obj)/ikconfig.h: scripts/mkconfigs .config Makefile FORCE
 	$(call if_changed,ikconfig)
+	@rm -f $(obj)/configs.o
 
 $(obj)/configs.o: $(obj)/ikconfig.h

