Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145382AbRA2GfL>; Mon, 29 Jan 2001 01:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145383AbRA2GfC>; Mon, 29 Jan 2001 01:35:02 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:58120 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S145382AbRA2Ge4>; Mon, 29 Jan 2001 01:34:56 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: [patch] 2.4.1-pre11 remove pcmcia compatibility from Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jan 2001 17:34:36 +1100
Message-ID: <15690.980750076@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The _modinst_post_pcmcia target was added to Makefile in 2.4.0-test6-pre3,
August 5 2000.  It was a compatibility aid until people upgraded to a
version of pcmcia-cs that used modprobe instead of insmod.  Five months
later, it is time to remove _modinst_post_pcmcia.

Linus, please apply at any convenient time, no hurry.


Index: 1-pre11.1/Makefile
--- 1-pre11.1/Makefile Mon, 29 Jan 2001 10:00:50 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.10 644)
+++ 1-pre11.1(w)/Makefile Mon, 29 Jan 2001 17:10:07 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.10 644)
@@ -372,17 +372,8 @@ else
 depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
 .PHONY: _modinst_post
-_modinst_post: _modinst_post_pcmcia
+_modinst_post:
 	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
-
-# Backwards compatibilty symlinks for people still using old versions
-# of pcmcia-cs with hard coded pathnames on insmod.  Remove
-# _modinst_post_pcmcia for kernel 2.4.1.
-.PHONY: _modinst_post_pcmcia
-_modinst_post_pcmcia:
-	cd $(MODLIB); \
-	mkdir -p pcmcia; \
-	find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
 
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
