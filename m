Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVBJIvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVBJIvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVBJIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:39:32 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:30421 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262050AbVBJIie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=jmWRHW/NnM9SyV5fRo5g5EukWRUin7pOmIizA43axRiNhRd1LqwoB/ngR6HxaN32uhexJP5jifbivhSsSJWLiG89PDxpP+mHvu84+To4KkfKHoYmhS+oFB3JJ2g5IPQDpCVd/s3qdNRIPKXuDCQ3/kuQqKJruM5h/9mICVAz0fk=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 03/11] ide: ide_diag_taskfile() rq initialization fix
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083819.A2B6B4F7@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:24 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03_ide_diag_taskfile_use_init_drive_cmd.patch

	In ide_diag_taskfile(), taskfile rq was initialized using
	memset().  Use init_drive_cmd() instead.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-taskfile.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.437024304 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.832957893 +0900
@@ -469,8 +469,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_TASKFILE;
+	ide_init_drive_cmd(&rq);
 	rq.buffer = buf;
 
 	/*
