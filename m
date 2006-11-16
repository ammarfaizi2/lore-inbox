Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162253AbWKPCrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162253AbWKPCrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162261AbWKPCrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:47:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5512 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162254AbWKPCrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:15 -0500
Message-Id: <20061116024836.422688000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       Jens Axboe <jens.axboe@oracle.com>
Subject: [patch 25/30] block: Fix bad data direction in SG_IO
Content-Disposition: inline; filename=fix-bad-data-direction-in-sg_io.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jens Axboe <jens.axboe@oracle.com>

Contrary to what the name misleads you to believe, SG_DXFER_TO_FROM_DEV
is really just a normal read seen from the device side.

This patch fixes http://lkml.org/lkml/2006/10/13/100

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 block/scsi_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/block/scsi_ioctl.c
+++ linux-2.6.18.2/block/scsi_ioctl.c
@@ -246,10 +246,10 @@ static int sg_io(struct file *file, requ
 		switch (hdr->dxfer_direction) {
 		default:
 			return -EINVAL;
-		case SG_DXFER_TO_FROM_DEV:
 		case SG_DXFER_TO_DEV:
 			writing = 1;
 			break;
+		case SG_DXFER_TO_FROM_DEV:
 		case SG_DXFER_FROM_DEV:
 			break;
 		}

--
