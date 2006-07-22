Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWGVJKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWGVJKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 05:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWGVJKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 05:10:04 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:143 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751129AbWGVJKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 05:10:03 -0400
Date: Sat, 22 Jul 2006 10:58:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ricknu-0@student.ltu.se
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
In-Reply-To: <1153524422.44c162c65c21b@portal.student.luth.se>
Message-ID: <Pine.LNX.4.61.0607221057050.8381@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <1153524422.44c162c65c21b@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+++ b/drivers/block/DAC960.h
>@@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
>   Define a Boolean data type.
> */
> 
>-typedef enum { false, true } __attribute__ ((packed)) boolean;
>+typedef bool boolean;
> 
Probably I missed some mail, but why can't we just have typedef _Bool bool?
Like below?

>+++ b/include/asm-i386/types.h
>@@ -1,6 +1,13 @@
> #ifndef _I386_TYPES_H
> #define _I386_TYPES_H
> 
>+#if __GNUC__ >= 3
>+typedef _Bool bool;
>+#else
>+#warning You compiler doesn't seem to support boolean types, will set 'bool' as
>an 'unsigned int'
>+typedef unsigned int bool;
>+#endif
>+
> #ifndef __ASSEMBLY__
> 
> typedef unsigned short umode_t;
>--- a/include/linux/stddef.h
>+++ b/include/linux/stddef.h
>@@ -10,6 +10,17 @@ #else
> #define NULL ((void *)0)
> #endif
> 
>+#undef false
>+#undef true

Wasnot this supposed to go away?

>+
>+enum {
>+	false	= 0,
>+	true	= 1
>+};
>+
>+#define false false
>+#define true true 
>+
> #undef offsetof
> #ifdef __compiler_offsetof
> #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
>

Jan Engelhardt
-- 
