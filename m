Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBBGoX>; Fri, 2 Feb 2001 01:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129605AbRBBGoN>; Fri, 2 Feb 2001 01:44:13 -0500
Received: from [213.237.80.42] ([213.237.80.42]:26973 "EHLO udgaard.com")
	by vger.kernel.org with ESMTP id <S129243AbRBBGoG>;
	Fri, 2 Feb 2001 01:44:06 -0500
Date: Fri, 2 Feb 2001 07:45:03 +0100
From: Peter Rasmussen (udgaard) <plr@udgaard.com>
Message-Id: <200102020645.HAA00206@udgaard.com>
To: axboe@suse.de, vraalsen@cs.uiuc.edu
Subject: Re: [Patch] DVD bugfix in ide-cd.c
Cc: linux-kernel@vger.kernel.org, livid-dev@linuxvideo.org, plr@udgaard.com,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch made it work for me watching DVDs that used to stop, ie. oms
crashed. So I'll approve the patch :-)

Peter

Fredrik Vraalsen <vraalsen@cs.uiuc.edu> on 01 Feb 2001 23:12:44 wrote:
>
>
>This is a small patch to Linux kernel 2.4.1 that fixes a problem with
>DVD playback in OMS (Open Media System).  With the stock 2.4.1 kernel
>OMS will only play up to a certain point on the DVD before it complains
>about no more data left on input (basically read() returns 0).  This
>patch reverts a change between 2.4.0 and 2.4.1.
>
>
>diff -u --recursive --new-file v2.4.0/linux/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
>--- v2.4.0/linux/drivers/ide/ide-cd.c	Tue Jan  2 16:59:17 2001
>+++ linux/drivers/ide/ide-cd.c	Sun Jan 28 13:37:50 2001
>@@ -1872,6 +1872,9 @@
> 	   If it is, just return. */
> 	(void) cdrom_check_status(drive, sense);
> 
>+	if (CDROM_STATE_FLAGS(drive)->toc_valid)
>+		return 0;
>+
> 	/* First read just the header, so we know how long the TOC is. */
> 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
> 				    sizeof(struct atapi_toc_header), sense);
>
>
>-- 
>Fredrik Vraalsen  -  Research Assistant, Pablo research group
>Department of Computer Science, University of Illinois at U-C
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
