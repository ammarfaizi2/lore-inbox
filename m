Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291736AbSBNQCN>; Thu, 14 Feb 2002 11:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291738AbSBNQCK>; Thu, 14 Feb 2002 11:02:10 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:16035 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S291736AbSBNQB6>; Thu, 14 Feb 2002 11:01:58 -0500
Date: Thu, 14 Feb 2002 11:01:43 -0500
From: Chris Mason <mason@suse.com>
To: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] write barriers for 2.4.x
Message-ID: <3398950000.1013702503@tiny>
In-Reply-To: <m3vgd1ufbt.fsf@merlin.emma.line.org>
In-Reply-To: <3045480000.1013637574@tiny> <m3vgd1ufbt.fsf@merlin.emma.line.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thursday, February 14, 2002 03:31:08 PM +0100 Matthias Andree <ma@dt.e-technik.uni-dortmund.de> wrote:

[ barrier support for sym53c8xx_2?]

I can only promise this compiles against 2.4.18-pre9, and looks right
to me.  l-k and Jens brought into cc in hopes of a little verification.

-chris

--- a/drivers/scsi/sym53c8xx_2/sym_glue.c Thu, 13 Dec 2001 11:06:51 -0500 
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c Thu, 14 Feb 2002 10:43:01 -0500 
@@ -729,7 +729,14 @@
 	 *  Select tagged/untagged.
 	 */
 	lp = sym_lp(np, tp, ccb->lun);
-	order = (lp && lp->s.reqtags) ? M_SIMPLE_TAG : 0;
+	if (lp && lp->s.reqtags) {
+		if (ccb->request.cmd_flags & RQ_WRITE_ORDERED)
+			order = M_ORDERED_TAG;
+		else
+			order = M_SIMPLE_TAG;
+	} else {
+		order = 0 ;
+	}
 
 	/*
 	 *  Queue the SCSI IO.





