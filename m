Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKIUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKIUux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUKIUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:50:53 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61152 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261669AbUKIUup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:50:45 -0500
Date: Tue, 9 Nov 2004 21:50:39 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] new Solaris partition ID
Message-ID: <20041109205038.GA3423@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun tells me:

  For many years both Solaris x86 and Linux have used the same fdisk
  partition id of 0x82.  Solaris uses that identifier to allocate disk
  space which is then further subdivided by the Solaris VTOC (Volume
  Table of Contents) and Linux uses that id as the identifier for its
  swap partition.

  The new release of Solaris should be out early next year. Solaris
  will begin using a partition id of 0xbf.  We will continue to support
  the older partition id value of 0x82 for compatibility reasons.

  Solaris's fdisk program has been enhanced to allow system administrators
  to switch back and forth between the new and old identifier without any
  loss of data.

So, the patch below may be useful to some people a few months from now.

Andries

diff -uprN -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	2004-10-30 21:44:02.000000000 +0200
+++ b/fs/partitions/msdos.c	2004-11-09 21:43:17.000000000 +0100
@@ -374,6 +374,7 @@ static struct {
 	{MINIX_PARTITION, parse_minix},
 	{UNIXWARE_PARTITION, parse_unixware},
 	{SOLARIS_X86_PARTITION, parse_solaris_x86},
+	{NEW_SOLARIS_X86_PARTITION, parse_solaris_x86},
 	{0, NULL},
 };
  
diff -uprN -X /linux/dontdiff a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	2004-10-30 21:44:05.000000000 +0200
+++ b/include/linux/genhd.h	2004-11-09 21:44:58.000000000 +0100
@@ -28,6 +28,7 @@ enum {
 	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
 
 	SOLARIS_X86_PARTITION =	LINUX_SWAP_PARTITION,
+	NEW_SOLARIS_X86_PARTITION = 0xbf,
 
 	DM6_AUX1PARTITION = 0x51,	/* no DDO:  use xlated geom */
 	DM6_AUX3PARTITION = 0x53,	/* no DDO:  use xlated geom */
