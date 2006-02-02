Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWBBAn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWBBAn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWBBAn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:43:26 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:37277
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S1751495AbWBBAn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:43:26 -0500
Date: Thu, 2 Feb 2006 00:43:06 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] xquad_portio fix declaration missmatch
Message-ID: <20060202004306.GA32466@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xquad_portio fix declaration missmatch

It seems that the latest gcc-4.x sees the inconsistancy between the 
export of and static declaration of xquad_portio where previous versions
have not.  Fix it up.

  arch/i386/boot/compressed/misc.c:125: error: static declaration of
				'xquad_portio' follows non-static declaration
  include/asm/io.h:315: error: previous declaration of 'xquad_portio' was here

Against: 2.6.16-rc1-mm4

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 misc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -upN reference/arch/i386/boot/compressed/misc.c current/arch/i386/boot/compressed/misc.c
--- reference/arch/i386/boot/compressed/misc.c
+++ current/arch/i386/boot/compressed/misc.c
@@ -122,7 +122,7 @@ static int vidport;
 static int lines, cols;
 
 #ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
+void * xquad_portio = NULL;
 #endif
 
 #include "../../../../lib/inflate.c"
