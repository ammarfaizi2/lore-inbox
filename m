Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946735AbWKJQLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946735AbWKJQLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946736AbWKJQLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:11:33 -0500
Received: from brick.kernel.dk ([62.242.22.158]:15626 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1946735AbWKJQLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:11:32 -0500
Date: Fri, 10 Nov 2006 17:13:55 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: romosan@sycorax.lbl.gov
Subject: re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
Message-ID: <20061110161355.GB15031@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Can you retest with this? This must be where the wrong write bit comes
from.

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2dc3264..a19338e 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
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
Jens Axboe

