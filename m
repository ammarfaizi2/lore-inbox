Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbSJBKvo>; Wed, 2 Oct 2002 06:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJBKvo>; Wed, 2 Oct 2002 06:51:44 -0400
Received: from users.linvision.com ([62.58.92.114]:24972 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S263036AbSJBKvm>; Wed, 2 Oct 2002 06:51:42 -0400
Date: Wed, 2 Oct 2002 12:56:56 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: romieu@cogenit.fr
Subject: Fwd: [PATCH] 2.5.37 - xtime removal and __FUNCTION__ change
Message-ID: <20021002125656.A7246@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, 

Accompanying patch approved by author (me :-) ....

		Roger. 


----- Forwarded message from Francois Romieu <romieu@cogenit.fr> -----

From: Francois Romieu <romieu@cogenit.fr>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date: Fri, 20 Sep 2002 22:11:38 +0200
Subject: [PATCH] 2.5.37 - xtime removal and __FUNCTION__ change

Greetings,

  I hadn't done a compile fest on 2.5.x for quite some time. Interesting.
- __FUNCTION__ parsing doesn't seem to be welcome any more;
- xtime type has changed. do_gettimeofday() looks like the way to go.

Please forward to Linus if appropriate.

diff -urpN linux-2.5.37.orig/drivers/atm/firestream.c linux-2.5.37/drivers/atm/firestream.c
--- linux-2.5.37.orig/drivers/atm/firestream.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/firestream.c	Fri Sep 20 21:44:28 2002
@@ -330,8 +330,8 @@ MODULE_PARM(fs_keystream, "i");
 #define FS_DEBUG_QSIZE   0x00001000
 
 
-#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " __FUNCTION__ "\n")
-#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " __FUNCTION__ "\n")
+#define func_enter() fs_dprintk(FS_DEBUG_FLOW, "fs: enter %s\n", __FUNCTION__ )
+#define func_exit()  fs_dprintk(FS_DEBUG_FLOW, "fs: exit %s\n", __FUNCTION__ )
 
 
 struct fs_dev *fs_boards = NULL;
@@ -814,7 +814,7 @@ static void process_incoming (struct fs_
 				skb_put (skb, qe->p1 & 0xffff); 
 				ATM_SKB(skb)->vcc = atm_vcc;
 				atomic_inc(&atm_vcc->stats->rx);
-				skb->stamp = xtime;
+				do_gettimeofday(&skb->stamp);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-skb: %p (pushed)\n", skb);
 				atm_vcc->push (atm_vcc, skb);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-d: %p\n", pe);

----- End forwarded message -----

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
