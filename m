Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283430AbRK2Xd6>; Thu, 29 Nov 2001 18:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283432AbRK2Xds>; Thu, 29 Nov 2001 18:33:48 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:17573 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S283430AbRK2Xdj>; Thu, 29 Nov 2001 18:33:39 -0500
Date: Thu, 29 Nov 2001 18:33:15 -0500
From: Alex Valys <avalys@optonline.net>
Subject: PATCH: Spinlock Macro Arguments Correction in pc_keyb.c
To: linux-kernel@vger.kernel.org
Message-id: <0GNL00C2J5G9JN@mta6.srv.hcvlny.cv.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was compiling 2.5.1-pre3 this evening, and recieved errors to the effect of:
Line xxx:spinlock_unlock used with too many arguments
Line xxxx:spinlock_unlock_irqrestore used with too few arguments
Line XXXX:spinlock_unlock_irqrestore used with too few arguments

Not having ever done any serious kernel programming, I have only a dim 
understanding of what spinlocks are, but by looking at those macro 
definitions in spinlock.h (and their occurences elsewhere in the file) I 
think I determined their proper usage.  The following patch fixed the compile 
errors, and I'm using 2.5.1-pre3 to type this message.  

This is my first patch, so if I did anything wrong please correct me.
-Alex Valys




--- drivers/char/pc_keyb.c.orig Thu Nov 29 18:05:00 2001
+++ drivers/char/pc_keyb.c      Thu Nov 29 18:07:14 2001
@@ -420,7 +420,7 @@
                               kbd_write_command(KBD_CCMD_WRITE_MODE);
                               kb_wait();
                               kbd_write_output(AUX_INTS_OFF);
-                              spin_unlock(&kbd_controller_lock, flags);
+                              spin_unlock(&kbd_controller_lock);
                       }
                       spin_unlock_irqrestore( &aux_count_lock,flags );
               }
@@ -1056,7 +1056,7 @@
        fasync_aux(-1, file, 0);
        spin_lock_irqsave( &aux_count, flags );
        if ( --aux_count ) {
-               spin_unlock_irqrestore( &aux_count_lock );
+               spin_unlock_irqrestore( &aux_count_lock, flags );
                return 0;
        }
        spin_unlock_irqrestore( &aux_count_lock, flags );
@@ -1076,7 +1076,7 @@
        int flags;
        spin_lock_irqsave( &aux_count_lock, flags );
        if ( aux_count++ ) {
-               spin_unlock_irqrestore( &aux_count_lock );
+               spin_unlock_irqrestore( &aux_count_lock, flags );
                return 0;
        }
        queue->head = queue->tail = 0;          /* Flush input queue */


















