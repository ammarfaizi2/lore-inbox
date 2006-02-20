Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWBTFo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWBTFo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWBTFo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:44:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932640AbWBTFoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:44:25 -0500
Date: Sun, 19 Feb 2006 21:42:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture
Message-Id: <20060219214244.03147dba.akpm@osdl.org>
In-Reply-To: <489ecd0c0602192024o2a136ddera294876ea8fd44a5@mail.gmail.com>
References: <489ecd0c0602192024o2a136ddera294876ea8fd44a5@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
> Hi,
> 
>   This is a patch to add or export some undefined symbols in nommu
> architectures (mm/nommu.c).  Based on latest mm-tree. Following
> symbols are added: vmap, vunmap, randomize_va_space.
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> 
> Index: git/linux-2.6/mm/nommu.c
> ===================================================================
> --- git.orig/linux-2.6/mm/nommu.c	2006-02-17 17:40:34.000000000 +0800
> +++ git/linux-2.6/mm/nommu.c	2006-02-20 12:09:32.000000000 +0800
> @@ -57,7 +57,10 @@
>  EXPORT_SYMBOL(vfree);
>  EXPORT_SYMBOL(vmalloc_to_page);
>  EXPORT_SYMBOL(vmalloc_32);
> +EXPORT_SYMBOL(vmap);
> +EXPORT_SYMBOL(vunmap);

OK.

> +int randomize_va_space = 0;

Not so sure about this one.  Does randomize_va_space actually make sense in
a nommu environment?  I guess we could load relocatable binaries into a
randomised place, but I'm not sure that this is implemented?

If no, then it would make more sense to do

	#define randomize_va_space 0

for nommu, so the relevant code gets thrown away by the compiler.
