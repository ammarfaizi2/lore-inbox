Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUG2O4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUG2O4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUG2Ox7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:53:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:60821 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264770AbUG2OIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:06 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 3/47] Fix an oops in poll() on uinput.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101942422@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110194564@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1612.1.22, 2004-05-28 22:57:43+02:00, vojtech@suse.cz
  input: Fix an oops in poll() on uinput.  Thanks to Dmitry Torokhov
         for suggesting the fix.


 uinput.c |    3 +++
 1 files changed, 3 insertions(+)

===================================================================

diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Thu Jul 29 14:42:19 2004
+++ b/drivers/input/misc/uinput.c	Thu Jul 29 14:42:19 2004
@@ -279,6 +279,9 @@
 {
 	struct uinput_device *udev = file->private_data;
 
+	if (!test_bit(UIST_CREATED, &(udev->state)))
+		return -ENODEV;
+
 	poll_wait(file, &udev->waitq, wait);
 
 	if (udev->head != udev->tail)

