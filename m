Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVAJSsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVAJSsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAJSXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:23:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:23708 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262405AbVAJSHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:07:10 -0500
Subject: [PATCH 2/6] 2.4.19-rc1 number() stack reduction
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-lPfPqwq1flEktnaEFM6+"
Organization: 
Message-Id: <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:39:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lPfPqwq1flEktnaEFM6+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-lPfPqwq1flEktnaEFM6+
Content-Disposition: attachment; filename=number.patch
Content-Type: text/plain; name=number.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/lib/vsprintf.c	2004-02-18 05:36:32.000000000 -0800
+++ linux-2.4.29-rc1/lib/vsprintf.c	2005-01-07 07:56:00.000000000 -0800
@@ -128,12 +128,16 @@ static int skip_atoi(const char **s)
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
+ /* Move these off of the stack for number().  This way we reduce the
+  * size of the stack and don't have to copy them every time we are called.
+  */
+const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
+const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+
 static char * number(char * buf, char * end, long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits;
-	static const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
-	static const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
 	int i;
 
 	digits = (type & LARGE) ? large_digits : small_digits;

--=-lPfPqwq1flEktnaEFM6+--

