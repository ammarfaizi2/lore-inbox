Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVBEKfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVBEKfg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbVBEKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:30:47 -0500
Received: from [211.58.254.17] ([211.58.254.17]:34449 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266333AbVBEK2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:50 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 03/09] ide: ide_diag_taskfile() rq initialization fix
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.4FA131326FC@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03_ide_diag_taskfile_use_init_drive_cmd.patch

	In ide_diag_taskfile(), when initializing taskfile rq,
	ref_count wasn't initialized properly.  Modified to use
	ide_init_drive_cmd().  This doesn't really change any behavior
	as the request isn't managed via the block layer.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.308610336 +0900
+++ linux-ide-series2-export/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.533573794 +0900
@@ -471,8 +471,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_TASKFILE;
+	ide_init_drive_cmd(&rq);
 	rq.buffer = buf;
 
 	/*
