Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313580AbSDHIEZ>; Mon, 8 Apr 2002 04:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313581AbSDHIEY>; Mon, 8 Apr 2002 04:04:24 -0400
Received: from stingr.net ([212.193.32.15]:35976 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313580AbSDHIEV>;
	Mon, 8 Apr 2002 04:04:21 -0400
Date: Mon, 8 Apr 2002 12:04:13 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 7
Message-ID: <20020408080413.GN839@stingr.net>
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

If you want to blame me for incorrect using of set instead of __set - feel
free to mail me and point where I should to change. Or mail me a patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.316   -> 1.317  
#	drivers/media/video/meye.c	1.7     -> 1.8    
#	drivers/media/video/msp3400.c	1.8     -> 1.9    
#	drivers/media/radio/miropcm20-rds.c	1.2     -> 1.3    
#	drivers/media/video/cpia.c	1.6     -> 1.7    
#	drivers/media/video/saa5249.c	1.4     -> 1.5    
#	drivers/media/video/bw-qcam.c	1.6     -> 1.7    
#	drivers/media/video/planb.c	1.9     -> 1.10   
#	drivers/media/video/tuner.c	1.8     -> 1.9    
#	drivers/media/radio/radio-sf16fmi.c	1.6     -> 1.7    
#	drivers/media/radio/radio-maxiradio.c	1.4     -> 1.5    
#	drivers/media/video/c-qcam.c	1.5     -> 1.6    
#	drivers/media/video/zr36120.c	1.12    -> 1.13   
#	drivers/media/radio/radio-maestro.c	1.4     -> 1.5    
#	drivers/message/i2o/i2o_core.c	1.10    -> 1.11   
#	drivers/media/video/bttv-driver.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.317
# task->state cleanup part 7
# --------------------------------------------
#
diff -Nru a/drivers/media/radio/miropcm20-rds.c b/drivers/media/radio/miropcm20-rds.c
--- a/drivers/media/radio/miropcm20-rds.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/radio/miropcm20-rds.c	Mon Apr  8 01:23:50 2002
@@ -61,7 +61,7 @@
 	char c;
 	char bits[8];
 
-	current->state=TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(2*HZ);
 	aci_rds_cmd(RDS_STATUS, &c, 1);
 	print_matrix(&c, bits);
diff -Nru a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/radio/radio-maestro.c	Mon Apr  8 01:23:50 2002
@@ -93,7 +93,7 @@
 
 static void sleep_125ms(void)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ >> 3);
 }
 
diff -Nru a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/radio/radio-maxiradio.c	Mon Apr  8 01:23:50 2002
@@ -102,7 +102,7 @@
 
 static void sleep_125ms(void)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ >> 3);
 }
 
diff -Nru a/drivers/media/radio/radio-sf16fmi.c b/drivers/media/radio/radio-sf16fmi.c
--- a/drivers/media/radio/radio-sf16fmi.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/radio/radio-sf16fmi.c	Mon Apr  8 01:23:50 2002
@@ -98,7 +98,7 @@
 			schedule();
 	}
 /* If this becomes allowed use it ... 	
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/7);
 */	
 
@@ -125,7 +125,7 @@
 			schedule();
 	}
 /* If this becomes allowed use it ... 	
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/7);
 */	
 	res = (int)inb(myport+1);
diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/bttv-driver.c	Mon Apr  8 01:23:50 2002
@@ -1268,13 +1268,13 @@
 		buf+=q;
 
 		add_wait_queue(&btv->vbiq, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (todo && q==VBIBUF_SIZE-btv->vbip) 
 		{
 			if(nonblock)
 			{
 				remove_wait_queue(&btv->vbiq, &wait);
-                                current->state = TASK_RUNNING;
+                                set_current_state(TASK_RUNNING);
 				if(count==todo)
 					return -EWOULDBLOCK;
 				return count-todo;
@@ -1283,7 +1283,7 @@
 			if(signal_pending(current))
 			{
 				remove_wait_queue(&btv->vbiq, &wait);
-                                current->state = TASK_RUNNING;
+                                set_current_state(TASK_RUNNING);
 
 				if(todo==count)
 					return -EINTR;
@@ -1292,7 +1292,7 @@
 			}
 		}
 		remove_wait_queue(&btv->vbiq, &wait);
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
 	}
 	if (todo) 
 	{
@@ -1444,7 +1444,7 @@
 		 *	be sure its safe to free the buffer. We wait 5-6 fields
 		 *	which is more than sufficient to be sure.
 		 */
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/10);	/* Wait 1/10th of a second */
 	}
 	
@@ -1924,19 +1924,19 @@
 			break;
 		case GBUFFER_GRABBING:
 			add_wait_queue(&btv->capq, &wait);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			while(btv->gbuf[i].stat==GBUFFER_GRABBING) {
 				if (bttv_debug)
 					printk("bttv%d: cap sync: sleep on %d\n",btv->nr,i);
 				schedule();
 				if(signal_pending(current)) {
 					remove_wait_queue(&btv->capq, &wait);
-					current->state = TASK_RUNNING;
+					set_current_state(TASK_RUNNING);
 					return -EINTR;
 				}
 			}
 			remove_wait_queue(&btv->capq, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			/* fall throuth */
 		case GBUFFER_DONE:
 		case GBUFFER_ERROR:
@@ -2124,13 +2124,13 @@
 		buf+=q;
 
 		add_wait_queue(&btv->vbiq, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (todo && q==VBIBUF_SIZE-btv->vbip) 
 		{
 			if(nonblock)
 			{
 				remove_wait_queue(&btv->vbiq, &wait);
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				if(count==todo)
 					return -EWOULDBLOCK;
 				return count-todo;
@@ -2139,7 +2139,7 @@
 			if(signal_pending(current))
 			{
 				remove_wait_queue(&btv->vbiq, &wait);
-                                current->state = TASK_RUNNING;
+                                set_current_state(TASK_RUNNING);
 				if(todo==count)
 					return -EINTR;
 				else
@@ -2147,7 +2147,7 @@
 			}
 		}
 		remove_wait_queue(&btv->vbiq, &wait);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 	}
 	if (todo) 
 	{
diff -Nru a/drivers/media/video/bw-qcam.c b/drivers/media/video/bw-qcam.c
--- a/drivers/media/video/bw-qcam.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/bw-qcam.c	Mon Apr  8 01:23:50 2002
@@ -252,7 +252,7 @@
 			   
 			if(runs++>maxpoll)
 			{
-				current->state=TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(HZ/200);
 			}
 			if(runs>(maxpoll+1000)) /* 5 seconds */
@@ -272,7 +272,7 @@
 			   
 			if(runs++>maxpoll)
 			{
-				current->state=TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(HZ/200);
 			}
 			if(runs++>(maxpoll+1000)) /* 5 seconds */
@@ -305,7 +305,7 @@
 		   
 		if(runs++>maxpoll)
 		{
-			current->state=TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/200);
 		}
 		if(runs++>(maxpoll+1000)) /* 5 seconds */
@@ -672,7 +672,7 @@
 		   time will be 240 / 200 = 1.2 seconds. The compile-time
 		   default is to yield every 4 lines. */
 		if (i >= yield) {
-			current->state=TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/200);
 			yield = i + yieldlines;
 		}
diff -Nru a/drivers/media/video/c-qcam.c b/drivers/media/video/c-qcam.c
--- a/drivers/media/video/c-qcam.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/c-qcam.c	Mon Apr  8 01:23:50 2002
@@ -104,7 +104,7 @@
 	{
 		if (qcam_ready1(qcam) == value)
 			return 0;
-		current->state=TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 
@@ -130,7 +130,7 @@
 	{
 		if (qcam_ready2(qcam) == value)
 			return 0;
-		current->state=TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 
diff -Nru a/drivers/media/video/cpia.c b/drivers/media/video/cpia.c
--- a/drivers/media/video/cpia.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/cpia.c	Mon Apr  8 01:23:50 2002
@@ -2150,7 +2150,7 @@
 				if (current->need_resched)
 					schedule();
 
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 
 				/* sleep for 10 ms, hopefully ;) */
 				schedule_timeout(10*HZ/1000);
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/meye.c	Mon Apr  8 01:23:50 2002
@@ -968,17 +968,17 @@
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			add_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
 				schedule();
 				if(signal_pending(current)) {
 					remove_wait_queue(&meye.grabq.proc_list, &wait);
-					current->state = TASK_RUNNING;
+					set_current_state(TASK_RUNNING);
 					return -EINTR;
 				}
 			}
 			remove_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
@@ -1106,17 +1106,17 @@
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			add_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
 				schedule();
 				if(signal_pending(current)) {
 					remove_wait_queue(&meye.grabq.proc_list, &wait);
-					current->state = TASK_RUNNING;
+					set_current_state(TASK_RUNNING);
 					return -EINTR;
 				}
 			}
 			remove_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/msp3400.c	Mon Apr  8 01:23:50 2002
@@ -179,7 +179,7 @@
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
@@ -208,7 +208,7 @@
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
@@ -787,7 +787,7 @@
 		}
 
 		/* some time for the tuner to sync */
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/5);
 		if (signal_pending(current))
 			goto done;
@@ -817,7 +817,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			current->state   = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/10);
 			if (signal_pending(current))
 				goto done;
@@ -854,7 +854,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			current->state   = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/10);
 			if (signal_pending(current))
 				goto done;
@@ -1042,7 +1042,7 @@
 		}
 	
 		/* some time for the tuner to sync */
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/5);
 		if (signal_pending(current))
 			goto done;
@@ -1098,7 +1098,7 @@
 		} else {
 			/* triggered autodetect */
 			for (;;) {
-				current->state   = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(HZ/10);
 				if (signal_pending(current))
 					goto done;
diff -Nru a/drivers/media/video/planb.c b/drivers/media/video/planb.c
--- a/drivers/media/video/planb.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/planb.c	Mon Apr  8 01:23:50 2002
@@ -180,7 +180,7 @@
 	saa_write_reg (SAA7196_STDC, saa_regs[pb->win.norm][SAA7196_STDC]);
 
 	/* Let's wait 30msec for this one */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 #if LINUX_VERSION_CODE >= 0x02017F
 	schedule_timeout(30 * HZ / 1000);
 #else
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/saa5249.c	Mon Apr  8 01:23:50 2002
@@ -288,7 +288,7 @@
 	sigfillset(&current->blocked);
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(delay);
 
 	spin_lock_irq(&current->sigmask_lock);
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/tuner.c	Mon Apr  8 01:23:50 2002
@@ -756,7 +756,7 @@
                 printk("tuner: i2c i/o error: rc == %d (should be 4)\n",rc);
 
 	if (debug) {
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 		
 		if (tuner_islocked (c))
diff -Nru a/drivers/media/video/zr36120.c b/drivers/media/video/zr36120.c
--- a/drivers/media/video/zr36120.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/media/video/zr36120.c	Mon Apr  8 01:23:50 2002
@@ -821,7 +821,7 @@
          *      be sure its safe to free the buffer. We wait 5-6 fields
          *      which is more than sufficient to be sure.
          */
-        current->state = TASK_UNINTERRUPTIBLE;
+        set_current_state(TASK_UNINTERRUPTIBLE);
         schedule_timeout(HZ/10);        /* Wait 1/10th of a second */
 
 	/* free the allocated framebuffer */
@@ -1576,7 +1576,7 @@
          *      be sure its safe to free the buffer. We wait 5-6 fields
          *      which is more than sufficient to be sure.
          */
-        current->state = TASK_UNINTERRUPTIBLE;
+        set_current_state(TASK_UNINTERRUPTIBLE);
         schedule_timeout(HZ/10);        /* Wait 1/10th of a second */
 
 	for (item=ztv->readinfo; item!=ztv->readinfo+ZORAN_VBI_BUFFERS; item++)
diff -Nru a/drivers/message/i2o/i2o_core.c b/drivers/message/i2o/i2o_core.c
--- a/drivers/message/i2o/i2o_core.c	Mon Apr  8 01:23:50 2002
+++ b/drivers/message/i2o/i2o_core.c	Mon Apr  8 01:23:50 2002
@@ -579,7 +579,7 @@
 		if(!stat) {
 			int count = 10 * 100;
 			while(c->lct_running && --count) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(1);
 			}
 		
@@ -769,7 +769,7 @@
 		if((err=i2o_issue_claim(I2O_CMD_UTIL_RELEASE, d->controller, d->lct_data.tid, I2O_CLAIM_PRIMARY)) )
 		{
 			err = -ENXIO;
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(HZ);
 		}
 		else


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
