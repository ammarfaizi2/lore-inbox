Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757149AbWKVXMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbWKVXMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757155AbWKVXMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:12:19 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:24022 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1757149AbWKVXMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:12:18 -0500
Date: Wed, 22 Nov 2006 15:12:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dmitry.torokhov@gmail.com, akpm <akpm@osdl.org>
Subject: [PATCH 2/2] input: add to kernel-api docbook
Message-Id: <20061122151219.e2661828.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Add input subsystem to kernel-api docbook.
Enhance some function and parameter comments.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/kernel-api.tmpl |    8 ++++++++
 drivers/input/ff-core.c               |    4 ++--
 drivers/input/ff-memless.c            |    2 +-
 drivers/input/input.c                 |    2 +-
 include/linux/input.h                 |   18 +++++++++---------
 5 files changed, 21 insertions(+), 13 deletions(-)

--- linux-2619-rc6g4.orig/include/linux/input.h
+++ linux-2619-rc6g4/include/linux/input.h
@@ -663,7 +663,7 @@ struct input_absinfo {
 #define BUS_GSC			0x1A
 
 /*
- * Values describing the status of an effect
+ * Values describing the status of a force-feedback effect
  */
 #define FF_STATUS_STOPPED	0x00
 #define FF_STATUS_PLAYING	0x01
@@ -680,7 +680,7 @@ struct input_absinfo {
  */
 
 /**
- * struct ff_replay - defines scheduling of the effect
+ * struct ff_replay - defines scheduling of the force-feedback effect
  * @length: duration of the effect
  * @delay: delay before effect should start playing
  */
@@ -690,7 +690,7 @@ struct ff_replay {
 };
 
 /**
- * struct ff_trigger - defines what triggers the effect
+ * struct ff_trigger - defines what triggers the force-feedback effect
  * @button: number of the button triggering the effect
  * @interval: controls how soon the effect can be re-triggered
  */
@@ -700,7 +700,7 @@ struct ff_trigger {
 };
 
 /**
- * struct ff_envelope - generic effect envelope
+ * struct ff_envelope - generic force-feedback effect envelope
  * @attack_length: duration of the attack (ms)
  * @attack_level: level at the beginning of the attack
  * @fade_length: duration of fade (ms)
@@ -719,7 +719,7 @@ struct ff_envelope {
 };
 
 /**
- * struct ff_constant_effect - defines parameters of a constant effect
+ * struct ff_constant_effect - defines parameters of a constant force-feedback effect
  * @level: strength of the effect; may be negative
  * @envelope: envelope data
  */
@@ -729,7 +729,7 @@ struct ff_constant_effect {
 };
 
 /**
- * struct ff_ramp_effect - defines parameters of a ramp effect
+ * struct ff_ramp_effect - defines parameters of a ramp force-feedback effect
  * @start_level: beginning strength of the effect; may be negative
  * @end_level: final strength of the effect; may be negative
  * @envelope: envelope data
@@ -741,7 +741,7 @@ struct ff_ramp_effect {
 };
 
 /**
- * struct ff_condition_effect - defines a spring or friction effect
+ * struct ff_condition_effect - defines a spring or friction force-feedback effect
  * @right_saturation: maximum level when joystick moved all way to the right
  * @left_saturation: same for the left side
  * @right_coeff: controls how fast the force grows when the joystick moves
@@ -762,7 +762,7 @@ struct ff_condition_effect {
 };
 
 /**
- * struct ff_periodic_effect - defines parameters of a periodic effect
+ * struct ff_periodic_effect - defines parameters of a periodic force-feedback effect
  * @waveform: kind of the effect (wave)
  * @period: period of the wave (ms)
  * @magnitude: peak value
@@ -793,7 +793,7 @@ struct ff_periodic_effect {
 };
 
 /**
- * struct ff_rumble_effect - defines parameters of a periodic effect
+ * struct ff_rumble_effect - defines parameters of a periodic force-feedback effect
  * @strong_magnitude: magnitude of the heavy motor
  * @weak_magnitude: magnitude of the light one
  *
--- linux-2619-rc6g4.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2619-rc6g4/Documentation/DocBook/kernel-api.tmpl
@@ -559,4 +559,12 @@ X!Idrivers/video/console/fonts.c
 -->
      </sect1>
   </chapter>
+
+  <chapter id="input_subsystem">
+     <title>Input Subsystem</title>
+!Iinclude/linux/input.h
+!Edrivers/input/input.c
+!Edrivers/input/ff-core.c
+!Edrivers/input/ff-memless.c
+  </chapter>
 </book>
--- linux-2619-rc6g4.orig/drivers/input/ff-core.c
+++ linux-2619-rc6g4/drivers/input/ff-core.c
@@ -203,7 +203,7 @@ static int erase_effect(struct input_dev
 }
 
 /**
- * input_ff_erase - erase an effect from device
+ * input_ff_erase - erase a force-feedback effect from device
  * @dev: input device to erase effect from
  * @effect_id: id of the ffect to be erased
  * @file: purported owner of the request
@@ -347,7 +347,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
 
 /**
  * input_ff_free() - frees force feedback portion of input device
- * @dev: input device supporintg force feedback
+ * @dev: input device supporting force feedback
  *
  * This function is only needed in error path as input core will
  * automatically free force feedback structures when device is
--- linux-2619-rc6g4.orig/drivers/input/ff-memless.c
+++ linux-2619-rc6g4/drivers/input/ff-memless.c
@@ -460,7 +460,7 @@ static void ml_ff_destroy(struct ff_devi
 }
 
 /**
- * input_ff_create_memless() - create memoryless FF device
+ * input_ff_create_memless() - create memoryless force-feedback device
  * @dev: input device supporting force-feedback
  * @data: driver-specific data to be passed into @play_effect
  * @play_effect: driver-specific method for playing FF effect
--- linux-2619-rc6g4.orig/drivers/input/input.c
+++ linux-2619-rc6g4/drivers/input/input.c
@@ -37,7 +37,7 @@ static struct input_handler *input_table
 
 /**
  * input_event() - report new input event
- * @handle: device that generated the event
+ * @dev: device that generated the event
  * @type: type of the event
  * @code: event code
  * @value: value of the event


---
