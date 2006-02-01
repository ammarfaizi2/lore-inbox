Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWBAFJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWBAFJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWBAFJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:10 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:60054 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030316AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050733.960326000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 06/18] grip: fix crash when accessing device
Content-Disposition: inline; filename=grip-fix-oops.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: grip - fix crash when accessing device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/grip.c |    3 +++
 1 files changed, 3 insertions(+)

Index: work/drivers/input/joystick/grip.c
===================================================================
--- work.orig/drivers/input/joystick/grip.c
+++ work/drivers/input/joystick/grip.c
@@ -192,6 +192,9 @@ static void grip_poll(struct gameport *g
 	for (i = 0; i < 2; i++) {
 
 		dev = grip->dev[i];
+		if (!dev)
+			continue;
+
 		grip->reads++;
 
 		switch (grip->mode[i]) {

