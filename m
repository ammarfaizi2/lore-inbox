Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVBBDqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVBBDqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVBBDEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:04:43 -0500
Received: from [211.58.254.17] ([211.58.254.17]:35466 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262239AbVBBC4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:56:51 -0500
Date: Wed, 2 Feb 2005 11:56:49 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 13/29] ide: use time_after() macro
Message-ID: <20050202025649.GN621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 13_ide_tape_time_after.patch
> 
> 	Explicit jiffy comparision converted to time_after() macro.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-tape.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-tape.c	2005-02-02 10:27:15.513263167 +0900
+++ linux-ide-export/drivers/ide/ide-tape.c	2005-02-02 10:28:04.720279713 +0900
@@ -2439,7 +2439,7 @@ static ide_startstop_t idetape_do_reques
 			tape->dsc_polling_start = jiffies;
 			tape->dsc_polling_frequency = tape->best_dsc_rw_frequency;
 			tape->dsc_timeout = jiffies + IDETAPE_DSC_RW_TIMEOUT;
-		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
+		} else if (time_after(jiffies, tape->dsc_timeout)) {
 			printk(KERN_ERR "ide-tape: %s: DSC timeout\n",
 				tape->name);
 			if (rq->cmd[0] & REQ_IDETAPE_PC2) {
