Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275327AbTHMSip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHMSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:38:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:40912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275339AbTHMSgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:36:45 -0400
Date: Wed, 13 Aug 2003 11:36:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of bcopy warning
Message-Id: <20030813113635.3d3b71ce.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of warning because internal definition of bcopy
conflicts with builtin.  The warning is probably a bogus
bug of GCC 3.2.3, but the workaround is simple.

Almost no driver really uses bcopy anyway, and no code
uses the return value.

diff -Nru a/lib/string.c b/lib/string.c
--- a/lib/string.c	Wed Aug 13 11:31:13 2003
+++ b/lib/string.c	Wed Aug 13 11:31:13 2003
@@ -432,14 +432,13 @@
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-char * bcopy(const char * src, char * dest, int count)
+void bcopy(const void * src, void * dest, size_t count)
 {
+ 	const char *s = src;
 	char *tmp = dest;
 
 	while (count--)
-		*tmp++ = *src++;
-
-	return dest;
+		*tmp++ = *s++;
 }
 #endif
 
