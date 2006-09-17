Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWIQBrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWIQBrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIQBrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:53 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:49349 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932171AbWIQBrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:46 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 11] sound core: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 7e68f25a3e0ce32d102c9342a8b0a4d890303d0a
Message-Id: <7e68f25a3e0ce32d102c.1158455374@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:34 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound core: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 1622a39ffb54 -r 7e68f25a3e0c sound/core/info.c
--- a/sound/core/info.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/sound/core/info.c	Sat Sep 16 21:00:45 2006 -0400
@@ -174,15 +174,15 @@ static loff_t snd_info_entry_llseek(stru
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		switch (orig) {
-		case 0:	/* SEEK_SET */
+		case SEEK_SET:
 			file->f_pos = offset;
 			ret = file->f_pos;
 			goto out;
-		case 1:	/* SEEK_CUR */
+		case SEEK_CUR:
 			file->f_pos += offset;
 			ret = file->f_pos;
 			goto out;
-		case 2:	/* SEEK_END */
+		case SEEK_END:
 		default:
 			ret = -EINVAL;
 			goto out;


