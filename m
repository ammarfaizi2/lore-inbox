Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUI2PXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUI2PXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUI2PVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:21:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:60327 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268670AbUI2PPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:15:31 -0400
Subject: Re: [Patch] Fix oops on rmmod usb-storage
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <415ACA4C.807@suse.de>
References: <415A67B8.2080003@suse.de>  <1096466196.2028.8.camel@mulgrave>
		<1096463876.15905.23.camel@localhost.localdomain>
	<1096467874.1762.15.camel@mulgrave>  <415ACA4C.807@suse.de>
Content-Type: multipart/mixed; boundary="=-0kG4j03+Ywu4VousXTKc"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Sep 2004 11:15:13 -0400
Message-Id: <1096470919.1762.21.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0kG4j03+Ywu4VousXTKc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-09-29 at 10:44, Hannes Reinecke wrote:
> Oh, that can be fixed. Attached is the full trace (including USB 
> debugging output).
> It does crash. Hard.

OK, looks like a refcounting problem again.

Try the attached and see if it goes away.

Thanks,

James


--=-0kG4j03+Ywu4VousXTKc
Content-Disposition: inline
Content-Type: message/rfc822

Return-Path: <linux-scsi-owner@vger.kernel.org>
Received: from hancock.sc.steeleye.com (hancock.sc.steeleye.com
	[172.17.4.1]) by pogo.mtv1.steeleye.com (8.12.8/8.12.8) with ESMTP id
	i8SGfJcY011993 for <jejb@pogo.mtv1.steeleye.com>; Tue, 28 Sep 2004 09:41:19
	-0700
Received: from localhost.localdomain (orville.steeleye.com [209.192.50.34])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id i8SGfIm19476; Tue,
	28 Sep 2004 12:41:18 -0400
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	localhost.localdomain (8.12.8/8.12.8) with ESMTP id i8SHjsBP013576; Tue, 28
	Sep 2004 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S267974AbUI1Qkt (ORCPT <rfc822;Eddie.Williams@steeleye.com> + 1 other);
	Tue, 28 Sep 2004 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUI1Qkt
	(ORCPT <rfc822;linux-scsi-outgoing>); Tue, 28 Sep 2004 12:40:49 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:32187 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP id S267974AbUI1Qko
	(ORCPT <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Sep 2004 12:40:44 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com
	[172.17.6.40]) by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id
	i8SGehm19459; Tue, 28 Sep 2004 12:40:43 -0400
Subject: Re: [linux-usb-devel] Fw: [Bug 3466] New: Bug while connecting
	USB-HDD (fwd)
From: James Bottomley <James.Bottomley@steeleye.com>
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <1096236347.10924.97.camel@mulgrave>
References: 	<Pine.LNX.4.44L0.0409261704460.32350-100000@netrider.rowland.org> 
	<1096236347.10924.97.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Sep 2004 12:40:37 -0400
Message-Id: <1096389644.1717.45.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
X-Spam-Status: No, hits=-8.9 required=5.0
	tests=AWL,BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,
	PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,REFERENCES,
	REPLY_WITH_QUOTES,USER_AGENT_XIMIAN,X_MAILING_LIST autolearn=ham
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
X-Evolution-Source: imap://jejb@172.16.1.1/

On Sun, 2004-09-26 at 18:05, James Bottomley wrote:
> There's not enough information to say why it happened.  However, all the
> SCSI code checks out (it's dated ... open coded reference counting
> instead of kref, but it looks sound).  The scenario described could be
> seen if there's a problem in the host reference counting.
> 
> In that case, there should have been a slab error earlier on in the logs
> at the point the error occurred saying something like "slab error in
> kmem_cache_destory(): can't free all objects"
> 
> It's possible this could be caused by a refcounting race on the
> commands.

OK, I have a definite theory about this, but it hinges on finding the
above message in the logs.

I think we tried to destroy the command slab while some commands were
still active.  The refcounting only applies to in-flight commands, but
commands can also be allocated and queued in the block layer.

If I'm right, the attached will close this refcounting hole.

James

===== drivers/scsi/scsi.c 1.146 vs edited =====
--- 1.146/drivers/scsi/scsi.c	2004-08-09 12:55:05 -05:00
+++ edited/drivers/scsi/scsi.c	2004-09-28 11:23:31 -05:00
@@ -244,7 +244,13 @@
  */
 struct scsi_cmnd *scsi_get_command(struct scsi_device *dev, int gfp_mask)
 {
-	struct scsi_cmnd *cmd = __scsi_get_command(dev->host, gfp_mask);
+	struct scsi_cmnd *cmd;
+
+	/* Bail if we can't get a reference to the device */
+	if (!get_device(&dev->sdev_gendev))
+		return NULL;
+
+	cmd = __scsi_get_command(dev->host, gfp_mask);
 
 	if (likely(cmd != NULL)) {
 		unsigned long flags;
@@ -258,7 +264,8 @@
 		spin_lock_irqsave(&dev->list_lock, flags);
 		list_add_tail(&cmd->list, &dev->cmd_list);
 		spin_unlock_irqrestore(&dev->list_lock, flags);
-	}
+	} else
+		put_device(&dev->sdev_gendev);
 
 	return cmd;
 }				
@@ -276,7 +283,8 @@
  */
 void scsi_put_command(struct scsi_cmnd *cmd)
 {
-	struct Scsi_Host *shost = cmd->device->host;
+	struct scsi_device *sdev = cmd->device;
+	struct Scsi_Host *shost = sdev->host;
 	unsigned long flags;
 	
 	/* serious error if the command hasn't come from a device list */
@@ -294,6 +302,8 @@
 
 	if (likely(cmd != NULL))
 		kmem_cache_free(shost->cmd_pool->slab, cmd);
+
+	put_device(&sdev->sdev_gendev);
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-0kG4j03+Ywu4VousXTKc--

