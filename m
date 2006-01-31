Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWAaNlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWAaNlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWAaNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:41:32 -0500
Received: from tim.rpsys.net ([194.106.48.114]:61586 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750821AbWAaNla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:41:30 -0500
Subject: [PATCH 1/11] LED Class Documentation
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 13:41:25 +0000
Message-Id: <1138714885.6869.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some brief documentation of the design decisions behind the LED 
class and how it appears to users.

Signed-off-by Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/Documentation/leds-class.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/Documentation/leds-class.txt	2006-01-31 12:42:59.000000000 +0000
@@ -0,0 +1,71 @@
+LED handling under Linux
+========================
+
+If you're reading this and thinking about keyboard leds, these are 
+handled by the input subsystem and the led class is *not* needed.
+
+In its simplest form, the LED class just allows control of LEDs from 
+userspace. LEDs appear in /sys/class/leds/. The brightness file will 
+set the brightness of the LED (taking a value 0-255). Most LEDs don't
+have hardware brightness support so will just be turned on for none zero
+brightness settings.
+
+The class also introduces the optional concept of an LED trigger. A trigger 
+is a kernel based source of led events. Triggers can either be simple or 
+complex. A simple trigger isn't configurable and is designed to slot into 
+existing subsystems with minimal additional code. Examples are the ide-disk, 
+nand-disk and sharpsl-charge triggers. With led triggers disabled, the code 
+optimises away.
+
+Complex triggers whilst available to all LEDs have LED specific
+parameters and work on a per LED basis. The timer trigger is an example.
+
+You can change triggers in a similar manner to the way an IO scheduler
+is chosen (via /sys/class/leds/<device>/trigger). Trigger specific 
+parameters can appear in /sys/class/leds/<device> once a given trigger is 
+selected.
+
+
+Design Philosophy
+=================
+
+The underlying design philosophy is simplicity. LEDs are simple devices 
+and the aim is to keep a small amount of code giving as much functionality 
+as possible.  Please keep this in mind when suggesting enhancements.
+
+
+LED Device Naming
+=================
+
+Is currently of the form:
+
+"devicename:colour"
+
+There have been calls for LED properties such as colour to be exported as 
+individual led class attributes. As a solution which doesn't incur as much 
+overhead, I suggest these become part of the device name. The naming scheme 
+above leaves scope for further attributes should they be needed.
+
+
+Known Issues
+============
+
+The LED Trigger core cannot be a module as the simple trigger functions
+would cause nightmare dependency issues. I see this as a minor issue
+compared to the benefits the simple trigger functionality brings. The
+rest of the LED subsystem can be modular.
+
+Some leds can be programmed to flash in hardware. As this isn't a generic 
+LED device property, this should be exported as a device specific sysfs 
+attribute rather than part of the class if this functionality is required.
+
+
+Future Development
+==================
+
+At the moment, a trigger can't be created specifically for a single LED.
+There are a number of cases where a trigger might only be mappable to a
+particular LED (ACPI?). The addition of triggers provided by the LED driver
+should cover this option and be possible to add without breaking the
+current interface.
+


