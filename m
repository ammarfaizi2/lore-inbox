Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263643AbVCECWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbVCECWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbVCEB7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:59:38 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:13282 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263641AbVCEBsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=mRNtSdbQKzRIJvDQpRyC8bKV07XJiUU1gtMwWyD+Ay9R+m2KX2HG3l6NSx2G1/tXV7zNHutHbZqN/Eu7II6qpMjJt3xB+5lahR94GbvvocNGeKp4pL36KgdPn6XpFFgk5RPIVsOp2jwnSJZT5UraPQvzrvOKaktvPeL/2QEp4TI=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 04/08] ide: remove unused fields ide_drive_t->rq and ide_task_t->special
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014813.00CE05B7@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04_ide_remove_unused_fields.patch

	Remove unused fields ide_drive_t->rq and ide_task_t->special

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-tape.c |    1 -
 include/linux/ide.h    |    2 --
 2 files changed, 3 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-tape.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-tape.c	2005-03-05 10:37:51.567375213 +0900
+++ linux-taskfile-ng/drivers/ide/ide-tape.c	2005-03-05 10:46:59.482894810 +0900
@@ -1733,7 +1733,6 @@ static int idetape_end_request(ide_drive
 	}
 	ide_end_drive_cmd(drive, 0, 0);
 //	blkdev_dequeue_request(rq);
-//	drive->rq = NULL;
 //	end_that_request_last(rq);
 
 	if (remove_stage)
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:46:59.095955301 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:46:59.483894654 +0900
@@ -660,7 +660,6 @@ typedef struct ide_drive_s {
 
 	request_queue_t		*queue;	/* request queue */
 
-	struct request		*rq;	/* current request */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
 	struct ide_driver_s	*driver;/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
@@ -934,7 +933,6 @@ typedef struct ide_task_s {
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
 } ide_task_t;
 
 typedef struct hwgroup_s {
