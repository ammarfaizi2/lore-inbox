Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUKDAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUKDAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUKDAlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:41:24 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:64991 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262022AbUKDAjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:39:04 -0500
Date: Thu, 4 Nov 2004 01:39:00 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.9-ac6 ide-disk.ko undefined symbols
Message-ID: <20041104003900.GA20525@louise.pinerecords.com>
References: <1099314945.18809.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099314945.18809.66.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-01 2004, Mon, 13:15 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> 2.6.9-ac6

*** Warning: "ide_drive_from_key" [drivers/ide/ide-disk.ko] undefined!
*** Warning: "ide_cfg_sem" [drivers/ide/ide-disk.ko] undefined!

This problem does not exist in vanilla 2.6.9.
Trivial fix follows -- tested, seems to work.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-11-04 01:26:11.000000000 +0100
+++ b/drivers/ide/ide.c	2004-11-04 01:25:28.000000000 +0100
@@ -175,6 +175,7 @@
 static int initializing;	/* set while initializing built-in drivers */
 
 DECLARE_MUTEX(ide_cfg_sem);
+EXPORT_SYMBOL(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -349,6 +350,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(ide_drive_from_key);
+
 /*
  *	ide_drive_to_key	-	turn drive to persistent key
  *	@drive: drive to use
