Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWA2XoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWA2XoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWA2XoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:44:04 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:39908 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932090AbWA2XoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:44:03 -0500
Message-ID: <43DD5339.3000009@ens-lyon.org>
Date: Sun, 29 Jan 2006 18:43:53 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
References: <20060129144533.128af741.akpm@osdl.org>
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------060304060101070009000308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304060101070009000308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
>
>- New git tree `git-davej-x86.patch': misc x86 things, maintained by David
>  Jones.
>
>- Lots of USB updates.  Please be sure to Cc:
>  linux-usb-devel@lists.sourceforge.net if something broke.
>
>- Various other random bits and pieces.  Things have been pretty quiet
>  lately - most activity seems to be concentrated about putting bugs into the
>  various subsystem trees.
>
>- If you have a patch in -mm which you think should go into 2.6.16, it
>  doesn't hurt to remind me.  There's quite a lot here which will go into
>  2.6.16.
>  
>
Hi Andrew,

I get a lot of warnings like this one:
sound/core/seq/oss/seq_oss_ioctl.c:122: warning: ISO C90 forbids mixed
declarations and code

They appear to be caused by put_user. The following patch should fix that.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice



--------------060304060101070009000308
Content-Type: text/x-patch;
 name="fix_put_user_declarations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_put_user_declarations.patch"

--- linux-mm/include/asm-i386/uaccess.h.old	2006-01-29 18:37:02.000000000 -0500
+++ linux-mm/include/asm-i386/uaccess.h	2006-01-29 18:37:35.000000000 -0500
@@ -197,8 +197,8 @@ extern void __put_user_8(void);
 
 #define put_user(x,ptr)						\
 ({	int __ret_pu;						\
-	__chk_user_ptr(ptr);					\
 	__typeof__(*(ptr)) __pu_val = x;			\
+	__chk_user_ptr(ptr);					\
 	switch(sizeof(*(ptr))) {				\
 	case 1: __put_user_1(__pu_val, ptr); break;		\
 	case 2: __put_user_2(__pu_val, ptr); break;		\

--------------060304060101070009000308--
