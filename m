Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVDDGOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVDDGOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDDGOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:14:12 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:41820 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261317AbVDDGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:14:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/4] serio resume fix
Date: Mon, 4 Apr 2005 01:11:11 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>,
       InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200504040110.13315.dtor_core@ameritech.net>
In-Reply-To: <200504040110.13315.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040111.11814.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: serio - do not attempt to immediately disconnect port if
       resume failed, let kseriod take care of it. Otherwise we
       may attempt to unregister associated input devices which
       will generate hotplug events which are not handled well
       during swsusp.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |    1 -
 1 files changed, 1 deletion(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -779,7 +779,6 @@ static int serio_resume(struct device *d
 	struct serio *serio = to_serio_port(dev);
 
 	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
-		serio_disconnect_port(serio);
 		/*
 		 * Driver re-probing can take a while, so better let kseriod
 		 * deal with it.
