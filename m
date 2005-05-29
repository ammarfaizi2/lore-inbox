Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVE2E2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVE2E2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVE2EZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:25:43 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:25093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261234AbVE2EXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:23:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Tykuydf3+CrN8mIj+uqP9/STSjl1lCU0GmV6BkFqsLkT9wz44jcBRFmOMDsfExNpLnMfhveBeDefHz/qmqD8/mFDo3sVPtCQbtcjSCgSHN9Q0BJnbMRzm9XiB9OKdayYYx+U79z9ar6OKlwBTaqnCHXCHyiT/9zxts4fcfpDvUI=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 02/06] blk: make scsi use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST
Message-ID: <20050529042034.0ED3C0BE@htj.dyndns.org>
Date: Sun, 29 May 2005 13:23:28 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_scsi_eopnotsupp.patch

	Use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-05-29 13:20:30.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-05-29 13:20:31.000000000 +0900
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

