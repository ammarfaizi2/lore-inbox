Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291794AbSBTLvE>; Wed, 20 Feb 2002 06:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291795AbSBTLup>; Wed, 20 Feb 2002 06:50:45 -0500
Received: from mailf.telia.com ([194.22.194.25]:43988 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S291794AbSBTLuX>;
	Wed, 20 Feb 2002 06:50:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Typo in md.c
Date: Wed, 20 Feb 2002 12:48:53 +0100
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02022012485300.00631@jakob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo.

There's a small typo in drivers/md/md.c where detected_devices[] which should
be of the type kdev_t is wrongly typed as an int.

These are the only two references to detected_devices[]:

void md_autodetect_dev(kdev_t dev)
{
	if (dev_cnt >= 0 && dev_cnt < 127)
		detected_devices[dev_cnt++] = dev;
}

static void autostart_arrays(void)
{
	...

	for (i = 0; i < dev_cnt; i++) {
		kdev_t dev = detected_devices[i];

	...
}


Patch is included, please apply.

Regards,
	Jakob Kemi


--- md.c.orig	Tue Feb 19 14:08:15 2002
+++ md.c	Wed Feb 20 12:38:58 2002
@@ -3708,7 +3708,7 @@
  * Searches all registered partitions for autorun RAID arrays
  * at boot time.
  */
-static int detected_devices[128];
+static kdev_t detected_devices[128];
 static int dev_cnt;

 void md_autodetect_dev(kdev_t dev)
