Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWCKFXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWCKFXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 00:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWCKFXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 00:23:42 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:54896 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750754AbWCKFXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 00:23:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Input: psmouse - disable autoresync
Date: Sat, 11 Mar 2006 00:23:38 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603110023.38863.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic resynchronization in psmouse driver causes problems on some
hardware so disable it by default for now. People with KVM switches
that require resync can still enable it via module parameter or sysfs
attribute.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Unfortunately I could not spend enouggh time during 2.6.16 cycle to resolve
all issues with the code so we better turn it off by default for now.
 

 drivers/input/mouse/psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -60,7 +60,7 @@ static unsigned int psmouse_resetafter =
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
-static unsigned int psmouse_resync_time = 5;
+static unsigned int psmouse_resync_time;
 module_param_named(resync_time, psmouse_resync_time, uint, 0644);
 MODULE_PARM_DESC(resync_time, "How long can mouse stay idle before forcing resync (in seconds, 0 = never).");
 
