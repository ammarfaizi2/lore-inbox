Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTISTsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTISTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:47:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33956 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261700AbTISTr0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:47:26 -0400
Subject: [PATCH 4/5] Fix memory leak in hiddev.c found by Stanford Checker
In-Reply-To: <1064000835630@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 21:47:15 +0200
Message-Id: <10640008352154@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1353, 2003-09-19 13:32:38+02:00, vojtech@suse.cz
  input: Fix memory leak in hiddev.c found by Stanford Checker.


 hiddev.c |    1 +
 1 files changed, 1 insertion(+)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Fri Sep 19 14:12:42 2003
+++ b/drivers/usb/input/hiddev.c	Fri Sep 19 14:12:42 2003
@@ -727,6 +727,7 @@
  	retval = usb_register_dev(&hiddev->intf, &hiddev_class);
 	if (retval) {
 		err("Not able to get a minor for this device.");
+		kfree(hiddev);
 		return -1;
 	}
 

