Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUDXXuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUDXXuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 19:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUDXXuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 19:50:00 -0400
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:39606 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261982AbUDXXt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 19:49:58 -0400
Message-ID: <408AFD6C.9080100@quark.didntduck.org>
Date: Sat, 24 Apr 2004 19:51:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix warning in prefetch_range
Content-Type: multipart/mixed;
 boundary="------------040106090109060102050001"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106090109060102050001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix this warning:
include/linux/prefetch.h: In function `prefetch_range':
include/linux/prefetch.h:62: warning: pointer of type `void *' used in 
arithmetic

--
				Brian Gerst

--------------040106090109060102050001
Content-Type: text/plain;
 name="prefetch-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prefetch-1"

diff -urN linux-2.6.5-rc1-bk/include/linux/prefetch.h linux/include/linux/prefetch.h
--- linux-2.6.5-rc1-bk/include/linux/prefetch.h	2004-04-14 23:53:11.000000000 -0400
+++ linux/include/linux/prefetch.h	2004-04-16 11:12:25.840194048 -0400
@@ -59,7 +59,7 @@
 {
 #ifdef ARCH_HAS_PREFETCH
 	char *cp;
-	char *end = addr + len;
+	char *end = (char *)addr + len;
 
 	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
 		prefetch(cp);

--------------040106090109060102050001--
