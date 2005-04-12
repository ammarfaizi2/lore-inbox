Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVDLNy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVDLNy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVDLNxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:53:43 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:19527 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262412AbVDLMxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:53:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ISvwl0KqSeQVj8ma5NO1NybzS+v5rRZJ79gwBKn85StE1PzRELLkGvRA+unQ8gm4mbD6Sw3DIsq9Le4wN41pmU38EAiPTf9znWenstylbxeS3q2RFvt8uNLyewpZnN/EQBo/RzCdxjTsBbtJ75D4lb1DOKIxJ2XW3nKctM7c1ew=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 06/07] scsi: add cmd->result clearing
Message-ID: <20050412125219.DF27C115@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:51 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_scsi_requeue_reset_result.patch

	cmd->result wasn't cleared on requeue or reprep.  Clear it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c     |    9 +++++----
 scsi_lib.c |    1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 21:50:12.000000000 +0900
@@ -681,11 +681,12 @@ void scsi_retry_command(struct scsi_cmnd
 	 */
 	scsi_setup_cmd_retry(cmd);
 
-        /*
-         * Zero the sense information from the last time we tried
-         * this command.
-         */
+	/*
+	 * Zero the sense information and result code from the last
+	 * time we tried this command.
+	 */
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+	cmd->result = 0;
 
 	scsi_requeue_command(cmd);
 }
Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 21:50:12.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 21:50:12.000000000 +0900
@@ -222,6 +222,7 @@ static int scsi_init_cmd_errh(struct scs
 	cmd->abort_reason = 0;
 
 	memset(cmd->sense_buffer, 0, sizeof cmd->sense_buffer);
+	cmd->result = 0;
 
 	if (cmd->cmd_len == 0)
 		cmd->cmd_len = COMMAND_SIZE(cmd->cmnd[0]);

