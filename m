Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVFEF7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVFEF7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 01:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVFEF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 01:58:52 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:49903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261463AbVFEF5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=cWwQ3VeNS/ebOHqX/71m/1OWhTCUf0lIScW85gxeWo7AbmiU4UhyQgHF+FMsJPWacG6jZBlthFsQS31JOU8fH/bXd57PV1JvVIJhFAAVF+OBTKOm7viM+VryOGV/Sag6BpDJ3uOoXEI2DhpcaQdKL6Rnxczt+fMHV0p0NYQcigU=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 02/09] blk: make scsi use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST
Message-ID: <20050605055337.215AB52C@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:14 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_scsi_eopnotsupp.patch

	Use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-06-05 14:53:32.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-06-05 14:53:33.000000000 +0900
@@ -849,7 +849,8 @@ void scsi_io_completion(struct scsi_cmnd
 				scsi_requeue_command(q, cmd);
 				result = 0;
 			} else {
-				cmd = scsi_end_request(cmd, 0, this_count, 1);
+				cmd = scsi_end_request(cmd, -EOPNOTSUPP,
+						       this_count, 1);
 				return;
 			}
 			break;

