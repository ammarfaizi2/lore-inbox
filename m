Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTHMLwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHMLwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:52:16 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:42414 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S271749AbTHMLwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:52:13 -0400
Date: Wed, 13 Aug 2003 13:52:12 +0200
From: Adrian Reber <adrian@lisas.de>
To: linux-kernel@vger.kernel.org
Subject: vsnprintf patch
Message-ID: <20030813115212.GA28066@lisas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Url: <http://lisas.de/~adrian/>
X-Operating-System: Linux (2.4.21-rc2-ac2)
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 3ED6F034
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using the snprintf function from the kernel the length returned is
not the length written:

len = snprintf(test,1,"BLA 1"); 

len is 5 although test is "B"

the patch below fixes the symptom, but I am not sure if this is the real
solution for this problem.


--- linux-2.6.0-test3.orig/lib/vsprintf.c       2003-08-09 06:40:52.000000000 +0200
+++ linux-2.6.0-test3/lib/vsprintf.c    2003-08-13 13:41:15.000000000 +0200
@@ -455,7 +455,10 @@
        /* the trailing null byte doesn't count towards the total
        * ++str;
        */
-       return str-buf;
+       if (str-buf > size)
+               return size;
+       else
+               return str-buf;
 }
 
 /**



		Adrian
