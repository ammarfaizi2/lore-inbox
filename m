Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267322AbUBSPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUBSPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:52:59 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:3815 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S267319AbUBSPwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 10:52:34 -0500
Date: Thu, 19 Feb 2004 16:52:33 +0100
From: bert hubert <ahu@ds9a.nl>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [Kconfig documentation patch] dm-crypto && cryptoloop
Message-ID: <20040219155233.GA5300@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current bitkeeper features a cryptoloop which is not safe for journaled file
systems and also a Device Mapper target which is. The patch below updates
Kconfig to that effect.

--- linux-2.6.3/drivers/block/Kconfig.orig	2004-02-19 16:40:05.000000000 +0100
+++ linux-2.6.3/drivers/block/Kconfig	2004-02-19 16:48:14.000000000 +0100
@@ -235,10 +235,13 @@
 	  bits of, say, a sound file). This is also safe if the file resides
 	  on a remote file server.
 
-	  There are several ways of doing this. Some of these require kernel
-	  patches. The vanilla kernel offers the cryptoloop option. If you
-	  want to use that, say Y to both LOOP and CRYPTOLOOP, and make sure
-	  you have a recent (version 2.12 or later) version of util-linux.
+	  There are several ways of encrypting disks. Some of these require
+	  kernel patches. The vanilla kernel offers the cryptoloop option
+	  and a Device Mapper target (which is superior, as it supports all
+	  file systems). If you want to use the cryptoloop, say Y to both
+	  LOOP and CRYPTOLOOP, and make sure you have a recent (version 2.12
+	  or later) version of util-linux. Additionally, be aware that 
+	  the cryptoloop is not safe for storing journaled filesystems.
 
 	  Note that this loop device has nothing to do with the loopback
 	  device used for network connections from the machine to itself.
@@ -257,6 +260,11 @@
 	  provided by the CryptoAPI as loop transformation. This might be
 	  used as hard disk encryption.
 
+	  WARNING: This device is not safe for journaled file systems like
+	  ext3 or Reiserfs. Please use the Device Mapper crypto module
+	  instead, which can be configured to be on-disk compatible with the
+	  cryptoloop device.
+
 config BLK_DEV_NBD
 	tristate "Network block device support"
 	depends on NET


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
