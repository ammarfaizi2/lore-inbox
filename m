Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313556AbSDHFRL>; Mon, 8 Apr 2002 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSDHFRK>; Mon, 8 Apr 2002 01:17:10 -0400
Received: from stingr.net ([212.193.32.15]:62087 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313556AbSDHFRG>;
	Mon, 8 Apr 2002 01:17:06 -0400
Date: Mon, 8 Apr 2002 09:16:59 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 6
Message-ID: <20020408051659.GL839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.315   -> 1.316  
#	    drivers/md/lvm.c	1.16    -> 1.17   
#	drivers/isdn/isdn_tty.c	1.9     -> 1.10   
#	drivers/macintosh/mediabay.c	1.3     -> 1.4    
#	     drivers/md/md.c	1.29    -> 1.30   
#	drivers/macintosh/via-pmu.c	1.9     -> 1.10   
#	drivers/macintosh/macserial.c	1.7     -> 1.8    
#	drivers/isdn/hisax/sedlbauer.c	1.5     -> 1.6    
#	drivers/macintosh/adb.c	1.5     -> 1.6    
#	drivers/isdn/icn/icn.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.316
# task->state cleanup part 6
# --------------------------------------------
#
diff -Nru a/drivers/isdn/hisax/sedlbauer.c b/drivers/isdn/hisax/sedlbauer.c
--- a/drivers/isdn/hisax/sedlbauer.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/isdn/hisax/sedlbauer.c	Mon Apr  8 01:23:48 2002
@@ -448,10 +448,10 @@
 			byteout(cs->hw.sedl.cfg_reg +3, cs->hw.sedl.reset_on);
 			save_flags(flags);
 			sti();
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout((20*HZ)/1000);
 			byteout(cs->hw.sedl.cfg_reg +3, cs->hw.sedl.reset_off);
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout((20*HZ)/1000);
 			restore_flags(flags);
 		} else {		
@@ -621,7 +621,7 @@
 		byteout(cs->hw.sedl.cfg_reg +3, cs->hw.sedl.reset_on);
 		save_flags(flags);
 		sti();
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout((10*HZ)/1000);
 		byteout(cs->hw.sedl.cfg_reg +3, cs->hw.sedl.reset_off);
 		restore_flags(flags);
diff -Nru a/drivers/isdn/icn/icn.c b/drivers/isdn/icn/icn.c
--- a/drivers/isdn/icn/icn.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/isdn/icn/icn.c	Mon Apr  8 01:23:48 2002
@@ -772,7 +772,7 @@
 #ifdef BOOT_DEBUG
 			printk(KERN_DEBUG "Loader %d TO?\n", cardnumber);
 #endif
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(ICN_BOOT_TIMEOUT1);
 		} else {
 #ifdef BOOT_DEBUG
@@ -798,7 +798,7 @@
 int slsec = sec; \
   printk(KERN_DEBUG "SLEEP(%d)\n",slsec); \
   while (slsec) { \
-    current->state = TASK_INTERRUPTIBLE; \
+    set_current_state(TASK_INTERRUPTIBLE); \
     schedule_timeout(HZ); \
     slsec--; \
   } \
@@ -957,7 +957,7 @@
 				icn_maprelease_channel(card, 0);
 				return -EIO;
 			}
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(10);
 		}
 	}
@@ -981,7 +981,7 @@
 #ifdef BOOT_DEBUG
 			printk(KERN_DEBUG "Proto TO?\n");
 #endif
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(ICN_BOOT_TIMEOUT1);
 		} else {
 			if ((card->secondhalf) || (!card->doubleS0)) {
diff -Nru a/drivers/isdn/isdn_tty.c b/drivers/isdn/isdn_tty.c
--- a/drivers/isdn/isdn_tty.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/isdn/isdn_tty.c	Mon Apr  8 01:23:48 2002
@@ -1712,7 +1712,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/macintosh/adb.c	Mon Apr  8 01:23:48 2002
@@ -120,7 +120,7 @@
 {
 	if (current->pid && adb_probe_task_pid &&
 	  adb_probe_task_pid == current->pid) {
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1 + ms * HZ / 1000);
 	} else
 		mdelay(ms);
@@ -701,7 +701,7 @@
 	req = NULL;
 	spin_lock_irqsave(&state->lock, flags);
 	add_wait_queue(&state->wait_queue, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	for (;;) {
 		req = state->completed;
@@ -725,7 +725,7 @@
 		spin_lock_irqsave(&state->lock, flags);
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&state->wait_queue, &wait);
 	spin_unlock_irqrestore(&state->lock, flags);
 	
diff -Nru a/drivers/macintosh/macserial.c b/drivers/macintosh/macserial.c
--- a/drivers/macintosh/macserial.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/macintosh/macserial.c	Mon Apr  8 01:23:48 2002
@@ -2037,7 +2037,7 @@
 
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -2085,14 +2085,14 @@
 	if (timeout)
 		char_time = MIN(char_time, timeout);
 	while ((read_zsreg(info->zs_channel, 1) & ALL_SNT) == 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 }
 
 /*
@@ -2227,7 +2227,7 @@
 		       info->line, info->count);
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
--- a/drivers/macintosh/mediabay.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/macintosh/mediabay.c	Mon Apr  8 01:23:48 2002
@@ -630,7 +630,7 @@
 		for (i = 0; i < media_bay_count; ++i)
 			media_bay_step(i);
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 		if (signal_pending(current))
 			return 0;
diff -Nru a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
--- a/drivers/macintosh/via-pmu.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/macintosh/via-pmu.c	Mon Apr  8 01:23:48 2002
@@ -2296,7 +2296,7 @@
 
 	spin_lock_irqsave(&pp->lock, flags);
 	add_wait_queue(&pp->wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	for (;;) {
 		ret = -EAGAIN;
@@ -2325,7 +2325,7 @@
 		schedule();
 		spin_lock_irqsave(&pp->lock, flags);
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&pp->wait, &wait);
 	spin_unlock_irqrestore(&pp->lock, flags);
 	
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/md/lvm.c	Mon Apr  8 01:23:48 2002
@@ -1788,7 +1788,7 @@
 		if (vg_ptr->lv[i] != NULL &&
 		    vg_ptr->lv[i]->lv_access & LV_SNAPSHOT) {
 			lvm_do_lv_remove(minor, NULL, i);
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 	}
@@ -1796,7 +1796,7 @@
 	for (i = 0; i < vg_ptr->lv_max; i++) {
 		if (vg_ptr->lv[i] != NULL) {
 			lvm_do_lv_remove(minor, NULL, i);
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 	}
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Mon Apr  8 01:23:48 2002
+++ b/drivers/md/md.c	Mon Apr  8 01:23:48 2002
@@ -2946,13 +2946,13 @@
 		DECLARE_WAITQUEUE(wait, current);
 
 		add_wait_queue(&thread->wqueue, &wait);
-		set_task_state(current, TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!test_bit(THREAD_WAKEUP, &thread->flags)) {
 			dprintk("md: thread %p went to sleep.\n", thread);
 			schedule();
 			dprintk("md: thread %p woke up.\n", thread);
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&thread->wqueue, &wait);
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
@@ -3473,7 +3473,7 @@
 
 			if ((currspeed > sysctl_speed_limit_max) ||
 					!is_mddev_idle(mddev)) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				md_schedule_timeout(HZ/4);
 				goto repeat;
 			}

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
