Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVBXXRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVBXXRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVBXXRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:17:11 -0500
Received: from quark.didntduck.org ([69.55.226.66]:20443 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262562AbVBXXQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:16:37 -0500
Message-ID: <421E6056.7010901@didntduck.org>
Date: Thu, 24 Feb 2005 18:16:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] vsprintf.c cleanups
Content-Type: multipart/mixed;
 boundary="------------070704060709090703080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070704060709090703080702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Make sprintf call vsnprintf directly
- use INT_MAX for sprintf and vsprintf

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

  vsprintf.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)


--------------070704060709090703080702
Content-Type: text/plain;
 name="vsprintf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vsprintf.diff"

diff -urN linux-2.6.11-rc5/lib/vsprintf.c linux/lib/vsprintf.c
--- linux-2.6.11-rc5/lib/vsprintf.c	2004-08-24 08:43:15.000000000 -0400
+++ linux/lib/vsprintf.c	2005-02-24 17:59:28.000000000 -0500
@@ -580,7 +580,7 @@
  */
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
-	return vsnprintf(buf, (~0U)>>1, fmt, args);
+	return vsnprintf(buf, INT_MAX, fmt, args);
 }
 
 EXPORT_SYMBOL(vsprintf);
@@ -601,7 +601,7 @@
 	int i;
 
 	va_start(args, fmt);
-	i=vsprintf(buf,fmt,args);
+	i=vsnprintf(buf, INT_MAX, fmt, args);
 	va_end(args);
 	return i;
 }

--------------070704060709090703080702--
