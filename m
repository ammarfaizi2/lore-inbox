Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUBJGi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUBJGi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:38:59 -0500
Received: from mx11.sac.fedex.com ([199.81.193.118]:16134 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S265663AbUBJGi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:38:57 -0500
Date: Tue, 10 Feb 2004 14:39:29 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] warning: `__attribute_used__' redefined
Message-ID: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/10/2004
 02:38:46 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/10/2004
 02:38:50 PM,
	Serialize complete at 02/10/2004 02:38:50 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus, Andrew,

Here's a small fix for linux 2.6.3-rc2 to get rid of the annoying warnings
while non-kernel programs ...

/usr/include/linux/compiler-gcc2.h:15: warning: `__attribute_used__' redefined
/usr/include/sys/cdefs.h:170: warning: this is the location of the previous definition


Thanks,
Jeff


--- linux-2.6.2/include/linux/compiler-gcc2.h	Wed Feb  4 11:45:02 2004
+++ linux-2.6.3-rc2/include/linux/compiler-gcc2.h	Tue Feb 10 14:30:04 2004
@@ -12,6 +12,10 @@
 # define __builtin_expect(x, expected_value) (x)
 #endif

+#ifdef __attribute_used__
+#undef __attribute_used__
+#endif
+
 #define __attribute_used__	__attribute__((__unused__))

 /*
