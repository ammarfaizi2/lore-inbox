Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVBBDMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVBBDMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBBDHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:07:07 -0500
Received: from [211.58.254.17] ([211.58.254.17]:45194 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262245AbVBBDB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:01:57 -0500
Date: Wed, 2 Feb 2005 12:01:55 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 17/29] ide: flagged_taskfile() tf_out_flags.b.select check
Message-ID: <20050202030155.GB1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 17_ide_flagged_taskfile_select_check.patch
> 
> 	In flagged_taskfile(), tf_out_flags.b.select should be checked
> 	before using bits inside taskfile->device_head.  When user
> 	haven't specified the select register, the default
> 	drive->select.all value should be used.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.273190003 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.463159181 +0900
@@ -858,8 +858,12 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
-		   IDE_SELECT_REG);
+	if (task->tf_out_flags.b.select)
+		hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+			   IDE_SELECT_REG);
+	else
+		hwif->OUTB(drive->select.all, IDE_SELECT_REG);
+ 
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
