Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTHCLaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271153AbTHCLaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:30:30 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:40999
	"EHLO gaston") by vger.kernel.org with ESMTP id S271152AbTHCLa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:30:29 -0400
Subject: [PATCH][RESENT] Fix mdelay's use of 'msec' name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059910205.3524.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 13:30:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== include/linux/delay.h 1.2 vs edited =====
--- 1.2/include/linux/delay.h	Tue Feb 18 23:42:12 2003
+++ edited/include/linux/delay.h	Sun Aug  3 13:27:29 2003
@@ -27,11 +27,11 @@
 
 #ifdef notdef
 #define mdelay(n) (\
-	{unsigned long msec=(n); while (msec--) udelay(1000);})
+	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
 #else
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long msec=(n); while (msec--) udelay(1000);}))
+	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
 #endif
 
 #ifndef ndelay

