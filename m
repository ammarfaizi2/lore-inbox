Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUEDLgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUEDLgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUEDLgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:36:44 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:14052 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S264279AbUEDLgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:36:43 -0400
Date: Tue, 4 May 2004 13:36:41 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] get_thread_area macros
Message-ID: <20040504113641.GI2801@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one of the macros for get_thread_area seems to extract the wrong bit.
The "32bit" field is in bit 22, not 23 (as can be seen in desc.h).

diff -urN linux-2.6.6-rc3/arch/i386/kernel/process.c linux-2.6.6-rc3-a/arch/i386/kernel/process.c
--- linux-2.6.6-rc3/arch/i386/kernel/process.c	2004-05-03 22:28:42.000000000 +0200
+++ linux-2.6.6-rc3-a/arch/i386/kernel/process.c	2004-05-03 22:32:19.000000000 +0200
@@ -740,7 +740,7 @@
 	((desc)->a & 0x0ffff) | \
 	 ((desc)->b & 0xf0000) )
 	
-#define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
+#define GET_32BIT(desc)		(((desc)->b >> 22) & 1)
 #define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
 #define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
 #define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
diff -urN linux-2.6.6-rc3/arch/i386/kernel/ptrace.c linux-2.6.6-rc3-a/arch/i386/kernel/ptrace.c
--- linux-2.6.6-rc3/arch/i386/kernel/ptrace.c	2004-05-03 22:28:42.000000000 +0200
+++ linux-2.6.6-rc3-a/arch/i386/kernel/ptrace.c	2004-05-03 22:33:43.000000000 +0200
@@ -174,7 +174,7 @@
 	((desc)->a & 0x0ffff) | \
 	 ((desc)->b & 0xf0000) )
 
-#define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
+#define GET_32BIT(desc)		(((desc)->b >> 22) & 1)
 #define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
 #define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
 #define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)

Furthermore I'd suggest to put these macros into desc.h, mainly to avoid
the duplication in the two files.



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
