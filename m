Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWDCRV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWDCRV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWDCRV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:21:58 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43036 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932363AbWDCRV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:21:57 -0400
Date: Mon, 3 Apr 2006 19:21:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 3/9] s390: invalid check after kzalloc()
Message-ID: <20060403172155.GC11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 3/9] s390: invalid check after kzalloc()

Typo. After the call to kzalloc() for kdb->key_maps the test
for NULL checks the wrong variable.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/keyboard.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/keyboard.c linux-2.6-patched/drivers/s390/char/keyboard.c
--- linux-2.6/drivers/s390/char/keyboard.c	2006-04-03 18:46:20.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/keyboard.c	2006-04-03 18:46:36.000000000 +0200
@@ -54,7 +54,7 @@ kbd_alloc(void) {
 	if (!kbd)
 		goto out;
 	kbd->key_maps = kzalloc(sizeof(key_maps), GFP_KERNEL);
-	if (!key_maps)
+	if (!kbd->key_maps)
 		goto out_kbd;
 	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
 		if (key_maps[i]) {
