Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWH0RG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWH0RG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWH0RG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:06:29 -0400
Received: from xenotime.net ([66.160.160.81]:32685 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932186AbWH0RG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:06:28 -0400
Date: Sun, 27 Aug 2006 10:09:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: HPA Resume patch
Message-Id: <20060827100942.ef1c06c6.rdunlap@xenotime.net>
In-Reply-To: <44F15ADB.5040609@PicturesInMotion.net>
References: <44F15ADB.5040609@PicturesInMotion.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 04:42:03 -0400 Lee Trager wrote:

> This patch fixes a problem with computers that have HPA on their hard
> drive and not being able to come out of resume from RAM or disk. I've
> tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
> of these. This patch also fixes the bug #6840. This is my first patch to
> the kernel and I was told to e-mail the above people to get my patch
> into the kernel. If I made a mistake please be gentle and correct me ;)

Please use inline patches if your mail system supports/allows it.
Attachments make it difficult to review a patch.
(now do some cp-n-paste for comments)

+/* Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
+*/

Long comment style in Linux is:
/*
 * foo bar
 * comments
 */

+static inline int idedisk_supports_hpa(const struct hd_driveid *id)
+{
+        return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+}

Please use a #defined value for the 0x400.
(Yes, you just moved it from somewhere else.)

+	/* check to see if this is a hard drive
+	 * if it is then checkhpa needs to be
+	 * disabled */

Comment style again.

+	if(drive->media == ide_disk && idedisk_supports_hpa(drive->id))

space after "if".

+		init_idedisk_capacity(drive);


---
~Randy
