Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWAZWXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWAZWXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWAZWXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:23:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932359AbWAZWXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:23:52 -0500
Date: Thu, 26 Jan 2006 23:23:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC: -mm patch] drivers/serial/jsm/: cleanups
Message-ID: <20060126222345.GB3668@stusta.de>
References: <20060124232406.50abccd1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:24:06PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm2:
>...
> +jsm-update-for-tty-buffering-revamp.patch
>...
>  Misc.
>...


This patch contains the following cleanups:
- jsm_driver.c: remove the now unused jsm_rawreadok module_param
- jsm_tty.c: remove a now unused variable

Is there any problem with removing the now useless jsm_rawreadok 
module_param?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/serial/jsm/jsm.h        |    1 -
 drivers/serial/jsm/jsm_driver.c |    3 ---
 drivers/serial/jsm/jsm_tty.c    |    1 -
 3 files changed, 5 deletions(-)

--- linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm.h.old	2006-01-25 23:15:38.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm.h	2006-01-25 23:15:43.000000000 +0100
@@ -380,7 +380,6 @@
 extern struct	uart_driver jsm_uart_driver;
 extern struct	board_ops jsm_neo_ops;
 extern int	jsm_debug;
-extern int	jsm_rawreadok;
 
 /*************************************************************************
  *
--- linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm_driver.c.old	2006-01-25 23:15:51.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm_driver.c	2006-01-25 23:15:57.000000000 +0100
@@ -49,11 +49,8 @@
 };
 
 int jsm_debug;
-int jsm_rawreadok;
 module_param(jsm_debug, int, 0);
-module_param(jsm_rawreadok, int, 0);
 MODULE_PARM_DESC(jsm_debug, "Driver debugging level");
-MODULE_PARM_DESC(jsm_rawreadok, "Bypass flip buffers on input");
 
 static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
--- linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm_tty.c.old	2006-01-25 23:19:13.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/serial/jsm/jsm_tty.c	2006-01-25 23:19:35.000000000 +0100
@@ -512,7 +512,6 @@
 	int flip_len = 0;
 	int len = 0;
 	int n = 0;
-	char *buf = NULL;
 	int s = 0;
 	int i = 0;
 

