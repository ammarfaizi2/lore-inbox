Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVBXXeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVBXXeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVBXXdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:33:15 -0500
Received: from guru.webcon.ca ([216.194.67.26]:59337 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S262559AbVBXX33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:29:29 -0500
Date: Thu, 24 Feb 2005 18:29:26 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ALPS tapping disabled. WHY?
Message-ID: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying out 2.6.11-rc5, I discovered my ALPS touchpad misbehaving. After
reading several threads related to the topic, noe seemed to resolve my
issue.

The pad has always worked fine as a plain PS/2 mouse, from 2.4.0 through
2.6.10.

This change fixes the problem by NOT disabling hardware tapping:

--- linux-2.6.11-rc5/drivers/input/mouse/alps.c~	2005-02-24 18:16:03.000000000 -0500
+++ linux-2.6.11-rc5/drivers/input/mouse/alps.c	2005-02-24 18:16:03.000000000 -0500
@@ -334,8 +334,8 @@
  	if (alps_get_status(psmouse, param))
  		return -1;

-	if (param[0] & 0x04)
-		alps_tap_mode(psmouse, 0);
+//	if (param[0] & 0x04)
+//		alps_tap_mode(psmouse, 0);

  	if (alps_absolute_mode(psmouse)) {
  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
@@ -372,11 +372,11 @@
  		return -1;
  	}

-	if (param[0] & 0x04) {
-		printk(KERN_INFO "  Disabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, 0))
-			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
-	}
+//	if (param[0] & 0x04) {
+//		printk(KERN_INFO "  Disabling hardware tapping\n");
+//		if (alps_tap_mode(psmouse, 0))
+//			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
+//	}

  	if (alps_absolute_mode(psmouse)) {
  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");



So now, can anyone explain what bit 3 of param[0] does, and why you would
want to disable hardware tapping support when it's set? My pad (ALPS
56AAA1760C on a Sager NP8560V) has always worked with hardware tapping as a
plain PS/2 mouse, no special ALPS support req'd.

Can this disabling of hardware tapping support be made optional (boot time
param or other)? I don't want to have to patch every kernel from here on
out.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
  Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
  imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
     *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
