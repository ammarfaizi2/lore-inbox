Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUL0XA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUL0XA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUL0XA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:00:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29700 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261999AbUL0W64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:58:56 -0500
Date: Mon, 27 Dec 2004 23:58:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "prem.de.ms" <prem.de.ms@gmx.de>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: [2.6 patch] let VIDEO_CX88 select FW_LOADER
Message-ID: <20041227225854.GG5345@stusta.de>
References: <41D08611.9000004@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D08611.9000004@gmx.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 11:00:49PM +0100, prem.de.ms wrote:

> Hello,
> 
> I get the following error message when I try to compile the new 
> 2.6.10-kernel:
> 
> [...]
> CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x8a3b2): In function `blackbird_load_firmware':
> : undefined reference to `request_firmware'
> drivers/built-in.o(.text+0x8a454): In function `blackbird_load_firmware':
> : undefined reference to `release_firmware'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Seems like the Conexant drivers are broken because the kernel compiles 
> when I uncheck them.
> 
> Any suggestions?


Thanks for this report.

The patch below should fix it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/media/video/Kconfig.old	2004-12-27 23:53:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/media/video/Kconfig	2004-12-27 23:54:09.000000000 +0100
@@ -304,8 +304,9 @@
 config VIDEO_CX88
 	tristate "Conexant 2388x (bt878 successor) support"
 	depends on VIDEO_DEV && PCI && EXPERIMENTAL
 	select I2C_ALGOBIT
+	select FW_LOADER
 	select VIDEO_BTCX
 	select VIDEO_BUF
 	select VIDEO_TUNER
 	---help---

