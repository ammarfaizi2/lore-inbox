Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUI1MXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUI1MXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1MXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:23:53 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:19716 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S267679AbUI1MXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:23:39 -0400
Date: Tue, 28 Sep 2004 14:23:32 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: James Morris <jmorris@redhat.com>
Cc: Michal Ludvig <michal@logix.cz>, Andreas Happe <crow@old-fsckful.ath.cx>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc2 2/2] cryptoapi: make /proc/crypto optional
Message-ID: <20040928122332.GB21010@final-judgement.ath.cx>
References: <20040927084149.GA3625@final-judgement.ath.cx> <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com> <20040928122117.GA21010@final-judgement.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20040928122117.GA21010@final-judgement.ath.cx>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

creates a new Kconfig entry for the /proc/crypto - file and mark it as
OBSOLETE. This patch is just compile tested and applies after
patch-2.6.9-rc1-cryptoapi-class-2.

Signed-of-by: Andreas Happe <andreashappe@snikt.net>

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.9-rc2-make_proc_crypto_optional-1"

diff -u -r -N linux-2.6.8/crypto/Kconfig linux-sysfs/crypto/Kconfig
--- linux-2.6.8/crypto/Kconfig	2004-09-28 12:50:31.000000000 +0200
+++ linux-sysfs/crypto/Kconfig	2004-09-28 12:18:25.000000000 +0200
@@ -16,6 +16,15 @@
 	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
 	  This is required for IPSec.
 
+config CRYPTO_PROC
+	bool "Legacy /proc/crypto interface (OBSOLETE)"
+	depends on PROC_FS && CRYPTO
+	help
+	  Displays cipher specific information via /proc/crypto.
+	  Please use /sysfs/class/crypto instead.
+
+	  When in double say Y.
+
 config CRYPTO_NULL
 	tristate "Null algorithms"
 	depends on CRYPTO
diff -u -r -N linux-2.6.8/crypto/Makefile linux-sysfs/crypto/Makefile
--- linux-2.6.8/crypto/Makefile	2004-09-28 12:52:40.000000000 +0200
+++ linux-sysfs/crypto/Makefile	2004-09-28 12:14:14.000000000 +0200
@@ -2,7 +2,7 @@
 # Cryptographic API
 #
 
-proc-crypto-$(CONFIG_PROC_FS) = proc.o
+proc-crypto-$(CONFIG_CRYPTO_PROC) = proc.o
 sysfs-crypto-$(CONFIG_SYSFS) = sysfs.o
 
 obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \

--v9Ux+11Zm5mwPlX6--
