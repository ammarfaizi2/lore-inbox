Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSE2UiG>; Wed, 29 May 2002 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSE2UiE>; Wed, 29 May 2002 16:38:04 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58266
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315463AbSE2UiB>; Wed, 29 May 2002 16:38:01 -0400
Date: Wed, 29 May 2002 13:37:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Missing include in drivers/base/bus.c and drivers/pci/pci-driver.c
Message-ID: <20020529203758.GT5997@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/bus.c and drivers/pci/pci-driver.c both have functions
which are marked with __init, but didn't include <linux/init.h> directly.
The following fixes that (and allows 2.5.19 to compile on PPC32).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/base/bus.c 1.4 vs edited =====
--- 1.4/drivers/base/bus.c	Tue May 28 11:35:01 2002
+++ edited/drivers/base/bus.c	Wed May 29 13:30:05 2002
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/stat.h>
+#include <linux/init.h>
 #include "base.h"
 
 static LIST_HEAD(bus_driver_list);
===== drivers/pci/pci-driver.c 1.5 vs edited =====
--- 1.5/drivers/pci/pci-driver.c	Tue May 28 18:02:33 2002
+++ edited/drivers/pci/pci-driver.c	Wed May 29 13:32:06 2002
@@ -5,6 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/init.h>
 
 /*
  *  Registration of PCI drivers and handling of hot-pluggable devices.
