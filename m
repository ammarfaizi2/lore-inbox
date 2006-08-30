Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWH3Qwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWH3Qwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWH3Qwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:52:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:62392 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751156AbWH3Qwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:52:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kComHHQ7VqQvkcB9DmwF+7Th1t+w7/6tmu4sG+xbZFQhE+5Mfm75WqLxEj79Lpt8OIeuDP6d7Pvaewey6s9mYjYBMcRUQ0hx2xjQ36L0kClgqB2RmodfOP6gP5xt8HQ/+L3WR9Ot2olGDrfSdiiB76oAyyKgWWo8ZXUtyBXHcaM=
Date: Wed, 30 Aug 2006 19:49:42 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
Message-ID: <20060830194942.12cbf169@localhost>
In-Reply-To: <44F3555F.6060306@zytor.com>
References: <44F1F356.5030105@zytor.com>
	<200608272254.13871.ak@suse.de>
	<44F21122.3030505@zytor.com>
	<44F286E8.1000100@gmail.com>
	<44F2902B.5050304@gmail.com>
	<44F29BCD.3080408@zytor.com>
	<9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
	<44F335C8.7020108@zytor.com>
	<20060828184637.GD13464@lists.us.dell.com>
	<44F33D55.4080704@zytor.com>
	<20060828201223.GE13464@lists.us.dell.com>
	<44F3555F.6060306@zytor.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extending the kernel parameters to a 2048 bytes for
boot protocol >=2.02 of i386, ia64 and x86_64 architectures for
linux-2.6.18-rc4-mm2.

Current implementation allows the kernel to receive up to
255 characters from the bootloader. In current environment,
the command-line is used in order to specify many values,
including suspend/resume, module arguments, splash, initramfs
and more. 255 characters are not enough anymore.

EDD issue was fixed recently by H. Peter Anvin, please add this
to mm so more problems may be found.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -ruNp linux-2.6.18-rc4-mm2/include/asm-i386/param.h linux-2.6.18-rc4-mm2.new/include/asm-i386/param.h
--- linux-2.6.18-rc4-mm2/include/asm-i386/param.h	2006-08-25 16:10:56.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-i386/param.h	2006-08-26 02:30:52.000000000 +0300
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
 
 #endif
diff -ruNp linux-2.6.18-rc4-mm2/include/asm-i386/setup.h linux-2.6.18-rc4-mm2.new/include/asm-i386/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-i386/setup.h	2006-08-25 16:10:56.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-i386/setup.h	2006-08-26 02:30:52.000000000 +0300
@@ -15,7 +15,7 @@
 #define MAX_NONPAE_PFN	(1 << 20)
 
 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 2048
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
diff -ruNp linux-2.6.18-rc4-mm2/include/asm-ia64/setup.h linux-2.6.18-rc4-mm2.new/include/asm-ia64/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-ia64/setup.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-ia64/setup.h	2006-08-26 02:30:52.000000000 +0300
@@ -1,6 +1,6 @@
 #ifndef __IA64_SETUP_H
 #define __IA64_SETUP_H
 
-#define COMMAND_LINE_SIZE	512
+#define COMMAND_LINE_SIZE	2048
 
 #endif
diff -ruNp linux-2.6.18-rc4-mm2/include/asm-x86_64/setup.h linux-2.6.18-rc4-mm2.new/include/asm-x86_64/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-x86_64/setup.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-x86_64/setup.h	2006-08-26 02:32:44.000000000 +0300
@@ -1,6 +1,6 @@
 #ifndef _x8664_SETUP_H
 #define _x8664_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
+#define COMMAND_LINE_SIZE	2048
 
 #endif
