Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTDIXOL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTDIXOL (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:14:11 -0400
Received: from palrel13.hp.com ([156.153.255.238]:37524 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263557AbTDIXOH (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 19:14:07 -0400
Date: Wed, 9 Apr 2003 16:25:46 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304092325.h39NPkSo012125@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] printk fixes for cs4281 driver
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes tons of type warnings in the cs4281 OSS
driver.  It simply uses %p and %Zu/%Zd where appropriate.  (I couldn't
identify a maintainer for this code; hope you're OK with applying it.)

	--david

diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Wed Apr  9 14:49:50 2003
+++ b/sound/oss/cs4281/cs4281m.c	Wed Apr  9 14:49:50 2003
@@ -1946,8 +1946,8 @@
 		len -= x;
 	}
 	CS_DBGOUT(CS_WAVE_WRITE, 4, printk(KERN_INFO
-		"cs4281: clear_advance(): memset %d at 0x%.8x for %d size \n",
-			(unsigned)c, (unsigned)((char *) buf) + bptr, len));
+		"cs4281: clear_advance(): memset %d at %p for %d size \n",
+			(unsigned)c, ((char *) buf) + bptr, len));
 	memset(((char *) buf) + bptr, c, len);
 }
 
@@ -1982,9 +1982,8 @@
 				wake_up(&s->dma_adc.wait);
 		}
 		CS_DBGOUT(CS_PARMS, 8, printk(KERN_INFO
-			"cs4281: cs4281_update_ptr(): s=0x%.8x hwptr=%d total_bytes=%d count=%d \n",
-				(unsigned)s, s->dma_adc.hwptr, 
-				s->dma_adc.total_bytes, s->dma_adc.count));
+			"cs4281: cs4281_update_ptr(): s=%p hwptr=%d total_bytes=%d count=%d \n",
+				s, s->dma_adc.hwptr, s->dma_adc.total_bytes, s->dma_adc.count));
 	}
 	// update DAC pointer 
 	//
@@ -2016,11 +2015,10 @@
 				// Continue to play silence until the _release.
 				//
 				CS_DBGOUT(CS_WAVE_WRITE, 6, printk(KERN_INFO
-					"cs4281: cs4281_update_ptr(): memset %d at 0x%.8x for %d size \n",
+					"cs4281: cs4281_update_ptr(): memset %d at %p for %d size \n",
 						(unsigned)(s->prop_dac.fmt & 
 						(AFMT_U8 | AFMT_U16_LE)) ? 0x80 : 0, 
-						(unsigned)s->dma_dac.rawbuf, 
-						s->dma_dac.dmasize));
+						s->dma_dac.rawbuf, s->dma_dac.dmasize));
 				memset(s->dma_dac.rawbuf,
 				       (s->prop_dac.
 					fmt & (AFMT_U8 | AFMT_U16_LE)) ?
@@ -2051,9 +2049,8 @@
 			}
 		}
 		CS_DBGOUT(CS_PARMS, 8, printk(KERN_INFO
-			"cs4281: cs4281_update_ptr(): s=0x%.8x hwptr=%d total_bytes=%d count=%d \n",
-				(unsigned) s, s->dma_dac.hwptr, 
-				s->dma_dac.total_bytes, s->dma_dac.count));
+			"cs4281: cs4281_update_ptr(): s=%p hwptr=%d total_bytes=%d count=%d \n",
+				s, s->dma_dac.hwptr, s->dma_dac.total_bytes, s->dma_dac.count));
 	}
 }
 
@@ -2184,8 +2181,7 @@
 
 	VALIDATE_STATE(s);
 	CS_DBGOUT(CS_FUNCTION, 4, printk(KERN_INFO
-		 "cs4281: mixer_ioctl(): s=0x%.8x cmd=0x%.8x\n",
-			 (unsigned) s, cmd));
+		 "cs4281: mixer_ioctl(): s=%p cmd=0x%.8x\n", s, cmd));
 #if CSDEBUG
 	cs_printioctl(cmd);
 #endif
@@ -2750,9 +2746,8 @@
 	CS_DBGOUT(CS_FUNCTION, 2,
 		  printk(KERN_INFO "cs4281: CopySamples()+ "));
 	CS_DBGOUT(CS_WAVE_READ, 8, printk(KERN_INFO
-		 " dst=0x%x src=0x%x count=%d iChannels=%d fmt=0x%x\n",
-			 (unsigned) dst, (unsigned) src, (unsigned) count,
-			 (unsigned) iChannels, (unsigned) fmt));
+		 " dst=%p src=%p count=%d iChannels=%d fmt=0x%x\n",
+			 dst, src, (unsigned) count, (unsigned) iChannels, (unsigned) fmt));
 
 	// Gershwin does format conversion in hardware so normally
 	// we don't do any host based coversion. The data formatter
@@ -2832,9 +2827,9 @@
 	void *src = hwsrc;	//default to the standard destination buffer addr
 
 	CS_DBGOUT(CS_FUNCTION, 6, printk(KERN_INFO
-		"cs_copy_to_user()+ fmt=0x%x fmt_o=0x%x cnt=%d dest=0x%.8x\n",
+		"cs_copy_to_user()+ fmt=0x%x fmt_o=0x%x cnt=%d dest=%p\n",
 			s->prop_adc.fmt, s->prop_adc.fmt_original,
-			(unsigned) cnt, (unsigned) dest));
+			(unsigned) cnt, dest));
 
 	if (cnt > s->dma_adc.dmasize) {
 		cnt = s->dma_adc.dmasize;
@@ -2879,7 +2874,7 @@
 	unsigned copied = 0;
 
 	CS_DBGOUT(CS_FUNCTION | CS_WAVE_READ, 2,
-		  printk(KERN_INFO "cs4281: cs4281_read()+ %d \n", count));
+		  printk(KERN_INFO "cs4281: cs4281_read()+ %Zu \n", count));
 
 	VALIDATE_STATE(s);
 	if (ppos != &file->f_pos)
@@ -2902,7 +2897,7 @@
 //
 	while (count > 0) {
 		CS_DBGOUT(CS_WAVE_READ, 8, printk(KERN_INFO
-			"_read() count>0 count=%d .count=%d .swptr=%d .hwptr=%d \n",
+			"_read() count>0 count=%Zu .count=%d .swptr=%d .hwptr=%d \n",
 				count, s->dma_adc.count,
 				s->dma_adc.swptr, s->dma_adc.hwptr));
 		spin_lock_irqsave(&s->lock, flags);
@@ -2959,11 +2954,10 @@
 		// the "cnt" is the number of bytes to read.
 
 		CS_DBGOUT(CS_WAVE_READ, 2, printk(KERN_INFO
-			"_read() copy_to cnt=%d count=%d ", cnt, count));
+			"_read() copy_to cnt=%d count=%Zu ", cnt, count));
 		CS_DBGOUT(CS_WAVE_READ, 8, printk(KERN_INFO
-			 " .dmasize=%d .count=%d buffer=0x%.8x ret=%d\n",
-				 s->dma_adc.dmasize, s->dma_adc.count,
-				 (unsigned) buffer, ret));
+			 " .dmasize=%d .count=%d buffer=%p ret=%Zd\n",
+				 s->dma_adc.dmasize, s->dma_adc.count, buffer, ret));
 
 		if (cs_copy_to_user
 		    (s, buffer, s->dma_adc.rawbuf + swptr, cnt, &copied))
@@ -2979,7 +2973,7 @@
 		start_adc(s);
 	}
 	CS_DBGOUT(CS_FUNCTION | CS_WAVE_READ, 2,
-		  printk(KERN_INFO "cs4281: cs4281_read()- %d\n", ret));
+		  printk(KERN_INFO "cs4281: cs4281_read()- %Zd\n", ret));
 	return ret;
 }
 
@@ -2995,7 +2989,7 @@
 	int cnt;
 
 	CS_DBGOUT(CS_FUNCTION | CS_WAVE_WRITE, 2,
-		  printk(KERN_INFO "cs4281: cs4281_write()+ count=%d\n",
+		  printk(KERN_INFO "cs4281: cs4281_write()+ count=%Zu\n",
 			 count));
 	VALIDATE_STATE(s);
 
@@ -3051,7 +3045,7 @@
 		start_dac(s);
 	}
 	CS_DBGOUT(CS_FUNCTION | CS_WAVE_WRITE, 2,
-		  printk(KERN_INFO "cs4281: cs4281_write()- %d\n", ret));
+		  printk(KERN_INFO "cs4281: cs4281_write()- %Zd\n", ret));
 	return ret;
 }
 
@@ -3172,8 +3166,7 @@
 	int val, mapped, ret;
 
 	CS_DBGOUT(CS_FUNCTION, 4, printk(KERN_INFO
-		 "cs4281: cs4281_ioctl(): file=0x%.8x cmd=0x%.8x\n",
-			 (unsigned) file, cmd));
+		 "cs4281: cs4281_ioctl(): file=%p cmd=0x%.8x\n", file, cmd));
 #if CSDEBUG
 	cs_printioctl(cmd);
 #endif
@@ -3603,8 +3596,8 @@
 	    (struct cs4281_state *) file->private_data;
 
 	CS_DBGOUT(CS_FUNCTION | CS_RELEASE, 2, printk(KERN_INFO
-		 "cs4281: cs4281_release(): inode=0x%.8x file=0x%.8x f_mode=%d\n",
-			 (unsigned) inode, (unsigned) file, file->f_mode));
+		 "cs4281: cs4281_release(): inode=%p file=%p f_mode=%d\n",
+			 inode, file, file->f_mode));
 
 	VALIDATE_STATE(s);
 
@@ -3638,8 +3631,8 @@
 	struct list_head *entry;
 
 	CS_DBGOUT(CS_FUNCTION | CS_OPEN, 2, printk(KERN_INFO
-		"cs4281: cs4281_open(): inode=0x%.8x file=0x%.8x f_mode=0x%x\n",
-			(unsigned) inode, (unsigned) file, file->f_mode));
+		"cs4281: cs4281_open(): inode=%p file=%p f_mode=0x%x\n",
+			inode, file, file->f_mode));
 
 	list_for_each(entry, &cs4281_devs)
 	{
@@ -4348,10 +4341,8 @@
 
 	CS_DBGOUT(CS_INIT, 2,
 		  printk(KERN_INFO
-			 "cs4281: probe() BA0=0x%.8x BA1=0x%.8x pBA0=0x%.8x pBA1=0x%.8x \n",
-			 (unsigned) temp1, (unsigned) temp2,
-			 (unsigned) s->pBA0, (unsigned) s->pBA1));
-
+			 "cs4281: probe() BA0=0x%.8x BA1=0x%.8x pBA0=%p pBA1=%p \n",
+			 (unsigned) temp1, (unsigned) temp2, s->pBA0, s->pBA1));
 	CS_DBGOUT(CS_INIT, 2,
 		  printk(KERN_INFO
 			 "cs4281: probe() pBA0phys=0x%.8x pBA1phys=0x%.8x\n",
@@ -4398,15 +4389,13 @@
 	if (pmdev)
 	{
 		CS_DBGOUT(CS_INIT | CS_PM, 4, printk(KERN_INFO
-			 "cs4281: probe() pm_register() succeeded (0x%x).\n",
-				(unsigned)pmdev));
+			 "cs4281: probe() pm_register() succeeded (%p).\n", pmdev));
 		pmdev->data = s;
 	}
 	else
 	{
 		CS_DBGOUT(CS_INIT | CS_PM | CS_ERROR, 0, printk(KERN_INFO
-			 "cs4281: probe() pm_register() failed (0x%x).\n",
-				(unsigned)pmdev));
+			 "cs4281: probe() pm_register() failed (%p).\n", pmdev));
 		s->pm.flags |= CS4281_PM_NOT_REGISTERED;
 	}
 #endif
diff -Nru a/sound/oss/cs4281/cs4281pm-24.c b/sound/oss/cs4281/cs4281pm-24.c
--- a/sound/oss/cs4281/cs4281pm-24.c	Wed Apr  9 14:49:49 2003
+++ b/sound/oss/cs4281/cs4281pm-24.c	Wed Apr  9 14:49:49 2003
@@ -46,8 +46,8 @@
 	struct cs4281_state *state;
 
 	CS_DBGOUT(CS_PM, 2, printk(KERN_INFO 
-		"cs4281: cs4281_pm_callback dev=0x%x rqst=0x%x state=%d\n",
-			(unsigned)dev,(unsigned)rqst,(unsigned)data));
+		"cs4281: cs4281_pm_callback dev=%p rqst=0x%x state=%p\n",
+			dev,(unsigned)rqst,data));
 	state = (struct cs4281_state *) dev->data;
 	if (state) {
 		switch(rqst) {
