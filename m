Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVHVUch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVHVUch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVHVUch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:32:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15299 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750751AbVHVUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:32:36 -0400
Date: Mon, 22 Aug 2005 21:35:23 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
Message-ID: <20050822203522.GB9322@parcelfarce.linux.theplanet.co.uk>
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org> <20050822195913.GF27344@redhat.com> <20050822132333.2ff893e6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822132333.2ff893e6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:23:33PM -0700, Andrew Morton wrote:
> Works for me.  CONFIG_PM=n, CONFIG_SKGE=y or m, CONFIG_SK98LIN=y or m.
> 
> btw, is one of the recent `%td' fans going to, like, implement it in
> printk()?

Sent to Linus, sits in his queue...  Last iteration had been

mail -s '[PATCH] (45/46) %t... in vsnprintf' torvalds@osdl.org <<'EOF'
handling of %t... (ptrdiff_t) in vsnprintf

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git10-m68k-adb.patch/lib/vsprintf.c RC13-rc6-git10-printf-t/lib/vsprintf.c
--- RC13-rc6-git10-m68k-adb.patch/lib/vsprintf.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git10-printf-t/lib/vsprintf.c	2005-08-18 14:24:08.000000000 -0400
@@ -269,6 +269,7 @@
 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
 				/* 'z' support added 23/7/1999 S.H.    */
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
+				/* 't' added for ptrdiff_t */
 
 	/* Reject out-of-range values early */
 	if (unlikely((int) size < 0)) {
@@ -339,7 +340,7 @@
 		/* get the conversion qualifier */
 		qualifier = -1;
 		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
-		    *fmt =='Z' || *fmt == 'z') {
+		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
 			qualifier = *fmt;
 			++fmt;
 			if (qualifier == 'l' && *fmt == 'l') {
@@ -467,6 +468,8 @@
 				num = (signed long) num;
 		} else if (qualifier == 'Z' || qualifier == 'z') {
 			num = va_arg(args, size_t);
+		} else if (qualifier == 't') {
+			num = va_arg(args, ptrdiff_t);
 		} else if (qualifier == 'h') {
 			num = (unsigned short) va_arg(args, int);
 			if (flags & SIGN)
EOF
