Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHZAA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHZAA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHZAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:00:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:46874 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932288AbWHZAA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:00:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IxkU8F1pGfOlL6Y1kobuaKzcAfez+idlRJ36ear4zHpDMkTpyCI1vIxsK9iazVje+8qdQLjpNa/UEdpYpAyVcDMNth+S9g9hcwvS3aEQOaufhjNetu63jb9mmL+ytd9KXf9JPLW+lYlHKHGJa1NEgyn2VPtscPSHAqNpoJZGZ0A=
Message-ID: <44EF8E7D.5060905@gmail.com>
Date: Sat, 26 Aug 2006 02:57:49 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
References: <445B5524.2090001@gmail.com> <445BCA33.30903@zytor.com>	 <6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>	 <445C301E.6060509@zytor.com> <44AD583B.5040007@gmail.com>	 <44AD5BB4.9090005@zytor.com> <44AD5D47.8010307@gmail.com>	 <44AD5FD8.6010307@zytor.com>	 <9e0cf0bf0608031436x19262ab0rb2271b52ce75639d@mail.gmail.com>	 <44D278D6.2070106@zytor.com> <9e0cf0bf0608031542q2da20037h828f4b8f0d01c4d5@mail.gmail.com> <44D27F22.4080205@zytor.com>
In-Reply-To: <44D27F22.4080205@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc4-mm2/include/asm-i386/param.h linux-2.6.18-rc4-mm2.new/include/asm-i386/param.h
--- linux-2.6.18-rc4-mm2/include/asm-i386/param.h	2006-08-25 16:10:56.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-i386/param.h	2006-08-26 02:30:52.000000000 +0300
@@ -18,6 +18,5 @@
  #endif

  #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256

  #endif
diff -urNp linux-2.6.18-rc4-mm2/include/asm-i386/setup.h linux-2.6.18-rc4-mm2.new/include/asm-i386/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-i386/setup.h	2006-08-25 16:10:56.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-i386/setup.h	2006-08-26 02:30:52.000000000 +0300
@@ -15,7 +15,7 @@
  #define MAX_NONPAE_PFN	(1 << 20)

  #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 2048

  #define OLD_CL_MAGIC_ADDR	0x90020
  #define OLD_CL_MAGIC		0xA33F
diff -urNp linux-2.6.18-rc4-mm2/include/asm-ia64/setup.h linux-2.6.18-rc4-mm2.new/include/asm-ia64/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-ia64/setup.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-ia64/setup.h	2006-08-26 02:30:52.000000000 +0300
@@ -1,6 +1,6 @@
  #ifndef __IA64_SETUP_H
  #define __IA64_SETUP_H

-#define COMMAND_LINE_SIZE	512
+#define COMMAND_LINE_SIZE	2048

  #endif
diff -urNp linux-2.6.18-rc4-mm2/include/asm-x86_64/setup.h linux-2.6.18-rc4-mm2.new/include/asm-x86_64/setup.h
--- linux-2.6.18-rc4-mm2/include/asm-x86_64/setup.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/include/asm-x86_64/setup.h	2006-08-26 02:32:44.000000000 +0300
@@ -1,6 +1,6 @@
  #ifndef _x8664_SETUP_H
  #define _x8664_SETUP_H

-#define COMMAND_LINE_SIZE	256
+#define COMMAND_LINE_SIZE	2048

  #endif
