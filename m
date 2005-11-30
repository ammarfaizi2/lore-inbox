Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVK3RfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVK3RfG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVK3RfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:35:05 -0500
Received: from 81-179-233-34.dsl.pipex.com ([81.179.233.34]:35023 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751482AbVK3RfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:35:04 -0500
Date: Wed, 30 Nov 2005 17:35:01 +0000
To: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 2/2] powerpc powermac adb fix udbg_adb_use_btext warning
Message-ID: <20051130173501.GA863@shadowen.org>
References: <exportbomb.1133372080@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1133372080@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc: powermac, adb fix udbg_adb_use_btext warning

When compiling without BOOTX_TEXT the following warning is emitted.
Fix up the definition to only be made when required.

      CC      arch/powerpc/platforms/powermac/udbg_adb.o
    .../arch/powerpc/platforms/powermac/udbg_adb.c:41: warning:
		`udbg_adb_use_btext' defined but not used

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/arch/powerpc/platforms/powermac/udbg_adb.c current/arch/powerpc/platforms/powermac/udbg_adb.c
--- reference/arch/powerpc/platforms/powermac/udbg_adb.c
+++ current/arch/powerpc/platforms/powermac/udbg_adb.c
@@ -38,8 +38,6 @@ static enum {
 	input_adb_cuda,
 } input_type = input_adb_none;
 
-static int udbg_adb_use_btext;
-
 int xmon_wants_key, xmon_adb_keycode;
 
 static inline void udbg_adb_poll(void)
@@ -55,6 +53,8 @@ static inline void udbg_adb_poll(void)
 }
 
 #ifdef CONFIG_BOOTX_TEXT
+
+static int udbg_adb_use_btext;
 static int xmon_adb_shiftstate;
 
 static unsigned char xmon_keytab[128] =
