Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUFFQWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUFFQWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUFFQWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:22:52 -0400
Received: from may.priocom.com ([213.156.65.50]:45190 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263790AbUFFQWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:22:43 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in SliceBlock()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538992.2793.94.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:23:12 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in SliceBlock()

 ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c |    4 ++++
 1 files changed, 4 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/char/drm/sis_ds.c
./linux-2.6.6-modified/drivers/char/drm/sis_ds.c
--- ./linux-2.6.6/drivers/char/drm/sis_ds.c	Mon May 10 05:33:19 2004
+++ ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c	Wed Jun  2 14:19:22
2004
@@ -231,6 +231,8 @@ static TMemBlock* SliceBlock(TMemBlock *
 	if (startofs > p->ofs) {
 		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
 		    DRM_MEM_DRIVER);
+		if (!newblock)
+			return NULL;
 		newblock->ofs = startofs;
 		newblock->size = p->size - (startofs - p->ofs);
 		newblock->free = 1;
@@ -244,6 +246,8 @@ static TMemBlock* SliceBlock(TMemBlock *
 	if (size < p->size) {
 		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
 		    DRM_MEM_DRIVER);
+		if (!newblock)
+			return NULL;
 		newblock->ofs = startofs + size;
 		newblock->size = p->size - size;
 		newblock->free = 1;

-- 
umka

