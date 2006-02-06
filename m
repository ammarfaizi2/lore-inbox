Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWBFLfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWBFLfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWBFLfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:35:14 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:21471 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751019AbWBFLfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:35:13 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon,  6 Feb 2006 12:34:40 +0100
Subject: Re: [PATCH 0/12] LED Class, Triggers and Drivers
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, dirk@opfer-online.de,
       jbowler@acm.org
In-reply-to: <1139154718.6438.78.camel@localhost.localdomain>
Message-Id: <20060206113440.B65CF22AEF3@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
>This is an updated version of the LED class/subsystem. The main change
>is the renamed API - I've settled on led_device -> led_classdev. Other
>minor issues like the error cases in the timer trigger were also fixed.
Seems good, but some issues:
Use more macros
	struct led_classdev *led_cdev = dev->class_data;
	pdev->resource[i].start, pdev->resource...
__init and __exit
	static int __devinit ixp4xxgpioled_init(void)
	static void ixp4xxgpioled_exit(void)
	static void nand_base_exit(void)
	tosaled_{init,exit}, corgiled_{init,exit}, spitzled_{init,exit}
coding style
	static void __exit timer_trig_exit (void)
	static inline void led_set_brightness(struct led_classdev *led_cdev, enum led_brightness value) -- more than 80 columns
+			led_cdev->trigger->deactivate(led_cdev);
+
+	}
	ixp4xxgpioled_brightness_set -- a little bit ugly
+static int apply_to_all_leds(struct platform_device *pdev,
+	void (*operation)(struct led_classdev *pled)) {
{ on the next line

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
