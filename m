Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKFFrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKFFrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 00:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVKFFrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 00:47:04 -0500
Received: from thunk.org ([69.25.196.29]:3481 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750737AbVKFFrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 00:47:04 -0500
To: linux-kernel@vger.kernel.org
Subject: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1EYdMs-0001hI-3F@think.thunk.org>
Date: Sun, 06 Nov 2005 00:47:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I upgraded to 2.6.14 from 2.6.14-rc5, my X server failed to stop.  
Investigation revealed it was because my CorePointer was the Synaptics
driver, and the device corresponding to the Synaptics touchpad
(/dev/input/event2 on my laptop) was not being created.  Once I manually
created the device with the proper major/minor device numbers, X started
correctly.

A comparison of "udevinfo -e" on 2.6.14-rc5 and 2.5.14 reveals the
following differences.  Was this change deliberate?  And can it be
reverted?

Thanks, 

						- Ted


--- udevinfo-2.6.14-rc5	2005-11-06 00:17:06.000000000 -0500
+++ udevinfo-2.6.14	2005-11-06 00:22:42.000000000 -0500
@@ -86,27 +86,15 @@
 P: /class/cpuid/cpu0
 N: cpu/0/cpuid
 
-P: /class/input/event0
-N: input/event0
-
-P: /class/input/event1
-N: input/event1
-
-P: /class/input/event2
-N: input/event2
-
-P: /class/input/event3
+P: /class/input/input3/event3
 N: input/event3
 
+P: /class/input/input3/mouse1
+N: input/mouse1
+
 P: /class/input/mice
 N: input/mice
 
-P: /class/input/mouse0
-N: input/mouse0
-
-P: /class/input/mouse1
-N: input/mouse1
-
 P: /class/misc/device-mapper
 N: mapper/control
 
