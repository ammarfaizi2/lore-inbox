Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTJTVUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJTVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:20:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20185 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262594AbTJTVUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:20:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dale Amon <amon@vnl.com>
Subject: Re: CMD640 problem in 2.6.0-test8
Date: Mon, 20 Oct 2003 20:56:42 +0200
User-Agent: KMail/1.5.4
References: <20031020172733.GA17379@vnl.com>
In-Reply-To: <20031020172733.GA17379@vnl.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310202056.42759.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 20 of October 2003 19:27, Dale Amon wrote:
> I'm seeing these compile errors:
>
> 	LD      .tmp_vmlinux1
>
> 	drivers/built-in.o(.init.text+0x4e6b): In function `ide_setup':
> 	: undefined reference to `cmd640_vlb'
>
> 	drivers/built-in.o(.init.text+0x5361): In function `probe_for_hwifs':
> 	: undefined reference to `ide_probe_for_cmd640x'
>
> 	make: *** [.tmp_vmlinux1] Error 1
>
> The .config contains:
>
> 	CONFIG_BLK_DEV_CMD640=y
>
> but ide/pci/cmd640.c doesn't seem to get compiled. I tried doing it
> manually and got a screen full of errors.

this patch should fix it,
--bartlomiej

[IDE] fix drivers/ide/pci/cmd640.c for CONFIG_PCI=n

CMD640 driver also supports VLB version of the chipset, therefore fix
drivers/ide/Makefile to include pci/ subdir even if CONFIG_BLK_DEV_IDEPCI=n.

 drivers/ide/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/Makefile~ide-cmd640-no_pci-fix drivers/ide/Makefile
--- linux-2.6.0-test8/drivers/ide/Makefile~ide-cmd640-no_pci-fix	2003-10-20 20:47:03.701132024 +0200
+++ linux-2.6.0-test8-root/drivers/ide/Makefile	2003-10-20 20:47:17.280067712 +0200
@@ -8,7 +8,7 @@
 # In the future, some of these should be built conditionally.
 #
 # First come modules that register themselves with the core
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= pci/
+obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
 
 # Core IDE code - must come before legacy
 

_

