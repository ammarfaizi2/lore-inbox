Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFGNIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFGNIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUFGMTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:19:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17025 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264635AbUFGL4h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:37 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093551747@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093551505@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:55 +0200
Subject: [PATCH 36/39] input: Fix an oops at opentime of /dev/input/event devices
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.539.2, 2004-05-14 10:23:53+02:00, async@cc.gatech.edu
  evdev.c:
    input: Fix an oops at opentime of /dev/input/event devices


 evdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-06-07 13:10:32 +02:00
+++ b/drivers/input/evdev.c	2004-06-07 13:10:32 +02:00
@@ -126,7 +126,7 @@
 	int i = iminor(inode) - EVDEV_MINOR_BASE;
 	int accept_err;
 
-	if (i >= EVDEV_MINORS || !evdev_table[i])
+	if (i >= EVDEV_MINORS || !evdev_table[i] || !evdev_table[i]->exist)
 		return -ENODEV;
 
 	if ((accept_err = input_accept_process(&(evdev_table[i]->handle), file)))
@@ -175,7 +175,7 @@
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(list->evdev->wait,
-		list->head != list->tail && list->evdev->exist);
+		list->head != list->tail || (!list->evdev->exist));
 
 	if (retval)
 		return retval;

