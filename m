Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWBWHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWBWHyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWBWHyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 02:54:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750884AbWBWHyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 02:54:20 -0500
Date: Wed, 22 Feb 2006 23:35:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, drepper@redhat.com,
       tglx@linutronix.de, arjan@infradead.org
Subject: Re: [patch 4/6] lightweight robust futexes: compat
Message-Id: <20060222233521.743e60cb.akpm@osdl.org>
In-Reply-To: <20060222225457.90a35cf8.pj@sgi.com>
References: <20060221084655.GE5506@elte.hu>
	<20060222225457.90a35cf8.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> kernel/built-in.o(.text+0x54782): In function `compat_sys_get_robust_list':
>  kernel/futex_compat.c:92: undefined reference to `ptr_to_compat'

Yup.  Ingo has sent through fixes for the four missing architectures
(uploads them to hot-fixes).  Here's ia64:

include/asm-ia64/compat.h
--- devel/include/asm-ia64/compat.h~ia64-add-ptr-to-compatpatch	2006-02-21 17:00:33.000000000 -0800
+++ devel-akpm/include/asm-ia64/compat.h	2006-02-21 17:00:33.000000000 -0800
@@ -189,6 +189,12 @@ compat_ptr (compat_uptr_t uptr)
 	return (void __user *) (unsigned long) uptr;
 }
 
+static inline compat_uptr_t
+ptr_to_compat(void __user *uptr)
+{
+	return (u32)(unsigned long)uptr;
+}
+
 static __inline__ void __user *
 compat_alloc_user_space (long len)
 {
_

