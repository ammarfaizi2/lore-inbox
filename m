Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280848AbRKGQYa>; Wed, 7 Nov 2001 11:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280844AbRKGQYU>; Wed, 7 Nov 2001 11:24:20 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:47890 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S280841AbRKGQYK>; Wed, 7 Nov 2001 11:24:10 -0500
Date: Wed, 7 Nov 2001 17:24:01 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] add function attributes to sprintf() and snprintf()
Message-ID: <20011107172401.I14594@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds function attributes to sprintf() and snprintf() so the
compiler can catch formatting errors at compile time. Patch is against
2.4.13-ac8, but it should apply cleanly against 2.4.14 as well.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/


Index: include/linux/kernel.h
===================================================================
RCS file: /home/erik/cvsroot/elinux/include/linux/kernel.h,v
retrieving revision 1.1.1.143
diff -u -r1.1.1.143 kernel.h
--- linux/include/linux/kernel.h	2001/11/07 00:36:34	1.1.1.143
+++ linux/include/linux/kernel.h	2001/11/07 15:49:54
@@ -60,9 +60,11 @@
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
-extern int sprintf(char * buf, const char * fmt, ...);
+extern int sprintf(char * buf, const char * fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
 extern int vsprintf(char *buf, const char *, va_list);
-extern int snprintf(char * buf, size_t size, const char *fmt, ...);
+extern int snprintf(char * buf, size_t size, const char * fmt, ...)
+	__attribute__ ((format (printf, 3, 4)));
 extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 
 extern int sscanf(const char *, const char *, ...)
