Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbSKWGMg>; Sat, 23 Nov 2002 01:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbSKWGMg>; Sat, 23 Nov 2002 01:12:36 -0500
Received: from 12-241-212-92.client.attbi.com ([12.241.212.92]:43906 "EHLO
	stinkycat.com") by vger.kernel.org with ESMTP id <S266978AbSKWGMg>;
	Sat, 23 Nov 2002 01:12:36 -0500
Date: Fri, 22 Nov 2002 21:56:12 -0800
From: Rusty Lynch <rusty@stinkycat.com>
Message-Id: <200211230556.gAN5uC631843@stinkycat.com>
To: esr@thyrsus.com
Subject: [Tiny PATCH]driver/char/Kconfig bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VT support requires drivers/char/keyboard.c which makes function
calls implemented in drivers/input/, so that attempting to set
CONFIG_INPUT=m or just not setting CONFIG_INPUT will result in a 
compile error if CONFIG_VT is on.

Here is a trivial patch against 2.5.49.

	-rustyl

--- drivers/char/Kconfig.orig	2002-11-22 22:05:29.000000000 -0800
+++ drivers/char/Kconfig	2002-11-22 22:03:56.000000000 -0800
@@ -6,6 +6,7 @@
 
 config VT
 	bool "Virtual terminal"
+	requires INPUT=y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
