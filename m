Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWHLRUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWHLRUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWHLRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:20:19 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:49093 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S964860AbWHLRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:20:17 -0400
Message-ID: <44DE0DCE.4090305@bonetmail.com>
Date: Sat, 12 Aug 2006 19:20:14 +0200
From: Jani Aho <jani.aho@bonetmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sensors broke between 2.6.16.16 and 2.6.16.17
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The sensors on my motherboard stopped working between 2.6.16.16 and
2.6.16.17. The latest kernel version I have tried is 2.6.17.8 and it
still has the same problem.

The motherboard is an ASUS P4PE and it uses the asb100 and i2c-i801
modules to get sensor information.

A diff in /sys between a bad (2.6.17.8) and a good (2.6.16.16) kernel gives:

--- i2c.bad     2006-08-12 18:42:57.000000000 +0200
+++ i2c.good    2006-08-12 18:50:44.000000000 +0200
@@ -37,9 +37,15 @@
 /sys/module/i2c_core/sections/.text
 /sys/module/i2c_core/refcnt
 /sys/class/i2c-adapter
+/sys/class/i2c-adapter/i2c-0
+/sys/class/i2c-adapter/i2c-0/device
+/sys/class/i2c-adapter/i2c-0/uevent
 /sys/bus/i2c
 /sys/bus/i2c/drivers
 /sys/bus/i2c/drivers/asb100
+/sys/bus/i2c/drivers/asb100/0-0048
+/sys/bus/i2c/drivers/asb100/0-0049
+/sys/bus/i2c/drivers/asb100/0-002d
 /sys/bus/i2c/drivers/asb100/bind
 /sys/bus/i2c/drivers/asb100/unbind
 /sys/bus/i2c/drivers/asb100/module
@@ -48,3 +54,85 @@
 /sys/bus/i2c/drivers/i2c_adapter/unbind
 /sys/bus/i2c/drivers/i2c_adapter/module
 /sys/bus/i2c/devices
+/sys/bus/i2c/devices/0-0048
+/sys/bus/i2c/devices/0-0049
+/sys/bus/i2c/devices/0-002d
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/name
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/bus
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/driver
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power/wakeup
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power/state
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/uevent
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/name
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/bus
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/driver
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power/wakeup
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power/state
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/uevent
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/pwm1_enable
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/pwm1
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/alarms
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/vrm
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/cpu0_vid
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_max_hyst
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_max_hyst
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_max_hyst
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_max_hyst
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_div
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_div
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_div
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_max
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_min
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_input
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/hwmon:hwmon0
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/name
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/bus
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/driver
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power/wakeup
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power/state
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/uevent
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/i2c-adapter:i2c-0
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/name
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power/wakeup
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power/state
+/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/uevent

I run an updated Debian Sid distro.

Thanks,
Jani
