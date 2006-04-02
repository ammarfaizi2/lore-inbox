Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWDBLCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDBLCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDBLCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:02:46 -0400
Received: from host-84-9-202-129.bulldogdsl.com ([84.9.202.129]:20319 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932323AbWDBLCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:02:46 -0400
Date: Sun, 2 Apr 2006 12:02:37 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: rpurdie@rpsys.net, akpm@osdl.org
Subject: [PATCH] leds: re-layout include/linux/leds.h
Message-ID: <20060402110237.GA1756@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Layout the structure definitions in include/linux/leds.h
to be aligned as much as possible. Also minor updates to
the comments to make them more concise.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2616-leds-include-layout.patch"

diff -urpN -X ../dontdiff linux-2.6.16-git20-bjd5/include/linux/leds.h linux-2.6.16-git20-bjd6/include/linux/leds.h
--- linux-2.6.16-git20-bjd5/include/linux/leds.h	2006-04-01 12:38:59.000000000 +0100
+++ linux-2.6.16-git20-bjd6/include/linux/leds.h	2006-04-02 11:57:43.000000000 +0100
@@ -19,39 +19,38 @@ struct class_device;
  */
 
 enum led_brightness {
-	LED_OFF = 0,
-	LED_HALF = 127,
-	LED_FULL = 255,
+	LED_OFF		= 0,
+	LED_HALF	= 127,
+	LED_FULL	= 255,
 };
 
 struct led_classdev {
-	const char *name;
-	int brightness;
-	int flags;
-#define LED_SUSPENDED       (1 << 0)
-
-	/* A function to set the brightness of the led */
-	void (*brightness_set)(struct led_classdev *led_cdev,
-				enum led_brightness brightness);
-
-	struct class_device *class_dev;
-	/* LED Device linked list */
-	struct list_head node;
+	const char		*name;
+	int			 brightness;
+	int			 flags;
+
+#define LED_SUSPENDED		(1 << 0)
+
+	/* Set LED brightness level */
+	void		(*brightness_set)(struct led_classdev *led_cdev,
+					  enum led_brightness brightness);
+
+	struct class_device	*class_dev;
+	struct list_head	 node;			/* LED Device list */
+	char			*default_trigger;	/* Trigger to use */
 
-	/* Trigger data */
-	char *default_trigger;
 #ifdef CONFIG_LEDS_TRIGGERS
-	rwlock_t trigger_lock;
 	/* Protects the trigger data below */
+	rwlock_t		 trigger_lock;
 
-	struct led_trigger *trigger;
-	struct list_head trig_list;
-	void *trigger_data;
+	struct led_trigger	*trigger;
+	struct list_head	 trig_list;
+	void			*trigger_data;
 #endif
 };
 
 extern int led_classdev_register(struct device *parent,
-				struct led_classdev *led_cdev);
+				 struct led_classdev *led_cdev);
 extern void led_classdev_unregister(struct led_classdev *led_cdev);
 extern void led_classdev_suspend(struct led_classdev *led_cdev);
 extern void led_classdev_resume(struct led_classdev *led_cdev);
@@ -65,16 +64,16 @@ extern void led_classdev_resume(struct l
 
 struct led_trigger {
 	/* Trigger Properties */
-	const char *name;
-	void (*activate)(struct led_classdev *led_cdev);
-	void (*deactivate)(struct led_classdev *led_cdev);
+	const char	 *name;
+	void		(*activate)(struct led_classdev *led_cdev);
+	void		(*deactivate)(struct led_classdev *led_cdev);
 
 	/* LEDs under control by this trigger (for simple triggers) */
-	rwlock_t leddev_list_lock;
-	struct list_head led_cdevs;
+	rwlock_t	  leddev_list_lock;
+	struct list_head  led_cdevs;
 
 	/* Link to next registered trigger */
-	struct list_head next_trig;
+	struct list_head  next_trig;
 };
 
 /* Registration functions for complex triggers */

--dDRMvlgZJXvWKvBx--
