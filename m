Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKQLvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKQLvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 06:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKQLvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 06:51:31 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:39985 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVKQLvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 06:51:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=osnOXxodIV9bn00SOaTm+Q1Ff7WlHcu09pJ8HAQ9jbW/ddO1FUeLFrwrx9XVWvH4r9SPMdQJevsbu0HVsvfnaMlIvsa+3aekKS3pCWhl4cqaGAJ+LNvGKQJyLLPgAClGXfkBm22N1WwjIs4Nh5S28/j5xFtZhTV6GEN7qvsVqpE=
Message-ID: <2cd57c900511170351g5f2e593bw@mail.gmail.com>
Date: Thu, 17 Nov 2005 19:51:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: transmeta-no-procfs-build-fix.patch added to -mm tree
Cc: akpm@osdl.org, lkml@dodo.com.au, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200508020322.j723MwfR023586@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508020322.j723MwfR023586@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/2, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      transmeta: CONFIG_PROC_FS=n build fix
>
> has been added to the -mm tree.  Its filename is
>
>      transmeta-no-procfs-build-fix.patch

> From: Andrew Morton <akpm@osdl.org>
>
> Fix bug found by Grant Coady <lkml@dodo.com.au>'s autobuild setup.
>
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/i386/kernel/cpu/transmeta.c |    2 ++
>  1 files changed, 2 insertions(+)
>
> diff -puN arch/i386/kernel/cpu/transmeta.c~transmeta-no-procfs-build-fix arch/i386/kernel/cpu/transmeta.c
> --- devel/arch/i386/kernel/cpu/transmeta.c~transmeta-no-procfs-build-fix        2005-08-01 20:15:42.000000000 -0700
> +++ devel-akpm/arch/i386/kernel/cpu/transmeta.c 2005-08-01 20:16:14.000000000 -0700
> @@ -77,9 +77,11 @@ static void __init init_transmeta(struct
>          if ( c->x86 == 5 && (c->x86_capability[0] & USER686) == USER686 )
>                 c->x86 = 6;
>
> +#ifdef CONFIG_SYSCTL
>         /* randomize_va_space slows us down enormously;
>            it probably triggers retranslation of x86->native bytecode */
>         randomize_va_space = 0;
> +#endif
>  }

You haven't fixed the problem. It would fall back to
#define randomize_va_space 1

>
>  static void transmeta_identify(struct cpuinfo_x86 * c)

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
