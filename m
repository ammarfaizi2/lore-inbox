Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUFGMOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUFGMOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUFGMNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:13:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6017 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264584AbUFGL43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:29 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093532639@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093531825@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 19/39] input: Trailing whitespace fixes
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.26, 2004-04-23 02:50:49-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes


 drivers/input/input.c                      |   40 ++++++++---------
 drivers/input/misc/98spkr.c                |    4 -
 drivers/input/misc/pcspkr.c                |    4 -
 drivers/input/misc/sparcspkr.c             |    8 +--
 drivers/input/misc/uinput.c                |   50 ++++++++++-----------
 drivers/input/touchscreen/gunze.c          |    2 
 drivers/input/touchscreen/h3600_ts_input.c |   66 ++++++++++++++---------------
 include/linux/input.h                      |    2 
 8 files changed, 88 insertions(+), 88 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/input.c	2004-06-07 13:12:08 +02:00
@@ -106,7 +106,7 @@
 			}
 
 			break;
-		
+
 		case EV_ABS:
 
 			if (code > ABS_MAX || !test_bit(code, dev->absbit))
@@ -144,27 +144,27 @@
 			if (code > MSC_MAX || !test_bit(code, dev->mscbit))
 				return;
 
-			if (dev->event) dev->event(dev, type, code, value);	
-	
+			if (dev->event) dev->event(dev, type, code, value);
+
 			break;
 
 		case EV_LED:
-	
+
 			if (code > LED_MAX || !test_bit(code, dev->ledbit) || !!test_bit(code, dev->led) == value)
 				return;
 
 			change_bit(code, dev->led);
-			if (dev->event) dev->event(dev, type, code, value);	
-	
+			if (dev->event) dev->event(dev, type, code, value);
+
 			break;
 
 		case EV_SND:
-	
+
 			if (code > SND_MAX || !test_bit(code, dev->sndbit))
 				return;
 
-			if (dev->event) dev->event(dev, type, code, value);	
-	
+			if (dev->event) dev->event(dev, type, code, value);
+
 			break;
 
 		case EV_REP:
@@ -181,7 +181,7 @@
 			break;
 	}
 
-	if (type != EV_SYN) 
+	if (type != EV_SYN)
 		dev->sync = 0;
 
 	if (dev->grab)
@@ -282,11 +282,11 @@
 		if (id->flags & INPUT_DEVICE_ID_MATCH_VENDOR)
 			if (id->id.vendor != dev->id.vendor)
 				continue;
-	
+
 		if (id->flags & INPUT_DEVICE_ID_MATCH_PRODUCT)
 			if (id->id.product != dev->id.product)
 				continue;
-		
+
 		if (id->flags & INPUT_DEVICE_ID_MATCH_VERSION)
 			if (id->id.version != dev->id.version)
 				continue;
@@ -351,11 +351,11 @@
 	}
 	if (in_interrupt()) {
 		printk(KERN_ERR "input.c: calling hotplug from interrupt\n");
-		return; 
+		return;
 	}
 	if (!current->fs->root) {
 		printk(KERN_WARNING "input.c: calling hotplug without valid filesystem\n");
-		return; 
+		return;
 	}
 	if (!(envp = (char **) kmalloc(20 * sizeof(char *), GFP_KERNEL))) {
 		printk(KERN_ERR "input.c: not enough memory allocating hotplug environment\n");
@@ -381,17 +381,17 @@
 
 	envp[i++] = scratch;
 	scratch += sprintf(scratch, "PRODUCT=%x/%x/%x/%x",
-		dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version) + 1; 
-	
+		dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version) + 1;
+
 	if (dev->name) {
 		envp[i++] = scratch;
-		scratch += sprintf(scratch, "NAME=%s", dev->name) + 1; 
+		scratch += sprintf(scratch, "NAME=%s", dev->name) + 1;
 	}
 
 	if (dev->phys) {
 		envp[i++] = scratch;
-		scratch += sprintf(scratch, "PHYS=%s", dev->phys) + 1; 
-	}	
+		scratch += sprintf(scratch, "PHYS=%s", dev->phys) + 1;
+	}
 
 	SPRINTF_BIT_A(evbit, "EV=", EV_MAX);
 	SPRINTF_BIT_A2(keybit, "KEY=", KEY_MAX, EV_KEY);
@@ -506,7 +506,7 @@
 		input_table[handler->minor >> 5] = handler;
 
 	list_add_tail(&handler->node, &input_handler_list);
-	
+
 	list_for_each_entry(dev, &input_dev_list, node)
 		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
 			if ((id = input_match_device(handler->id_table, dev)))
diff -Nru a/drivers/input/misc/98spkr.c b/drivers/input/misc/98spkr.c
--- a/drivers/input/misc/98spkr.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/misc/98spkr.c	2004-06-07 13:12:08 +02:00
@@ -41,11 +41,11 @@
 		case SND_BELL: if (value) value = 1000;
 		case SND_TONE: break;
 		default: return -1;
-	} 
+	}
 
 	if (value > 20 && value < 32767)
 		count = CLOCK_TICK_RATE / value;
-	
+
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
 	if (count) {
diff -Nru a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
--- a/drivers/input/misc/pcspkr.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/misc/pcspkr.c	2004-06-07 13:12:08 +02:00
@@ -40,11 +40,11 @@
 		case SND_BELL: if (value) value = 1000;
 		case SND_TONE: break;
 		default: return -1;
-	} 
+	}
 
 	if (value > 20 && value < 32767)
 		count = CLOCK_TICK_RATE / value;
-	
+
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
 	if (count) {
diff -Nru a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
--- a/drivers/input/misc/sparcspkr.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/misc/sparcspkr.c	2004-06-07 13:12:08 +02:00
@@ -53,11 +53,11 @@
 		case SND_BELL: if (value) value = 1000;
 		case SND_TONE: break;
 		default: return -1;
-	} 
+	}
 
 	if (value > 20 && value < 32767)
 		count = 1193182 / value;
-	
+
 	spin_lock_irqsave(&beep_lock, flags);
 
 	/* EBUS speaker only has on/off state, the frequency does not
@@ -108,11 +108,11 @@
 		case SND_BELL: if (value) value = 1000;
 		case SND_TONE: break;
 		default: return -1;
-	} 
+	}
 
 	if (value > 20 && value < 32767)
 		count = 1193182 / value;
-	
+
 	spin_lock_irqsave(&beep_lock, flags);
 
 	if (count) {
diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/misc/uinput.c	2004-06-07 13:12:08 +02:00
@@ -18,7 +18,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
- * 
+ *
  * Changes/Revisions:
  *	0.1	20/06/2002
  *		- first public version
@@ -68,7 +68,7 @@
 static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
 {
 	return 0;
-}					
+}
 
 static int uinput_create_device(struct uinput_device *udev)
 {
@@ -123,7 +123,7 @@
 	memset(newinput, 0, sizeof(struct input_dev));
 
 	newdev->dev = newinput;
-	
+
 	file->private_data = newdev;
 
 	return 0;
@@ -137,16 +137,16 @@
 {
 	unsigned int cnt;
 	int retval = 0;
-	
+
 	for (cnt = 0; cnt < ABS_MAX; cnt++) {
-		if (!test_bit(cnt, dev->absbit)) 
+		if (!test_bit(cnt, dev->absbit))
 			continue;
-		
+
 		if (/*!dev->absmin[cnt] || !dev->absmax[cnt] || */
 		    (dev->absmax[cnt] <= dev->absmin[cnt])) {
-			printk(KERN_DEBUG 
+			printk(KERN_DEBUG
 				"%s: invalid abs[%02x] min:%d max:%d\n",
-				UINPUT_NAME, cnt, 
+				UINPUT_NAME, cnt,
 				dev->absmin[cnt], dev->absmax[cnt]);
 			retval = -EINVAL;
 			break;
@@ -154,7 +154,7 @@
 
 		if ((dev->absflat[cnt] < dev->absmin[cnt]) ||
 		    (dev->absflat[cnt] > dev->absmax[cnt])) {
-			printk(KERN_DEBUG 
+			printk(KERN_DEBUG
 				"%s: absflat[%02x] out of range: %d "
 				"(min:%d/max:%d)\n",
 				UINPUT_NAME, cnt, dev->absflat[cnt],
@@ -190,7 +190,7 @@
 		goto exit;
 	}
 
-	if (NULL != dev->name) 
+	if (NULL != dev->name)
 		kfree(dev->name);
 
 	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
@@ -229,7 +229,7 @@
 static ssize_t uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device	*udev = file->private_data;
-	
+
 	if (test_bit(UIST_CREATED, &(udev->state))) {
 		struct input_event	ev;
 
@@ -247,7 +247,7 @@
 {
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
-	
+
 	if (!test_bit(UIST_CREATED, &(udev->state)))
 		return -ENODEV;
 
@@ -255,16 +255,16 @@
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(udev->waitq,
-			(udev->head != udev->tail) || 
+			(udev->head != udev->tail) ||
 			!test_bit(UIST_CREATED, &(udev->state)));
-	
+
 	if (retval)
 		return retval;
 
 	if (!test_bit(UIST_CREATED, &(udev->state)))
 		return -ENODEV;
 
-	while ((udev->head != udev->tail) && 
+	while ((udev->head != udev->tail) &&
 	    (retval + sizeof(struct input_event) <= count)) {
 		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
 		    sizeof(struct input_event))) return -EFAULT;
@@ -284,7 +284,7 @@
 	if (udev->head != udev->tail)
 		return POLLIN | POLLRDNORM;
 
-	return 0;			
+	return 0;
 }
 
 static int uinput_burn_device(struct uinput_device *udev)
@@ -318,7 +318,7 @@
 		case UI_DEV_CREATE:
 			retval = uinput_create_device(udev);
 			break;
-			
+
 		case UI_DEV_DESTROY:
 			retval = uinput_destroy_device(udev);
 			break;
@@ -330,7 +330,7 @@
 			}
 			set_bit(arg, udev->dev->evbit);
 			break;
-			
+
 		case UI_SET_KEYBIT:
 			if (arg > KEY_MAX) {
 				retval = -EINVAL;
@@ -338,7 +338,7 @@
 			}
 			set_bit(arg, udev->dev->keybit);
 			break;
-			
+
 		case UI_SET_RELBIT:
 			if (arg > REL_MAX) {
 				retval = -EINVAL;
@@ -346,7 +346,7 @@
 			}
 			set_bit(arg, udev->dev->relbit);
 			break;
-			
+
 		case UI_SET_ABSBIT:
 			if (arg > ABS_MAX) {
 				retval = -EINVAL;
@@ -354,7 +354,7 @@
 			}
 			set_bit(arg, udev->dev->absbit);
 			break;
-			
+
 		case UI_SET_MSCBIT:
 			if (arg > MSC_MAX) {
 				retval = -EINVAL;
@@ -362,7 +362,7 @@
 			}
 			set_bit(arg, udev->dev->mscbit);
 			break;
-			
+
 		case UI_SET_LEDBIT:
 			if (arg > LED_MAX) {
 				retval = -EINVAL;
@@ -370,7 +370,7 @@
 			}
 			set_bit(arg, udev->dev->ledbit);
 			break;
-			
+
 		case UI_SET_SNDBIT:
 			if (arg > SND_MAX) {
 				retval = -EINVAL;
@@ -378,7 +378,7 @@
 			}
 			set_bit(arg, udev->dev->sndbit);
 			break;
-			
+
 		case UI_SET_FFBIT:
 			if (arg > FF_MAX) {
 				retval = -EINVAL;
@@ -386,7 +386,7 @@
 			}
 			set_bit(arg, udev->dev->ffbit);
 			break;
-			
+
 		default:
 			retval = -EFAULT;
 	}
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/touchscreen/gunze.c	2004-06-07 13:12:08 +02:00
@@ -124,7 +124,7 @@
 	memset(gunze, 0, sizeof(struct gunze));
 
 	init_input_dev(&gunze->dev);
-	gunze->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	gunze->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	gunze->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 	gunze->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
 
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:12:08 +02:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:12:08 +02:00
@@ -1,11 +1,11 @@
 /*
  * $Id: h3600_ts_input.c,v 1.4 2002/01/23 06:39:37 jsimmons Exp $
  *
- *  Copyright (c) 2001 "Crazy" James Simmons jsimmons@transvirtual.com 
+ *  Copyright (c) 2001 "Crazy" James Simmons jsimmons@transvirtual.com
  *
- *  Sponsored by Transvirtual Technology. 
- * 
- *  Derived from the code in h3600_ts.[ch] by Charles Flynn  
+ *  Sponsored by Transvirtual Technology.
+ *
+ *  Derived from the code in h3600_ts.[ch] by Charles Flynn
  */
 
 /*
@@ -75,7 +75,7 @@
 #define MAX_ID                  14
 
 #define H3600_MAX_LENGTH 16
-#define H3600_KEY 0xf 
+#define H3600_KEY 0xf
 
 #define H3600_SCANCODE_RECORD	1	 /* 1 -> record button */
 #define H3600_SCANCODE_CALENDAR 2	 /* 2 -> calendar */
@@ -118,13 +118,13 @@
         int down = (GPLR & GPIO_BITSY_NPOWER_BUTTON) ? 0 : 1;
 	struct input_dev *dev = (struct input_dev *) dev_id;
 
-	/* 
-	 * This interrupt is only called when we release the key. So we have 
+	/*
+	 * This interrupt is only called when we release the key. So we have
 	 * to fake a key press.
-	 */ 	
+	 */
 	input_regs(dev, regs);
 	input_report_key(dev, KEY_SUSPEND, 1);
-	input_report_key(dev, KEY_SUSPEND, down); 	
+	input_report_key(dev, KEY_SUSPEND, down);
 	input_sync(dev);
 }
 
@@ -144,18 +144,18 @@
 	unsigned char brightness = ((pwr==FLITE_PWR_OFF) ? 0:flite_brightness);
 	struct h3600_dev *ts = dev->private;
 
-	/* Must be in this order */	
+	/* Must be in this order */
        	ts->serio->write(ts->serio, 1);
 	ts->serio->write(ts->serio, pwr);
-      	ts->serio->write(ts->serio, brightness); 
+      	ts->serio->write(ts->serio, brightness);
 	return 0;
 }
 
 static int suspended = 0;
-static int h3600ts_pm_callback(struct pm_dev *pm_dev, pm_request_t req, 
+static int h3600ts_pm_callback(struct pm_dev *pm_dev, pm_request_t req,
 				void *data)
 {
-	struct input_dev *dev = (struct input_dev *) data;	
+	struct input_dev *dev = (struct input_dev *) data;
 
         switch (req) {
         case PM_SUSPEND: /* enter D1-D3 */
@@ -183,7 +183,7 @@
 /*
  * This function translates the native event packets to linux input event
  * packets. Some packets coming from serial are not touchscreen related. In
- * this case we send them off to be processed elsewhere. 
+ * this case we send them off to be processed elsewhere.
  */
 static void h3600ts_process_packet(struct h3600_dev *ts, struct pt_regs *regs)
 {
@@ -206,7 +206,7 @@
                 Note: This is true for non interrupt generated key events.
                 */
                 case KEYBD_ID:
-			down = (ts->buf[0] & 0x80) ? 0 : 1; 
+			down = (ts->buf[0] & 0x80) ? 0 : 1;
 
 			switch (ts->buf[0] & 0x7f) {
 				case H3600_SCANCODE_RECORD:
@@ -218,7 +218,7 @@
 				case H3600_SCANCODE_CONTACTS:
 					key = KEY_PROG2;
                                         break;
-				case H3600_SCANCODE_Q:        
+				case H3600_SCANCODE_Q:
 					key = KEY_Q;
                                         break;
 				case H3600_SCANCODE_START:
@@ -237,9 +237,9 @@
 					key = KEY_DOWN;
                                         break;
 				default:
-					key = 0;	
-			}	
-                        if (key) 
+					key = 0;
+			}
+                        if (key)
                         	input_report_key(dev, key, down);
                         break;
                 /*
@@ -251,13 +251,13 @@
                  *       byte 0    1       2       3
                  */
                 case TOUCHS_ID:
-			if (!touched) { 
+			if (!touched) {
 				input_report_key(dev, BTN_TOUCH, 1);
 				touched = 1;
-			}			
+			}
 
 			if (ts->len) {
-				unsigned short x, y;				
+				unsigned short x, y;
 
 				x = ts->buf[0]; x <<= 8; x += ts->buf[1];
                                 y = ts->buf[2]; y <<= 8; y += ts->buf[3];
@@ -267,7 +267,7 @@
 			} else {
 		               	input_report_key(dev, BTN_TOUCH, 0);
 				touched = 0;
-			}	
+			}
                         break;
 		default:
 			/* Send a non input event elsewhere */
@@ -280,7 +280,7 @@
 /*
  * h3600ts_event() handles events from the input module.
  */
-static int h3600ts_event(struct input_dev *dev, unsigned int type, 
+static int h3600ts_event(struct input_dev *dev, unsigned int type,
 		 	 unsigned int code, int value)
 {
 	struct h3600_dev *ts = dev->private;
@@ -290,7 +290,7 @@
 		//	ts->serio->write(ts->serio, SOME_CMD);
 			return 0;
 		}
-	}					
+	}
 	return -1;
 }
 
@@ -323,12 +323,12 @@
         struct h3600_dev *ts = serio->private;
 
 	/*
-         * We have a new frame coming in. 
+         * We have a new frame coming in.
          */
 	switch (state) {
 		case STATE_SOF:
         		if (data == CHAR_SOF)
-                		state = STATE_ID;	
+                		state = STATE_ID;
 			return;
         	case STATE_ID:
 			ts->event = (data & 0xf0) >> 4;
@@ -344,7 +344,7 @@
 		case STATE_DATA:
 			ts->chksum += data;
 			ts->buf[ts->idx]= data;
-			if(++ts->idx == ts->len) 
+			if(++ts->idx == ts->len)
                         	state = STATE_EOF;
 			break;
 		case STATE_EOF:
@@ -382,7 +382,7 @@
         set_GPIO_IRQ_edge( GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE );
 
         if (request_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, action_button_handler,
-			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,	
+			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
 			"h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		kfree(ts);
@@ -390,7 +390,7 @@
 	}
 
         if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
-			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM, 
+			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
 			"h3600_suspend", &ts->dev)) {
 		free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
@@ -400,7 +400,7 @@
 	/* Now we have things going we setup our input device */
 	ts->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_LED) | BIT(EV_PWR);
 	ts->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
-	ts->dev.ledbit[0] = BIT(LED_SLEEP); 
+	ts->dev.ledbit[0] = BIT(LED_SLEEP);
 
 	ts->dev.absmin[ABS_X] = 60;   ts->dev.absmin[ABS_Y] = 35;
 	ts->dev.absmax[ABS_X] = 985; ts->dev.absmax[ABS_Y] = 1024;
@@ -442,7 +442,7 @@
 
 	//h3600_flite_control(1, 25);     /* default brightness */
 #ifdef CONFIG_PM
-	ts->dev.pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT, 
+	ts->dev.pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT,
 					h3600ts_pm_callback);
 	printk("registered pm callback\n");
 #endif
@@ -458,7 +458,7 @@
 static void h3600ts_disconnect(struct serio *serio)
 {
 	struct h3600_dev *ts = serio->private;
-	
+
         free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
         free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
 	input_unregister_device(&ts->dev);
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2004-06-07 13:12:08 +02:00
+++ b/include/linux/input.h	2004-06-07 13:12:08 +02:00
@@ -655,7 +655,7 @@
 	struct ff_envelope envelope;
 
 /* Only used if waveform == FF_CUSTOM */
-	__u32 custom_len;	/* Number of samples  */	
+	__u32 custom_len;	/* Number of samples */
 	__s16 *custom_data;	/* Buffer of samples */
 /* Note: the data pointed by custom_data is copied by the driver. You can
  * therefore dispose of the memory after the upload/update */

