Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSIJU7G>; Tue, 10 Sep 2002 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSIJU7F>; Tue, 10 Sep 2002 16:59:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:65288 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318123AbSIJU7E>;
	Tue, 10 Sep 2002 16:59:04 -0400
Date: Tue, 10 Sep 2002 23:03:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] atm: List files to be deleted during clean and mrproper 2/6
Message-ID: <20020910230344.B18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atm makefile updated

	Sam

diff -Nru a/drivers/atm/Makefile b/drivers/atm/Makefile
--- a/drivers/atm/Makefile	Tue Sep 10 22:37:43 2002
+++ b/drivers/atm/Makefile	Tue Sep 10 22:37:43 2002
@@ -58,6 +58,12 @@
 
 EXTRA_CFLAGS := -g
 
+# Files generated that shall be removed upon make clean
+clean := {atmsar11,pca200e,pca200e_ecd,sba200e_ecd}.{bin,bin1,bin2} 
+
+# Firmware generated that shall be removed upon make mrproper
+mrproper := fore200e_pca_fw.c fore200e_sba_fw.c
+
 include $(TOPDIR)/Rules.make
 
 # FORE Systems 200E-series firmware magic
@@ -72,6 +78,6 @@
 	  -i $(CONFIG_ATM_FORE200E_SBA_FW) -o $@
 
 # deal with the various suffixes of the binary firmware images
-$(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(obj)/%.data
+$(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data
 	objcopy -Iihex $< -Obinary $@.gz
 	gzip -df $@.gz
