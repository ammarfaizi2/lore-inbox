Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWISDYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWISDYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWISDYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:24:24 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:25098 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1751869AbWISDYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:24:23 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] leds: turn LED off when changing triggers
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
Date: Tue, 19 Sep 2006 15:21:00 +1200
Message-ID: <87u034y21v.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I was playing with LED triggers when I noticed that changing from
heartbeat (or ide-disk) to "none" at the right moment would leave the
LED stuck on.  This is easy to reproduce by doing "find / >/dev/null"
with the ide-disk trigger enabled and then switching to "none".

Here is a patch that fixes the problem by explicitly turning the LED
off after removing the existing trigger.

Signed-off-by: Paul Collins <paul@ondioline.org>

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 47f0ff1..454fb09 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -125,6 +125,7 @@ void led_trigger_set(struct led_classdev
 		write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock, flags);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
+		led_set_brightness(led_cdev, LED_OFF);
 	}
 	if (trigger) {
 		write_lock_irqsave(&trigger->leddev_list_lock, flags);


-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
