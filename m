Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBZXGX>; Tue, 26 Feb 2002 18:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSBZXGN>; Tue, 26 Feb 2002 18:06:13 -0500
Received: from [203.94.130.164] ([203.94.130.164]:62482 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S287425AbSBZXGH>;
	Tue, 26 Feb 2002 18:06:07 -0500
Date: Wed, 27 Feb 2002 10:35:40 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] 2.5 scsi changes : qlogicfas.c fixed (resend)
Message-ID: <Pine.LNX.4.44.0202271030410.29386-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Resending this patch to allow my qlogic pcmcia scsi card to compile again, 
as broken by the recent scsi layer changes.

Despite davem's apparent suggestion that it'd be better to rewrite the 
driver, i'd rather not _just_ right now :)

thanks,

	/ Brett Pemberton

--- drivers/scsi/qlogicfas.c.bak	Wed Feb 20 21:23:11 2002
+++ drivers/scsi/qlogicfas.c	Wed Feb 20 21:18:37 2002
@@ -344,6 +344,7 @@
 unsigned int	reqlen; 		/* total length of transfer */
 struct scatterlist	*sglist;	/* scatter-gather list pointer */
 unsigned int	sgcount;		/* sg counter */
+char *buf;
 
 rtrc(1)
 	j = inb(qbase + 6);
@@ -391,7 +392,8 @@
 					REG0;
 					return ((qabort == 1 ? DID_ABORT : DID_RESET) << 16);
 				}
-				if (ql_pdma(phase, sglist->address, sglist->length))
+				buf = page_address(sglist->page) + sglist->offset;
+				if (ql_pdma(phase, buf, sglist->length))
 					break;
 				sglist++;
 			}

