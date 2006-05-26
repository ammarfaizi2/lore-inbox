Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWEZQ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWEZQ3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWEZQ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:29:31 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:28324 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751065AbWEZQ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:29:25 -0400
Message-Id: <20060526162910.769727000@gmail.com>
References: <20060526161129.557416000@gmail.com>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 19:11:42 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 13/13] input: use -ENOSPC instead of -ENOMEM in iforce when device full
Content-Disposition: inline; filename=ff-refactoring-iforce-enomem-to-enospc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use -ENOSPC instead of -ENOMEM when the iforce device doesn't have enough free
memory for the new effect. All other drivers are already been using -ENOSPC,
so this makes the behaviour coherent.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/iforce/iforce-ff.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:55:12.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:57:13.000000000 +0300
@@ -47,7 +47,7 @@ static int make_magnitude_modifier(struc
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
 			mutex_unlock(&iforce->mem_mutex);
-			return -ENOMEM;
+			return -ENOSPC;
 		}
 		mutex_unlock(&iforce->mem_mutex);
 	}
@@ -80,7 +80,7 @@ static int make_period_modifier(struct i
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
 			mutex_unlock(&iforce->mem_mutex);
-			return -ENOMEM;
+			return -ENOSPC;
 		}
 		mutex_unlock(&iforce->mem_mutex);
 	}
@@ -120,7 +120,7 @@ static int make_envelope_modifier(struct
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
 			mutex_unlock(&iforce->mem_mutex);
-			return -ENOMEM;
+			return -ENOSPC;
 		}
 		mutex_unlock(&iforce->mem_mutex);
 	}
@@ -157,7 +157,7 @@ static int make_condition_modifier(struc
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
 			mutex_unlock(&iforce->mem_mutex);
-			return -ENOMEM;
+			return -ENOSPC;
 		}
 		mutex_unlock(&iforce->mem_mutex);
 	}

--
Anssi Hannula
