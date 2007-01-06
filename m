Return-Path: <linux-kernel-owner+w=401wt.eu-S1751153AbXAFCjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXAFCjh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXAFCb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:56 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36742 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbXAFCbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:31:33 -0500
Message-Id: <20070106023531.314546000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:29 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       David Woodhouse <dwmw2@infradead.org>
Subject: [patch 36/50] NET: Dont export linux/random.h outside __KERNEL__
Content-Disposition: inline; filename=net-don-t-export-linux-random.h-outside-__kernel__.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Woodhouse <dwmw2@infradead.org>

Don't add it there please; add it lower down inside the existing #ifdef
__KERNEL__. You just made the _userspace_ net.h include random.h, which
then fails to compile unless <asm/types.h> was already included.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/linux/net.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/include/linux/net.h
+++ linux-2.6.19.1/include/linux/net.h
@@ -19,7 +19,6 @@
 #define _LINUX_NET_H
 
 #include <linux/wait.h>
-#include <linux/random.h>
 #include <asm/socket.h>
 
 struct poll_table_struct;
@@ -57,6 +56,7 @@ typedef enum {
 
 #ifdef __KERNEL__
 #include <linux/stringify.h>
+#include <linux/random.h>
 
 #define SOCK_ASYNC_NOSPACE	0
 #define SOCK_ASYNC_WAITDATA	1

--
