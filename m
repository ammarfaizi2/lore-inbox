Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVBBDGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVBBDGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVBBDGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:06:30 -0500
Received: from [211.58.254.17] ([211.58.254.17]:43658 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262244AbVBBDAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:00:49 -0500
Date: Wed, 2 Feb 2005 12:00:47 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 16/29] ide: flagged_taskfile select register dev bit masking
Message-ID: <20050202030047.GA1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 16_ide_flagged_taskfile_select_dev_bit_masking.patch
> 
> 	In flagged_taskfile(), make off DEV bit before OR'ing it with
> 	drive->select.all when writing to IDE_SELECT_REG.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.093219204 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.273190003 +0900
@@ -858,7 +858,8 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+		   IDE_SELECT_REG);
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
