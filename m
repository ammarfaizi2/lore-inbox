Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTLFIMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTLFIMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:12:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:30156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264966AbTLFIMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:12:47 -0500
Date: Sat, 6 Dec 2003 00:12:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tero Knuutila <tero1001@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <Law9-F31u8ohMschTC00001183f@hotmail.com>
Message-ID: <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Dec 2003, Tero Knuutila wrote:
>
> My system hangs everytime I try to  burn my .wav files to cd with cdrecord.
> Usually few tracks go succesfully but then everything stops. Even the mouse
> won't move and powerbutton does not affect.

Is this with ide-scsi? If so, does the appended patch help?

If not, we really need a whole lot more information (hw config, messages
etc).

		Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1499  -> 1.1500
#	drivers/scsi/ide-scsi.c	1.33    -> 1.34
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/02	torvalds@home.osdl.org	1.1500
# Fix ide-scsi.c uninitialized variable
# --------------------------------------------
#
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	Sat Dec  6 00:12:13 2003
+++ b/drivers/scsi/ide-scsi.c	Sat Dec  6 00:12:13 2003
@@ -517,6 +517,7 @@
 	pc->current_position=pc->buffer;
 	bcount.all = IDE_MIN(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */

+	feature.all = 0;
 	if (drive->using_dma && rq->bio) {
 		if (test_bit(PC_WRITING, &pc->flags))
 			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
