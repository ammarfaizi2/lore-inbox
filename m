Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWKFSfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWKFSfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWKFSfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:35:37 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:48058
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750709AbWKFSfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:35:36 -0500
Date: Mon, 6 Nov 2006 18:35:21 +0000
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, linux-390@vm.marist.edu
Subject: [PATCH] s390 need definitions for pagefault_disable and pagefault_enable
Message-ID: <7e94d9e3967f67b1151689921a21fd65@pinky>
References: <20061101235407.a92f94a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20061101235407.a92f94a5.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390: need definitions for pagefault_disable and pagefault_enable

Seems that when the changes for user futex's went into 2.6.19-rc4-mm2
s390 was missed.  Leading to the following compile failure:

    arch/s390/lib/lib.a(uaccess_std.o)(.text+0x37c): In function
						    `futex_atomic_op':
    : undefined reference to `pagefault_disable'
    arch/s390/lib/lib.a(uaccess_std.o)(.text+0x3cc): In function
						    `futex_atomic_op':
    : undefined reference to `pagefault_enable'
    [...]

This seems to be enough to get testing working again.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
index 9bbeaa0..ad296dc 100644
--- a/arch/s390/lib/uaccess_std.c
+++ b/arch/s390/lib/uaccess_std.c
@@ -11,6 +11,8 @@
 
 #include <linux/errno.h>
 #include <linux/mm.h>
+#include <linux/uaccess.h>
+
 #include <asm/uaccess.h>
 #include <asm/futex.h>
 
