Return-Path: <linux-kernel-owner+w=401wt.eu-S1754844AbXACHII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbXACHII (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbXACHII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:08:08 -0500
Received: from mail.queued.net ([207.210.101.209]:1923 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844AbXACHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:08:07 -0500
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 02:08:07 EST
Message-ID: <459B51C4.8040906@queued.net>
Date: Wed, 03 Jan 2007 01:48:36 -0500
From: Andres Salomon <dilinger@queued.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Andres Salomon <dilinger@debian.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split [01/03]
References: <457F822E.4040404@debian.org>	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org>	 <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>	 <45802D98.7030608@debian.org> <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com>
In-Reply-To: <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090807040306070004060504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807040306070004060504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
>>
>> Alright, I guess we're down to a matter of taste then.  I'll change the
>> patch to still have a monolithic psmouse that allows protocols to be
>> enabled/disabled via Kconfig.
>>
> 
> That'd be great. Thanks!
> 

Yikes, almost forgot to send this.  Here you go; 3 patches total.
Please let me know if there are any other change.  The first is attached.

--------------090807040306070004060504
Content-Type: text/plain;
 name="0001-Create-PS-2-protocol-options-for-Kconfig.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Create-PS-2-protocol-options-for-Kconfig.txt"

>From 3238fbc61c7879c38d750b710dd009560b815ab4 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@debian.org>
Date: Tue, 26 Dec 2006 16:24:57 -0500
Subject: [PATCH] Create PS/2 protocol options for Kconfig

Initial framework for disabling PS/2 protocol extensions.  The current
protocols can only be disabled if CONFIG_EMBEDDED is selected.  No source
files are changed w/ this patch, merely build stuff.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/Kconfig  |   50 ++++++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/Makefile |   22 ++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 35d998c..498930d 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -37,6 +37,56 @@ config MOUSE_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called psmouse.
 
+config MOUSE_PS2_ALPS
+	bool "ALPS PS/2 mouse protocol extension" if EMBEDDED
+	default y
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have an ALPS PS/2 touchpad connected to
+	  your system.
+
+	  If unsure, say Y.
+
+config MOUSE_PS2_LOGIPS2PP
+	bool "Logictech PS/2++ mouse protocol extension" if EMBEDDED
+	default y
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Logictech PS/2++ mouse connected to
+	  your system.
+
+	  If unsure, say Y.
+
+config MOUSE_PS2_SYNAPTICS
+	bool "Synaptics PS/2 mouse protocol extension" if EMBEDDED
+	default y
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Synaptics PS/2 TouchPad connected to
+	  your system.
+
+	  If unsure, say Y.
+
+config MOUSE_PS2_LIFEBOOK
+	bool "Fujitsu Lifebook PS/2 mouse protocol extension" if EMBEDDED
+	default y
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Fujitsu B-series Lifebook PS/2
+	  TouchScreen connected to your system.
+
+	  If unsure, say Y.
+
+config MOUSE_PS2_TRACKPOINT
+	bool "IBM Trackpoint PS/2 mouse protocol extension" if EMBEDDED
+	default y
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have an IBM Trackpoint PS/2 mouse connected
+	  to your system.
+
+	  If unsure, say Y.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	select SERIO
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 21a1de6..e7c7fbb 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -14,4 +14,24 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
+psmouse-objs := psmouse-base.o
+
+ifeq ($(CONFIG_MOUSE_PS2_ALPS),y)
+psmouse-objs += alps.o
+endif
+
+ifeq ($(CONFIG_MOUSE_PS2_LOGIPS2PP),y)
+psmouse-objs += logips2pp.o
+endif
+
+ifeq ($(CONFIG_MOUSE_PS2_SYNAPTICS),y)
+psmouse-objs += synaptics.o
+endif
+
+ifeq ($(CONFIG_MOUSE_PS2_LIFEBOOK),y)
+psmouse-objs += lifebook.o
+endif
+
+ifeq ($(CONFIG_MOUSE_PS2_TRACKPOINT),y)
+psmouse-objs += trackpoint.o
+endif
-- 
1.4.1


--------------090807040306070004060504--
