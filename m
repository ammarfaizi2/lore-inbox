Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUEYUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUEYUaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUEYUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:30:11 -0400
Received: from [82.228.82.76] ([82.228.82.76]:28915 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S265198AbUEYUaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:30:03 -0400
Date: Tue, 25 May 2004 22:29:29 +0200
From: Colin Leroy <colin@colino.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2.6.7-rc1) ADB driver fails to create /dev/adb
Message-Id: <20040525222929.4e31cc19@jack.colino.net>
In-Reply-To: <20040525214504.377f3f12@jack.colino.net>
References: <20040525214504.377f3f12@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__25_May_2004_22_29_29_+0200_NxIpzT8AvMLXxGq2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__25_May_2004_22_29_29_+0200_NxIpzT8AvMLXxGq2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 25 May 2004 at 21h05, Colin Leroy wrote:

Hi, 

> Here's a patch that restores previous behaviour. (I bothered because I
> noticed lots of other drivers still using devfs_mk_cdev() and I think
> it should stay here for a bit more).

Mmh, here's a nicer patch (forgot a return, and the else isn't the most
clear).

-- 
Colin

--Multipart=_Tue__25_May_2004_22_29_29_+0200_NxIpzT8AvMLXxGq2
Content-Type: text/plain;
 name="adb.c.patch"
Content-Disposition: attachment;
 filename="adb.c.patch"
Content-Transfer-Encoding: 7bit

--- drivers/macintosh/adb.c.orig	2004-05-25 21:08:10.000000000 +0200
+++ drivers/macintosh/adb.c	2004-05-25 22:27:04.596656712 +0200
@@ -899,6 +899,11 @@
 	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
 		printk(KERN_ERR "adb: unable to get major %d\n", ADB_MAJOR);
 		return;
+	} 
+	if (devfs_mk_cdev(MKDEV(ADB_MAJOR, 0),
+				 S_IFCHR | S_IRUSR | S_IWUSR, "adb")) {
+		printk(KERN_ERR "adb: unable to make dev via devfs\n");
+		return;
 	}
 	adb_dev_class = class_simple_create(THIS_MODULE, "adb");
 	if (IS_ERR(adb_dev_class)) {

--Multipart=_Tue__25_May_2004_22_29_29_+0200_NxIpzT8AvMLXxGq2--
