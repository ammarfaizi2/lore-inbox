Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVBBD7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVBBD7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBD4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:56:20 -0500
Received: from [211.58.254.17] ([211.58.254.17]:58250 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262252AbVBBDDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:03:43 -0500
Date: Wed, 2 Feb 2005 12:03:41 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 19/29] ide: ide_diag_taskfile() rq initialization fix
Message-ID: <20050202030341.GD1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 19_ide_diag_taskfile_use_init_drive_cmd.patch
> 
> 	In ide_diag_taskfile(), when initializing taskfile rq,
> 	ref_count wasn't initialized properly.  Modified to use
> 	ide_init_drive_cmd().  This doesn't really change any behavior
> 	as the request isn't managed via the block layer.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.642130143 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.851096238 +0900
@@ -471,7 +471,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
+	ide_init_drive_cmd(&rq);
 	rq.flags = REQ_DRIVE_TASKFILE;
 	rq.buffer = buf;
 
