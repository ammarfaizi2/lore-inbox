Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVLUC1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVLUC1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLUC1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:27:25 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:4931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932260AbVLUC1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nu8vknyV6tSJ/E1FnaKJcm98XhTppty6KoMmIQ4VOk2FWRwGO8VayK6jdiFgQL3i9wEHVU9PuV/wysrXe7fT7qBGCNAda+CoJFcBeI7+xFThTjrL8L4eBISIrcNvwAv2w5WH6RM37wGMCH4ntYO6YqJbMaxCpxLNuQCbsNJTEtA=
Message-ID: <489ecd0c0512201827i287e14dva548c77ec10bfc81@mail.gmail.com>
Date: Wed, 21 Dec 2005 10:27:23 +0800
From: Luke Yang <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix crc-error warning on modules
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   This is the patch for the following issue:

 In include/linux/module.h, "__crc_" and "__ksymtab_" are hard
coded to be the   prefix for some kinds of symbols (CRC symbol and
ksymtab section). But in script /mod/modpost.c,
MODULE_SYMBOL_PREFIX##"__crc_" is used as the prefix to search CRC
symbols. So if an architecture (such as h8300 or Blackfin) defines
MODULE_SYMBOL_PREFIX as not NULL ("_"), modpost will always warn about
"no invalid crc".
  And it is the same with KSYMTAB_PFX.

  Signed-off-by: Luke Yang <luke.adi@gmail.com>

Index: git/linux-2.6/scripts/mod/modpost.c
===================================================================
--- git.orig/linux-2.6/scripts/mod/modpost.c	2005-12-15 11:37:20.000000000 +0800
+++ git/linux-2.6/scripts/mod/modpost.c	2005-12-15 11:49:30.000000000 +0800
@@ -326,8 +326,8 @@
 	release_file(info->hdr, info->size);
 }

-#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
-#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
+#define CRC_PFX     "__crc_"
+#define KSYMTAB_PFX "__ksymtab_"

 void
 handle_modversions(struct module *mod, struct elf_info *info,

Best regards,
Luke Yang
Analog Device Inc.
