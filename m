Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268419AbTGOPWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbTGOPOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:14:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28329 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S268419AbTGOPFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:05:40 -0400
Date: Tue, 15 Jul 2003 08:20:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 928] New: cryptoloop has unresolved symbols (includes fix)
Message-ID: <239370000.1058282414@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=928

           Summary: cryptoloop has unresolved symbols (includes fix)
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: andy-kernel.388488@dustman.net


Distribution: Gentoo 1.4
Hardware Environment: Athlon-XP, Nvidia NForce2 chipset
Software Environment:
Problem Description:

WARNING: /lib/modules/2.6.0-test1/kernel/drivers/block/cryptoloop.ko needs
unknown symbol crypto_alloc_tfm
WARNING: /lib/modules/2.6.0-test1/kernel/drivers/block/cryptoloop.ko needs
unknown symbol crypto_free_tfm

Steps to reproduce:

CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_CRYPTO is not set

Fix: Obviously CONFIG_CRYPTO should be set. This is due to an error in the
Kconfig. When the following patch is applied, the BLK_DEV_CRYPTOLOOP option will
not appear unless CRYPTO is set, which fixes the unresolved symbol problem
(works with both on or both off):

--- drivers/block/Kconfig.orig  2003-07-14 22:54:19.000000000 -0400
+++ drivers/block/Kconfig       2003-07-15 00:33:33.000000000 -0400
@@ -264,7 +264,7 @@
  
 config BLK_DEV_CRYPTOLOOP
        tristate "Cryptoloop Support"
-       depends on BLK_DEV_LOOP
+       depends on BLK_DEV_LOOP && CRYPTO
        ---help---
          Say Y here if you want to be able to use the ciphers that are
          provided by the CryptoAPI as loop transformation. This might be


