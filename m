Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265829AbSIRHiQ>; Wed, 18 Sep 2002 03:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265831AbSIRHiQ>; Wed, 18 Sep 2002 03:38:16 -0400
Received: from jalon.able.es ([212.97.163.2]:9668 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265829AbSIRHiP>;
	Wed, 18 Sep 2002 03:38:15 -0400
Date: Wed, 18 Sep 2002 09:43:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 5/7
Message-ID: <20020918074310.GA1539@werewolf.able.es>
References: <20020918021714.DDDF02C129@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020918021714.DDDF02C129@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Sep 18, 2002 at 04:08:38 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.18 Rusty Russell wrote:
>Name: Every module needs module_init
>Author: Rusty Russell
>Status: Trivial
>
>D: Every module needs a module_init now, so insert a trivial one where
>D: needed.  This is not exhaustive.
>
>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17783-2.5.35-modbase-try-i386.pre/lib/zlib_deflate/deflate_syms.c .17783-2.5.35-modbase-try-i386/lib/zlib_deflate/deflate_syms.c
>--- .17783-2.5.35-modbase-try-i386.pre/lib/zlib_deflate/deflate_syms.c	2002-02-20 17:56:17.000000000 +1100
>+++ .17783-2.5.35-modbase-try-i386/lib/zlib_deflate/deflate_syms.c	2002-09-18 11:45:27.000000000 +1000
>@@ -19,3 +19,9 @@ EXPORT_SYMBOL(zlib_deflateReset);
> EXPORT_SYMBOL(zlib_deflateCopy);
> EXPORT_SYMBOL(zlib_deflateParams);
> MODULE_LICENSE("GPL");
>+
>+static int init(void)
>+{
>+	return 0;
>+}
>+module_init(init);

Would not be worthy to do something like

#define MODULE_INIT_DEFAULT \
static int init(void) { return o;} \
module_init(init)
...

so you just can add:

MODULE_INIT_DEFAULT;
MODULE_EXIT_DEFAULT;

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
