Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTBXSim>; Mon, 24 Feb 2003 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbTBXSh3>; Mon, 24 Feb 2003 13:37:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267649AbTBXShK>;
	Mon, 24 Feb 2003 13:37:10 -0500
Date: Mon, 24 Feb 2003 10:43:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.5.62 ide/pci/piix with CONFIG_PROC_FS=n
Message-Id: <20030224104307.53e09d78.rddunlap@osdl.org>
In-Reply-To: <34369.4.64.238.61.1045972018.squirrel@www.osdl.org>
References: <34369.4.64.238.61.1045972018.squirrel@www.osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 19:46:58 -0800 (PST)
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

| I haven't seen this reported, but maybe I just missed it.
| 
| drivers/ide/pci/piix.c: In function `piix_config_drive_for_dma':
| drivers/ide/pci/piix.c:530: `no_piix_dma' undeclared (first use in this function)
| drivers/ide/pci/piix.c:530: (Each undeclared identifier is reported only once
| drivers/ide/pci/piix.c:530: for each function it appears in.)
| drivers/ide/pci/piix.c: In function `piix_check_450nx':
| drivers/ide/pci/piix.c:770: `no_piix_dma' undeclared (first use in this function)


Here's a patch to build ide/pci/piix.c with CONFIG_PROC_FS=n.


patch_name:	piixdata-2562.patch
patch_version:	2003-02-24.10:29:21
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	enable drivers/ide/pci/piix.c to compile with CONFIG_PROC_FS=n
product:	Linux
product_versions: linux-2.5.62
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 drivers/ide/pci/piix.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./drivers/ide/pci/piix.c%PIIX ./drivers/ide/pci/piix.c
--- ./drivers/ide/pci/piix.c%PIIX	Mon Feb 24 10:16:27 2003
+++ ./drivers/ide/pci/piix.c	Mon Feb 24 10:27:30 2003
@@ -106,6 +106,7 @@
 #include "ide_modes.h"
 #include "piix.h"
 
+static int no_piix_dma;
 #if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -114,7 +115,6 @@
 #define PIIX_MAX_DEVS		5
 static struct pci_dev *piix_devs[PIIX_MAX_DEVS];
 static int n_piix_devs;
-static int no_piix_dma = 0;
 
 /**
  *	piix_get_info		-	fill in /proc for PIIX ide


--
~Randy
