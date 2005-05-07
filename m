Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVEGBvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVEGBvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 21:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVEGBvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 21:51:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:50133 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261492AbVEGBvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 21:51:03 -0400
Date: Sat, 7 May 2005 03:54:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Ed Okerson <eokerson@quicknet.net>,
       Joe Perches <joe@perches.com>, akpm@osdl.org
Subject: Re: [PATCH] kfree cleanups (remove redundant NULL checks) in
 drivers/telephony/ (actually ixj.c only)
In-Reply-To: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0505070345430.2384@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, Jesper Juhl wrote:

> This patch removes redundant checks for NULL pointer before kfree() in 
> drivers/telephony/
> 
Joe Perches pointed out to me that 
	kfree
followed by
	setting all structure members would be slightly better. 

Incremental patch below.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/telephony/ixj.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc3-mm3/drivers/telephony/ixj.c.old	2005-05-07 03:50:43.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/telephony/ixj.c	2005-05-07 03:53:22.000000000 +0200
@@ -3865,9 +3865,9 @@ static int set_rec_codec(IXJ *j, int rat
 		j->rec_mode = 7;
 		break;
 	default:
+		kfree(j->read_buffer);
 		j->rec_frame_size = 0;
 		j->rec_mode = -1;
-		kfree(j->read_buffer);
 		j->read_buffer = NULL;
 		j->read_buffer_size = 0;
 		retval = 1;
@@ -3987,7 +3987,7 @@ static int ixj_record_start(IXJ *j)
 
 static void ixj_record_stop(IXJ *j)
 {
-	if(ixjdebug & 0x0002)
+	if (ixjdebug & 0x0002)
 		printk("IXJ %d Stopping Record Codec %d at %ld\n", j->board, j->rec_codec, jiffies);
 
 	kfree(j->read_buffer);
@@ -4443,9 +4443,9 @@ static int set_play_codec(IXJ *j, int ra
 		j->play_mode = 5;
 		break;
 	default:
+		kfree(j->write_buffer);
 		j->play_frame_size = 0;
 		j->play_mode = -1;
-		kfree(j->write_buffer);
 		j->write_buffer = NULL;
 		j->write_buffer_size = 0;
 		retval = 1;
@@ -4570,7 +4570,7 @@ static int ixj_play_start(IXJ *j)
 
 static void ixj_play_stop(IXJ *j)
 {
-	if(ixjdebug & 0x0002)
+	if (ixjdebug & 0x0002)
 		printk("IXJ %d Stopping Play Codec %d at %ld\n", j->board, j->play_codec, jiffies);
 
 	kfree(j->write_buffer);


