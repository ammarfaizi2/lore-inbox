Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVBXLOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVBXLOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVBXLLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:11:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46353 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262226AbVBXLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:11:16 -0500
Date: Thu, 24 Feb 2005 12:11:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/md/dm-hw-handler.c: fix compile warnings
Message-ID: <20050224111115.GG8651@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:42:33AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc3-mm1:
>...
> +device-mapper-multipath-hardware-handler.patch
>...
>  More DM updates
>... 

This causes the following compile warnings:

<--  snip  -->

...
  CC      drivers/md/dm-hw-handler.o
drivers/md/dm-hw-handler.c: In function `dm_scsi_err_handler':
drivers/md/dm-hw-handler.c:154: warning: unused variable `sense_key'
drivers/md/dm-hw-handler.c:154: warning: unused variable `asc'
drivers/md/dm-hw-handler.c:154: warning: unused variable `ascq'
...

<--  snip  -->


Trivial fix:


<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc4-mm1-full/drivers/md/dm-hw-handler.c.old	2005-02-24 01:59:45.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/md/dm-hw-handler.c	2005-02-24 02:00:05.000000000 +0100
@@ -151,9 +151,9 @@
 
 unsigned dm_scsi_err_handler(struct hw_handler *hwh, struct bio *bio)
 {
+#if 0
 	int sense_key, asc, ascq;
 
-#if 0
 	if (bio->bi_error & BIO_SENSE) {
 		/* FIXME: This is just an initial guess. */
 		/* key / asc / ascq */

