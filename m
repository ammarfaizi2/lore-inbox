Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUKSKHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUKSKHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKSKEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:04:49 -0500
Received: from igel.cyberlink.ch ([62.12.136.3]:40633 "HELO igel.cyberlink.ch")
	by vger.kernel.org with SMTP id S261337AbUKSKD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:03:29 -0500
X-Qmail-Scanner-Mail-From: manfred99@gmx.ch via igel
X-Qmail-Scanner: 1.16 (Clear:. Processed in 0.196347 secs)
From: Manfred Schwarb <manfred99@gmx.ch>
To: chas@cmf.nrl.navy.mil, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Cc: Manfred Schwarb <manfred99@gmx.ch>
Message-Id: <20041119100327.32511.6195.54797@tp-meteodat6.cyberlink.ch>
Subject: [2.4.28] Build Error 2: build of pca200e.bin fails
Date: Fri, 19 Nov 2004 05:03:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, I know I'm stupid...
I always forget to unset my GZIP options, as I have
"export GZIP='-9 -N'" in my .bashrc.

This results in the following:

objcopy -Iihex pca200e.data -Obinary pca200e.bin.gz
gzip -df pca200e.bin.gz
./fore200e_mkfirm -k -b _fore200e_pca_fw \
  -i pca200e.bin -o fore200e_pca_fw.c
./fore200e_mkfirm: can't open pca200e.bin for reading
make[2]: *** [fore200e_pca_fw.c] Error 254
make[2]: Leaving directory `/usr/src/linux-2.4.28/drivers/atm'
make[1]: *** [_modsubdir_atm] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.28/drivers'
make: *** [_mod_drivers] Error 2


The following patch would correct this:

--- linux-2.4.28/drivers/atm/Makefile.orig	2004-11-19 09:33:21.000000000 +0000
+++ linux-2.4.28/drivers/atm/Makefile	2004-11-19 09:38:07.000000000 +0000
@@ -92,7 +92,7 @@
 # deal with the various suffixes of the binary firmware images
 %.bin %.bin1 %.bin2: %.data
 	objcopy -Iihex $< -Obinary $@.gz
-	gzip -df $@.gz
+	gzip -n -df $@.gz
 
 fore_200e.o: $(fore_200e-objs)
 	$(LD) -r -o $@ $(fore_200e-objs)
