Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTCETpG>; Wed, 5 Mar 2003 14:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTCETpE>; Wed, 5 Mar 2003 14:45:04 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:56001 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S261302AbTCEToh>; Wed, 5 Mar 2003 14:44:37 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
From: Derek Atkins <derek@ihtfp.com>
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
References: <sjmof4pvfx7.fsf@kikki.mit.edu>
	<20030305182715.A27888@infradead.org> <sjmbs0pvelp.fsf@kikki.mit.edu>
	<20030305185149.A28243@infradead.org>
In-Reply-To: <20030305185149.A28243@infradead.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Date: 05 Mar 2003 14:55:03 -0500
Message-ID: <sjm3cm1twq0.fsf@kikki.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that was the wrong patch.

Try this one.

-derek

diff -u -r1.4 grabmyaddr.c
--- src/racoon/grabmyaddr.c	5 Mar 2003 18:54:08 -0000	1.4
+++ src/racoon/grabmyaddr.c	5 Mar 2003 19:54:17 -0000
@@ -65,10 +65,13 @@
 #include "isakmp_var.h"
 #include "gcmalloc.h"
 
-#if defined(__linux__) && !defined(HAVE_GETIFADDRS)
+#ifdef __linux__
+#include <linux/rtnetlink.h>
+ifndef HAVE_GETIFADDRS
 #define HAVE_GETIFADDRS
 #define NEED_LINUX_GETIFADDRS
 #endif
+#endif
 
 #ifndef HAVE_GETIFADDRS
 static unsigned int if_maxindex __P((void));
@@ -93,8 +96,6 @@
 	struct sockaddr *ifa_addr;
 	struct sockaddr_storage ifa_addrbuf;
 };
-
-#include <linux/rtnetlink.h>
 
 __u32 nl_pid;
 int nl_rescan;


-- 
       Derek Atkins
       Computer and Internet Security Consultant
       derek@ihtfp.com             www.ihtfp.com
