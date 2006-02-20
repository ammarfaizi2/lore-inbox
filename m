Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWBTGlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWBTGlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWBTGlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:41:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932669AbWBTGlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:41:17 -0500
Date: Sun, 19 Feb 2006 22:39:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture --improved
 version
Message-Id: <20060219223944.1a70aee1.akpm@osdl.org>
In-Reply-To: <489ecd0c0602192233y1cbd7d27s47755a14db115a79@mail.gmail.com>
References: <489ecd0c0602192233y1cbd7d27s47755a14db115a79@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
> Index: git/linux-2.6/mm/nommu.c
>  ===================================================================
>  --- git.orig/linux-2.6/mm/nommu.c       2006-02-17 17:40:34.000000000 +0800
>  +++ git/linux-2.6/mm/nommu.c    2006-02-20 12:09:32.000000000 +0800
>  @@ -57,7 +57,10 @@
>   EXPORT_SYMBOL(vfree);
>   EXPORT_SYMBOL(vmalloc_to_page);
>   EXPORT_SYMBOL(vmalloc_32);
>  +EXPORT_SYMBOL(vmap);
>  +EXPORT_SYMBOL(vunmap);
> 
>  +#define randomize_va_space 0
>   /*
>   * Handle all mappings that got truncated by a "truncate()"
>   * system call.

That can't be right - the #define should be in a header file - mm.h:

#ifdef CONFIG_NOMMU
#define randomize_va_space 0
#else
extern int randomize_va_space;
#endif

Are you sure you test-compiled this?
