Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKCTXu>; Fri, 3 Nov 2000 14:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbQKCTXl>; Fri, 3 Nov 2000 14:23:41 -0500
Received: from mirrors.planetinternet.be ([194.119.238.163]:28164 "EHLO
	mirrors.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129042AbQKCTXf>; Fri, 3 Nov 2000 14:23:35 -0500
Date: Fri, 3 Nov 2000 20:23:27 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: conflicting types for `mktime' is userspave programs using libc5
Message-ID: <20001103202327.A961@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii

When trying to compile something using libc5, with the
2.4.0-test10 kernel, I get this:

/usr/include/time.h:85: conflicting types for `mktime'
/usr/include/linux/time.h:69: previous declaration of `mktime'

A simple diff is attached


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mktime.diff"

--- include/linux/time.h~	Fri Nov  3 20:22:14 2000
+++ include/linux/time.h	Fri Nov  3 20:21:22 2000
@@ -46,6 +46,7 @@
 	value->tv_sec = jiffies / HZ;
 }
 
+#ifdef	__KERNEL__
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
@@ -78,6 +79,7 @@
 	  )*60 + min /* now have minutes */
 	)*60 + sec; /* finally seconds */
 }
+#endif
 
 
 struct timeval {

--zYM0uCDKw75PZbzx--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
