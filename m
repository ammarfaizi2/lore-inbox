Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUCOFTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCOFTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:19:19 -0500
Received: from cmail.srv.hcvlny.cv.net ([167.206.112.40]:30899 "EHLO
	cmail.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262259AbUCOFTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:19:16 -0500
Date: Mon, 15 Mar 2004 00:19:08 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] MAC_PARTITION not enabled for PowerMac by default
X-X-Sender: proski@portland.hansa.lan
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.58.0403150002350.27719@portland.hansa.lan>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_0k0kf4s/1B4V94qM4fHyTg)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_0k0kf4s/1B4V94qM4fHyTg)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello!

One should not have to enable CONFIG_PARTITION_ADVANCED just to get Mac
partition support on Power Macintosh, especially considering the
description of the option:

"Say Y here if you would like to use hard disks under Linux which
were partitioned under an operating system running on a different
architecture than your Linux system."

CONFIG_MAC is only defined for m68k systems.  Power Macintosh uses
CONFIG_PPC_PMAC.  Both m68k and PowerMacs use the same partition tables.

I left another occurrence of lone "MAC" unchanged, so after the patch,
unselecting CONFIG_PARTITION_ADVANCED for PowerMac enables Mac and MS-DOS
partitions.  The reason is that MacOS 9 (and almost certainly MacOS X)
allow formatting Zip drives in "DOS format", which means creating an
MS-DOS partition.  We want Linux running on the same architecture to read
those disks.

-- 
Regards,
Pavel Roskin

--Boundary_(ID_0k0kf4s/1B4V94qM4fHyTg)
Content-id: <Pine.LNX.4.58.0403150019080.27719@portland.hansa.lan>
Content-type: TEXT/plain; charset=US-ASCII; name=mac_partition.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=mac_partition.diff
Content-description: 

--- linux.orig/fs/partitions/Kconfig
+++ linux/fs/partitions/Kconfig
@@ -93,7 +93,7 @@
 
 config MAC_PARTITION
 	bool "Macintosh partition map support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && MAC
+	default y if !PARTITION_ADVANCED && (MAC || PPC_PMAC)
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on a Macintosh.

--Boundary_(ID_0k0kf4s/1B4V94qM4fHyTg)--
