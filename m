Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131584AbRCQLDa>; Sat, 17 Mar 2001 06:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131599AbRCQLDV>; Sat, 17 Mar 2001 06:03:21 -0500
Received: from diup-10-48.inter.net.il ([213.8.10.48]:5124 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S131584AbRCQLDC>;
	Sat, 17 Mar 2001 06:03:02 -0500
Date: Sat, 17 Mar 2001 13:01:39 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] fs/nls/Makefile - fix a dependency problem
Message-ID: <Pine.LNX.4.32.0103171242300.984-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem:
  When both nls_iso8859_8 and nls_cp1255 are compiled into the kernel
  (=Y), init_nls_iso8859_8() is called before init_nls_cp1255() - this
  causes iso_8859_8 to call request_module() which obviously fails.

Kernel log: (from dmesg + traces I added)
  TRACE: init_nls_iso8859_8()
  request_module[nls_cp1255]: Root fs not mounted
  Unable to load NLS charset cp1255
  TRACE: init_nls_cp1255()

The fix: (changing the link order of the two modules)

--- linux-2.4.2-ac20/fs/nls/Makefile	Sat Mar  3 16:13:21 2001
+++ linux-2.4.2-ac20/fs/nls/Makefile	Sat Mar 17 12:39:28 2001
@@ -42,7 +42,7 @@
 obj-$(CONFIG_NLS_ISO8859_5)	+= nls_iso8859-5.o
 obj-$(CONFIG_NLS_ISO8859_6)	+= nls_iso8859-6.o
 obj-$(CONFIG_NLS_ISO8859_7)	+= nls_iso8859-7.o
-obj-$(CONFIG_NLS_ISO8859_8)	+= nls_iso8859-8.o nls_cp1255.o
+obj-$(CONFIG_NLS_ISO8859_8)	+= nls_cp1255.o nls_iso8859-8.o
 obj-$(CONFIG_NLS_ISO8859_9)	+= nls_iso8859-9.o
 obj-$(CONFIG_NLS_ISO8859_10)	+= nls_iso8859-10.o
 obj-$(CONFIG_NLS_ISO8859_13)	+= nls_iso8859-13.o

--
Dan Aloni
dax@karrde.org

