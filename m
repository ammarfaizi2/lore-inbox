Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129743AbRBBFNV>; Fri, 2 Feb 2001 00:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129973AbRBBFNM>; Fri, 2 Feb 2001 00:13:12 -0500
Received: from kazoo.cs.uiuc.edu ([128.174.237.133]:33930 "EHLO
	kazoo.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129743AbRBBFM7>; Fri, 2 Feb 2001 00:12:59 -0500
To: axboe@suse.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        livid-dev@linuxvideo.org, Peter Rasmussen (udgaard) <plr@udgaard.com>
Subject: [Patch] DVD bugfix in ide-cd.c
In-Reply-To: <200102012210.XAA00328@udgaard.com>
	<sz2u26d4tt8.fsf@kazoo.cs.uiuc.edu>
From: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>
Date: 01 Feb 2001 23:12:44 -0600
In-Reply-To: <sz2u26d4tt8.fsf@kazoo.cs.uiuc.edu>
Message-ID: <sz2lmrp4qib.fsf_-_@kazoo.cs.uiuc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a small patch to Linux kernel 2.4.1 that fixes a problem with
DVD playback in OMS (Open Media System).  With the stock 2.4.1 kernel
OMS will only play up to a certain point on the DVD before it complains
about no more data left on input (basically read() returns 0).  This
patch reverts a change between 2.4.0 and 2.4.1.


diff -u --recursive --new-file v2.4.0/linux/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- v2.4.0/linux/drivers/ide/ide-cd.c	Tue Jan  2 16:59:17 2001
+++ linux/drivers/ide/ide-cd.c	Sun Jan 28 13:37:50 2001
@@ -1872,6 +1872,9 @@
 	   If it is, just return. */
 	(void) cdrom_check_status(drive, sense);
 
+	if (CDROM_STATE_FLAGS(drive)->toc_valid)
+		return 0;
+
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
 				    sizeof(struct atapi_toc_header), sense);


-- 
Fredrik Vraalsen  -  Research Assistant, Pablo research group
Department of Computer Science, University of Illinois at U-C
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
