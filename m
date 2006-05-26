Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWEZQdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWEZQdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWEZQ3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:29:32 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:29857 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751064AbWEZQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:29:24 -0400
Message-Id: <20060526162908.472832000@gmail.com>
References: <20060526161129.557416000@gmail.com>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 19:11:39 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 10/13] input: update documentation of force feedback
Content-Disposition: inline; filename=ff-refactoring-documentation.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the force feedback documentation in ff.txt and input.h.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 Documentation/input/ff.txt |   96 ++++++++++++++++++++-------------------------
 include/linux/input.h      |   12 +++++
 2 files changed, 54 insertions(+), 54 deletions(-)

Index: linux-2.6.17-rc4-git12/Documentation/input/ff.txt
===================================================================
--- linux-2.6.17-rc4-git12.orig/Documentation/input/ff.txt	2006-05-26 17:57:14.000000000 +0300
+++ linux-2.6.17-rc4-git12/Documentation/input/ff.txt	2006-05-26 18:48:22.000000000 +0300
@@ -1,27 +1,27 @@
 Force feedback for Linux.
 By Johann Deneux <deneux@ifrance.com> on 2001/04/22.
+Updated by Anssi Hannula <anssi.hannula@gmail.com> on 2006/04/09.
 You may redistribute this file. Please remember to include shape.fig and
 interactive.fig as well.
 ----------------------------------------------------------------------------
 
-0. Introduction
+1. Introduction
 ~~~~~~~~~~~~~~~
 This document describes how to use force feedback devices under Linux. The
 goal is not to support these devices as if they were simple input-only devices
 (as it is already the case), but to really enable the rendering of force
 effects.
-At the moment, only I-Force devices are supported, and not officially. That
-means I had to find out how the protocol works on my own. Of course, the
-information I managed to grasp is far from being complete, and I can not
-guarranty that this driver will work for you.
-This document only describes the force feedback part of the driver for I-Force
-devices. Please read joystick.txt before reading further this document.
+This document only describes the force feedback part of the Linux input
+interface. Please read joystick.txt and input.txt before reading further this
+document.
 
 2. Instructions to the user
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Here are instructions on how to compile and use the driver. In fact, this
-driver is the normal iforce, input and evdev drivers written by Vojtech
-Pavlik, plus additions to support force feedback.
+To enable force feedback, you have to
+1. have your kernel configured with evdev and force feedback effects enabled
+   with a driver that supports your device.
+2. make sure evdev module is loaded and /dev/input/event* device files are
+   created.
 
 Before you start, let me WARN you that some devices shake violently during the
 initialisation phase. This happens for example with my "AVB Top Shot Pegasus".
@@ -29,39 +29,8 @@ To stop this annoying behaviour, move yo
 should keep a hand on your device, in order to avoid it to brake down if
 something goes wrong.
 
-At the kernel's compilation:
-	- Enable IForce/Serial
-	- Enable Event interface
-
-Compile the modules, install them.
-
-You also need inputattach.
-
-You then need to insert the modules into the following order:
-% modprobe joydev
-% modprobe serport		# Only for serial
-% modprobe iforce
-% modprobe evdev
-% ./inputattach -ifor $2 &	# Only for serial
-If you are using USB, you don't need the inputattach step.
-
-Please check that you have all the /dev/input entries needed:
-cd /dev
-rm js*
-mkdir input
-mknod input/js0 c 13 0
-mknod input/js1 c 13 1
-mknod input/js2 c 13 2
-mknod input/js3 c 13 3
-ln -s input/js0 js0
-ln -s input/js1 js1
-ln -s input/js2 js2
-ln -s input/js3 js3
-
-mknod input/event0 c 13 64
-mknod input/event1 c 13 65
-mknod input/event2 c 13 66
-mknod input/event3 c 13 67
+If you have a serial iforce device, you need to start inputattach. See
+joystick.txt for details.
 
 2.1 Does it work ?
 ~~~~~~~~~~~~~~~~~~
@@ -86,18 +55,29 @@ int ioctl(int file_descriptor, int reque
 
 Returns the features supported by the device. features is a bitfield with the
 following bits:
-- FF_X		has an X axis (usually joysticks)
-- FF_Y		has an Y axis (usually joysticks)
-- FF_WHEEL	has a wheel (usually sterring wheels)
 - FF_CONSTANT	can render constant force effects
-- FF_PERIODIC	can render periodic effects (sine, triangle, square...)
+- FF_PERIODIC	can render periodic effects with the following waveforms:
+  - FF_SQUARE	  square waveform
+  - FF_TRIANGLE	  triangle waveform
+  - FF_SINE	  sine waveform
+  - FF_SAW_UP	  sawtooth up waveform
+  - FF_SAW_DOWN	  sawtooth down waveform
+  - FF_CUSTOM	  custom waveform
 - FF_RAMP       can render ramp effects
 - FF_SPRING	can simulate the presence of a spring
 - FF_FRICTION	can simulate friction 
 - FF_DAMPER	can simulate damper effects
-- FF_RUMBLE	rumble effects (normally the only effect supported by rumble
-		pads)
+- FF_RUMBLE	rumble effects
 - FF_INERTIA    can simulate inertia
+- FF_GAIN	gain is adjustable
+- FF_AUTOCENTER	autocenter is adjustable
+
+Note: In most cases you should use FF_PERIODIC instead of FF_RUMBLE. All
+      devices that support FF_RUMBLE support FF_PERIODIC (square, triangle,
+      sine) and the other way around.
+
+Note: The exact syntax FF_CUSTOM is undefined for the time being as no driver
+      supports it yet.
 
 
 int ioctl(int fd, EVIOCGEFFECTS, int *n);
@@ -120,6 +100,9 @@ to the unique id assigned by the driver.
 some operations (removing an effect, controlling the playback).
 This if field must be set to -1 by the user in order to tell the driver to
 allocate a new effect.
+
+Effects are file descriptor specific.
+
 See <linux/input.h> for a description of the ff_effect struct. You should also
 find help in a few sketches, contained in files shape.fig and interactive.fig.
 You need xfig to visualize these files.
@@ -128,8 +111,8 @@ You need xfig to visualize these files.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 int ioctl(int fd, EVIOCRMFF, effect.id);
 
-This makes room for new effects in the device's memory. Please note this won't
-stop the effect if it was playing.
+This makes room for new effects in the device's memory. Note that this also
+stops the effect if it was playing.
 
 3.4 Controlling the playback of effects
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -163,8 +146,7 @@ Control of playing is done with write().
 ~~~~~~~~~~~~~~~~~~~~
 Not all devices have the same strength. Therefore, users should set a gain
 factor depending on how strong they want effects to be. This setting is
-persistent across access to the driver, so you should not care about it if
-you are writing games, as another utility probably already set this for you.
+persistent across access to the driver.
 
 /* Set the gain of the device
 int gain;		/* between 0 and 100 */
@@ -204,9 +186,17 @@ type of device, not all parameters can b
 the direction of an effect cannot be updated with iforce devices. In this
 case, the driver stops the effect, up-load it, and restart it.
 
+Therefore it is recommended to dynamically change direction while the effect
+is playing only when it is ok to restart the effect with a replay count of 1.
 
 3.8 Information about the status of effects
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+NOTE: This is deprecated and should not be used. It applies only to iforce
+      devices and is provided for backward-compatibility only. If you have a
+      really good reason to use this, please contact
+      linux-joystick@atrey.karlin.mff.cuni.cz or anssi.hannula@gmail.com
+      so that support for it can be added to all drivers.
+
 Every time the status of an effect is changed, an event is sent. The values
 and meanings of the fields of the event are as follows:
 struct input_event {
Index: linux-2.6.17-rc4-git12/include/linux/input.h
===================================================================
--- linux-2.6.17-rc4-git12.orig/include/linux/input.h	2006-05-26 17:57:14.000000000 +0300
+++ linux-2.6.17-rc4-git12/include/linux/input.h	2006-05-26 18:47:21.000000000 +0300
@@ -672,8 +672,14 @@ struct input_absinfo {
  * They are sub-structures of the actually sent structure (called ff_effect)
  */
 
+/*
+ * All time duration values are expressed in ms.
+ * Time values above 32767ms (0x7fff) should not be used and have unspecified
+ * results depending on device.
+ */
+
 struct ff_replay {
-	__u16 length; /* Duration of an effect in ms. All other times are also expressed in ms */
+	__u16 length; /* Duration of an effect in ms */
 	__u16 delay;  /* Time to wait before to start playing an effect */
 };
 
@@ -683,6 +689,10 @@ struct ff_trigger {
 };
 
 struct ff_envelope {
+	/* The attack_level and fade_level are absolute values of the level,
+	i.e. if the default magnitude is negative the envelope level is
+	also seen as an absolute value of a below-zero value */
+	/* Therefore the valid level range is from 0x0000 to 0x7fff */
 	__u16 attack_length;	/* Duration of attack (ms) */
 	__u16 attack_level;	/* Level at beginning of attack */
 	__u16 fade_length;	/* Duration of fade (ms) */

--
Anssi Hannula
