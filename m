Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277011AbSIVJJp>; Sun, 22 Sep 2002 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276882AbSIVJIn>; Sun, 22 Sep 2002 05:08:43 -0400
Received: from smtpout.mac.com ([204.179.120.89]:48600 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276880AbSIVJIa>;
	Sun, 22 Sep 2002 05:08:30 -0400
Date: Sat, 21 Sep 2002 22:35:57 +0200
Subject: [PATCH] 5/11 sound/oss replace cli() 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BBA47EA5-CDA1-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/dmasound/dmasound_core.c	2002-08-10 
00:03:13.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_core.c	2002-09-09 00:33:
36.000000000 +0200
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

