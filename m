Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTDLGxg (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 02:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTDLGxg (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 02:53:36 -0400
Received: from [196.41.29.142] ([196.41.29.142]:61426 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263178AbTDLGxe (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 02:53:34 -0400
Subject: VT and VT_CONSOLE not present with menuconfig if INPUT=m  (was:
	2.5.67+ BK-current fails to boot on Athlon MP)
From: Martin Schlemmer <azarah@gentoo.org>
To: Krishnakumar B <kitty@cse.wustl.edu>
Cc: KML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <16023.20727.42247.824975@samba.doc.wustl.edu>
References: <16023.20727.42247.824975@samba.doc.wustl.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050130858.2754.77.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 12 Apr 2003 09:00:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 01:34, Krishnakumar B wrote:
> Hi,
> 
> I am trying to get 2.5.x to boot on my new Athlon 2400+ MP box. For some
> reason, the kernel doesn't progress beyond
> 
> Uncompressing Linux...Ok, booting the kernel.
> 

You need 'Virtual terminal' and 'Console on VT' enabled:

$ grep VT .config
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
$


But this brings me to the main issue .. any reason why you need
to have INPUT=y to be able to select CONFIG_VT and CONFIG_VT_CONSOLE ?
If INPUT=m for instance, it is not present ...

Won't it be better to make CONFIG_INPUT a bool (only y or n), as with
this setup, you can still compile the other input drivers as modules ..

------------------------------------------------------------------------
--- 1/drivers/input/Kconfig	2003-04-12 08:53:33.000000000 +0200
+++ 2/drivers/input/Kconfig	2003-04-12 09:00:17.000000000 +0200
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)"
+	bool "Input devices (needed for keyboard, mouse, ...)"
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -19,11 +19,6 @@
 
 	  If unsure, say Y.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called input. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
------------------------------------------------------------------------

Sorry, I am not sure who does this bit, so I CC'd Andrew as well, as
I want to remember that he did some changes to VT and SERIAL console
in the past.


Regards,

-- 
Martin Schlemmer


