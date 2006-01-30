Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWA3A0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWA3A0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWA3A0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:26:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWA3A0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:26:32 -0500
Date: Sun, 29 Jan 2006 16:25:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060129162524.4b84a56c.akpm@osdl.org>
In-Reply-To: <20060129233403.GA3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060129233403.GA3777@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> n Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
>  >...
>  > Changes since 2.6.16-rc1-mm3:
>  >...
>  > +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
>  > 
>  >  x86 fixes/features
>  >...
> 
>  This patch generates so many "ISO C90 forbids mixed declarations and code"
>  warnings that I start to consider Andrew's rejection of my "mark 
>  virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
>  warnings it generates a personal insult...

Bah, that's what you get for using a slow compiler.

--- devel/include/asm-i386/uaccess.h~i386-add-a-temporary-to-make-put_user-more-type-safe-fix	2006-01-29 16:24:24.000000000 -0800
+++ devel-akpm/include/asm-i386/uaccess.h	2006-01-29 16:24:24.000000000 -0800
@@ -197,8 +197,9 @@ extern void __put_user_8(void);
 
 #define put_user(x,ptr)						\
 ({	int __ret_pu;						\
+	__typeof__(*(ptr)) __pu_val;				\
 	__chk_user_ptr(ptr);					\
-	__typeof__(*(ptr)) __pu_val = x;			\
+	__pu_val = x;						\
 	switch(sizeof(*(ptr))) {				\
 	case 1: __put_user_1(__pu_val, ptr); break;		\
 	case 2: __put_user_2(__pu_val, ptr); break;		\
_

