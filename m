Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTISK2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTISK1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:08 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20878 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261498AbTISK0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:53 -0400
Subject: [PATCH 11/11] input: Claim serio early in serio_open()
In-Reply-To: <10639672023022@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:42 +0200
Message-Id: <10639672022754@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1349, 2003-09-19 01:25:39-07:00, dtor_core@ameritech.net
  serio.c:
    claim serio early in serio_open()


 serio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Fri Sep 19 12:15:39 2003
+++ b/drivers/input/serio/serio.c	Fri Sep 19 12:15:39 2003
@@ -229,9 +229,11 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
-	if (serio->open(serio))
-		return -1;
 	serio->dev = dev;
+	if (serio->open(serio)) {
+		serio->dev = NULL;
+		return -1;
+	}
 	return 0;
 }
 

