Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTL1RL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTL1RL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:11:58 -0500
Received: from 12-211-64-253.client.attbi.com ([12.211.64.253]:47751 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S261758AbTL1RLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:11:55 -0500
Message-ID: <3FEF0EDA.7090502@comcast.net>
Date: Sun, 28 Dec 2003 09:11:54 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH:  Alternate pdcraid superblock finder
Content-Type: multipart/mixed;
 boundary="------------040500050902050304010702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040500050902050304010702
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch proposes an alternate method of finding the raid superblock on
Promise raid devices. It hasn't received much testing, so I left the old routine
intact and just check for ideinfo->head == 255 to use my method. I'm not aware
of any reasons why my method wouldn't work for all drives, but I thought this
was a safer change.

-Walt Holman


--------------040500050902050304010702
Content-Type: text/plain;
 name="pdcraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21-xfs/linux/drivers/ide/raid/pdcraid.c	2003-12-22 17:59:09.653139067 -0800
+++ linux/drivers/ide/raid/pdcraid.c	2003-07-21 20:47:14.000000000 -0700
@@ -361,7 +361,11 @@
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-	lba = lba * (ideinfo->head*ideinfo->sect);
-	lba = lba - ideinfo->sect;
+	if (ideinfo->head!=255) {
+		lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+		lba = lba * (ideinfo->head*ideinfo->sect);
+		lba = lba - ideinfo->sect; }
+	else {
+		lba = ideinfo->capacity - ideinfo->sect;
+	}
 
 	return lba;


--------------040500050902050304010702--


