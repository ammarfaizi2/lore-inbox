Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSEYNOf>; Sat, 25 May 2002 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314554AbSEYNOe>; Sat, 25 May 2002 09:14:34 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:4992 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S314553AbSEYNOc>; Sat, 25 May 2002 09:14:32 -0400
Message-ID: <3CEF8CCE.3740447A@cinet.co.jp>
Date: Sat, 25 May 2002 22:08:30 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.5.18-pc98smp i686)
X-Accept-Language: ja, en-US, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18 compilation failure ide_scsi
In-Reply-To: <Pine.LNX.4.44.0205250031570.7716-100000@k2-400.lameter.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> drivers/ide/idedriver.o: In function `ata_module_init':
> drivers/ide/idedriver.o(.text.init+0xa5f): undefined reference to
> `idescsi_init'make: *** [vmlinux] Error 1
I have had a same problem.
Try this patch.

--- linux-2.5.18/drivers/scsi/ide-scsi.c.orig	Sat May 25 10:55:17 2002
+++ linux-2.5.18/drivers/scsi/ide-scsi.c	Sat May 25 21:18:55 2002
@@ -804,7 +804,12 @@
 };
 
 
-static int __init idescsi_init(void)
+int idescsi_init(void)
+{
+	return ata_driver_module(&idescsi_driver);
+}
+
+static int __init init_idescsi_module(void)
 {
 	int ret;
 	ret = ata_driver_module(&idescsi_driver);
@@ -828,6 +833,6 @@
 	unregister_ata_driver(&idescsi_driver);
 }
 
-module_init(idescsi_init);
+module_init(init_idescsi_module);
 module_exit(exit_idescsi_module);
 MODULE_LICENSE("GPL");
