Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSIIKDh>; Mon, 9 Sep 2002 06:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSIIKDZ>; Mon, 9 Sep 2002 06:03:25 -0400
Received: from smtpout.mac.com ([204.179.120.89]:16596 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316886AbSIIKCd>;
	Mon, 9 Sep 2002 06:02:33 -0400
Message-Id: <200209091007.g89A7HVw025718@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 8/10 sound/oss/dmasound/dmasound_core.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/dmasound/dmasound_core.c	Sat Aug 10 00:03:13 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_core.c	Mon Sep  9 00:33:36 2002
@@ -597,9 +597,9 @@
 	   is drained - and if we get here in time then it does not apply.
 	*/
 
-	save_flags(flags) ; cli() ;
+	spin_lock_irqsave(&dmasound.lock, flags);
 	write_sq.syncing &= ~2 ; /* take out POST status */
-	restore_flags(flags) ;
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 
 	if (write_sq.count > 0 &&
 	    (bLeft = write_sq.block_size-write_sq.rear_size) > 0) {
@@ -1347,6 +1347,7 @@
 	if (dmasound.mach.record)
 		sq_fops.read = sq_read ;
 #endif
+	spin_lock_init(&dmasound.lock);
 	sq_unit = register_sound_dsp(&sq_fops, -1);
 	if (sq_unit < 0) {
 		printk(KERN_ERR "dmasound_core: couldn't register fops\n") ;

