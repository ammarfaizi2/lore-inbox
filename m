Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUBQKfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 05:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUBQKfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 05:35:22 -0500
Received: from gprs155-60.eurotel.cz ([160.218.155.60]:19841 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264604AbUBQKfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 05:35:14 -0500
Date: Tue, 17 Feb 2004 11:34:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: hweight64
Message-ID: <20040217103451.GA440@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In kgdb patches you change prototype of hweight64. Why that change?

[This patch is reverse]

I do not see what it has to do with kgdb. Its true that result always
fits into int, but I'd be afraid of small sideeffects somewhere...

								Pavel


--- clean-mm/include/linux/bitops.h	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/include/linux/bitops.h	2003-06-24 12:28:05.000000000 +0200
@@ -108,7 +108,7 @@
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-static inline unsigned int generic_hweight64(__u64 w)
+static inline unsigned long generic_hweight64(__u64 w)
 {
 #if BITS_PER_LONG < 64
 	return generic_hweight32((unsigned int)(w >> 32)) +
@@ -120,8 +120,7 @@
 	res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
 	res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
 	res = (res & 0x0000FFFF0000FFFF) + ((res >> 16) & 0x0000FFFF0000FFFF);
-	res = (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
-	return (unsigned int)res;
+	return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
 #endif
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
