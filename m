Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVBBDFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVBBDFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBBDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:04:50 -0500
Received: from [211.58.254.17] ([211.58.254.17]:37770 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262238AbVBBC5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:57:31 -0500
Date: Wed, 2 Feb 2005 11:57:28 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 14/29] ide: remove NULL checking in ide_error()
Message-ID: <20050202025728.GO621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 14_ide_error_remove_NULL_test.patch
> 
> 	In ide_error(), drive cannot be NULL.  ide_dump_status() can't
> 	handle NULL drive.


Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:04.465321080 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:04.904249864 +0900
@@ -555,7 +555,7 @@ ide_startstop_t ide_error (ide_drive_t *
 
 	err = ide_dump_status(drive, msg, stat);
 
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+	if ((rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
