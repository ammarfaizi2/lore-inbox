Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTEZNql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264381AbTEZNql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:46:41 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:39690 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S264380AbTEZNqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:46:39 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200305261400.h4QE00JF009630@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.21-rc3
To: linux-kernel@vger.kernel.org (kernel list), manty@manty.net
Date: Mon, 26 May 2003 16:00:00 +0200 (CEST)
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk (Alan Cox)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been around the 2.4.21 pre series for quite some time, I thought it
was known, but as it has not yet been fixed, I'm doubting it.

If you try to compile ide as modules you get unresolved symbols:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
depmod:         ide_remove_proc_entries
[...]

The following short patch should fix this problem
(AFAIK, also not fixed in -ac tree)
****************************************************
--- linux-2.4.21-rc3/drivers/ide/Makefile~	Mon May 26 14:02:47 2003
+++ linux-2.4.21-rc3/drivers/ide/Makefile	Mon May 26 15:49:27 2003
@@ -44,8 +44,8 @@
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
+ifeq ($(CONFIG_PROC_FS),y)
+obj-$(CONFIG_BLK_DEV_IDE)			+= ide-proc.o
 endif
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
