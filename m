Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDLVEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUDLVEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:04:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:2998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263095AbUDLVEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:04:15 -0400
Date: Mon, 12 Apr 2004 14:06:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [2.6.5][MIPS] oneliners somehow not made it into mainline [3/3]
Message-Id: <20040412140628.4836d778.akpm@osdl.org>
In-Reply-To: <87hdvpp8km.wl@canopus.ns.zel.ru>
References: <87k70lp8q8.wl@canopus.ns.zel.ru>
	<87hdvpp8km.wl@canopus.ns.zel.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff <deepfire@sic-elvis.zel.ru> wrote:
>
> Without this one it fails to run the earlyinitcall stuff, and hence
> explodes at some point.
> 
> diff -urN -X './#cdiff.pattern' ./linux-2.6.5/include/linux/init.h ./mc-2.6.5/include/linux/init.h
> --- ./linux-2.6.5/include/linux/init.h  2004-04-12 16:07:45.000000000 +0400
> +++ ./mc-2.6.5/include/linux/init.h     2004-04-12 18:05:28.000000000 +0400
> @@ -83,6 +83,7 @@
>         static initcall_t __initcall_##fn __attribute_used__ \
>         __attribute__((__section__(".initcall" level ".init"))) = fn
> 
> +#define early_initcall(fn)             __define_initcall(".early1",fn)
>  #define core_initcall(fn)              __define_initcall("1",fn)
>  #define postcore_initcall(fn)          __define_initcall("2",fn)
>  #define arch_initcall(fn)              __define_initcall("3",fn)

early_initcall() is a mips-specific thing.  If we add this macro to
<linux/init.h> then someone will use it in generic code and all the other
architectures explode.

We need to either make this entirely mips-private, or rework the mips code
to not use it at all, or justify its introduction and then introduce it for
all architectures.

