Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUHZIzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUHZIzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267927AbUHZIzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:55:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:30143 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267984AbUHZIzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:55:04 -0400
Subject: [PATCH] ppc32: PowerMac trackpad problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093510352.2172.155.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 18:52:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The trackpad on recent Apple laptops tend to emmit spurrious 'right clicks'
apparently. This patch from Alex Clausen fixes it, please apply. The trackpad
cannot normally emit a right click, so just filter those out.

Ben.


Signed-off-by: Alexander Clausen <alex@skip86.com>
Signed-off-by: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- drivers/macintosh/adbhid.c.orig	2004-03-10 23:41:43.000000000 +0100
+++ drivers/macintosh/adbhid.c		2004-03-10 23:41:34.000000000 +0100
@@ -327,7 +327,7 @@
 	input_report_key(&adbhid[id]->input, BTN_LEFT,   !((data[1] >> 7) & 1));
 	input_report_key(&adbhid[id]->input, BTN_MIDDLE, !((data[2] >> 7) & 1));

-	if (nb >= 4)
+	if (nb >= 4 && adbhid[id]->mouse_kind != ADBMOUSE_TRACKPAD)
 		input_report_key(&adbhid[id]->input, BTN_RIGHT,  !((data[3] >> 7) & 1));

 	input_report_rel(&adbhid[id]->input, REL_X,


