Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVBQAiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVBQAiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVBQAiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:38:55 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:49360 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262165AbVBQAit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:38:49 -0500
Date: Wed, 16 Feb 2005 19:38:46 -0500
From: Noel Maddy <noel@zhtwn.com>
To: Pedro Venda <pjvenda@arrakis.dhis.org>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
Message-ID: <20050217003846.GA5615@uglybox.localnet>
Reply-To: Noel Maddy <noel@zhtwn.com>
References: <4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net> <4213DF19.10209@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4213DF19.10209@arrakis.dhis.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 12:02:33AM +0000, Pedro Venda wrote:

> admin proc # cat slabinfo
...
> biovec-1           74224  74354     16  226    1 : tunables  120   60    0 : slabdata    329    329      0
> bio                74212  74237     64   61    1 : tunables  120   60    0 : slabdata   1217   1217      0

If you're using md, you need this patch to fix a bio leak:

http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/md/md.c@1.234


Index: ac-dev/drivers/md/md.c
===================================================================
--- ac-dev.orig/drivers/md/md.c	2005-02-07 17:50:37.000000000 -0500
+++ ac-dev/drivers/md/md.c	2005-02-08 17:49:57.000000000 -0500
@@ -336,8 +336,6 @@
 	struct completion event;
 	int ret;
 
-	bio_get(bio);
-
 	rw |= (1 << BIO_RW_SYNC);
 
 	bio->bi_bdev = bdev;
-- 
It's a big galaxy, Mr. Scott.
						    -- Lieutenant Uhura
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Noel Maddy <noel@zhtwn.com>
