Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWBHGtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWBHGtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBHGtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:49:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31875 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161008AbWBHGmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:43 -0500
Message-Id: <20060208064858.656191000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 07/23] Input: grip - fix crash when accessing device
Content-Disposition: inline; filename=grip-fix-crash-when-accessing-device.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

   
grip - fix crash when accessing device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/joystick/grip.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15.3/drivers/input/joystick/grip.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/joystick/grip.c
+++ linux-2.6.15.3/drivers/input/joystick/grip.c
@@ -192,6 +192,9 @@ static void grip_poll(struct gameport *g
 	for (i = 0; i < 2; i++) {
 
 		dev = grip->dev[i];
+		if (!dev)
+			continue;
+
 		grip->reads++;
 
 		switch (grip->mode[i]) {

--
