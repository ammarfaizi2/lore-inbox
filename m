Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSFNTKa>; Fri, 14 Jun 2002 15:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFNTK3>; Fri, 14 Jun 2002 15:10:29 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40900 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313687AbSFNTK2>; Fri, 14 Jun 2002 15:10:28 -0400
Subject: Re: [Patch] tsc-disable_A5
From: john stultz <johnstul@us.ibm.com>
To: Dave Jones <davej@suse.de>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <20020614205751.U16772@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jun 2002 12:04:18 -0700
Message-Id: <1024081458.29928.148.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-14 at 11:57, Dave Jones wrote:
> -#ifndef CONFIG_X86_TSC
> +#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
> +#ifdef CONFIG_TSC_DISABLE
> +static int tsc_disable __initdata = 1;
> +#else /*CONFIG_TSC_DISABLE*/
>  static int tsc_disable __initdata = 0;
> +#endif /*CONFIG_TSC_DISABLE*/
> 
> This looks *really horrible*

True, I agree here. 

> Why not just unset CONFIG_X86_TSC for those machines ?

I was actually hoping for a suggestion like this when I posted this
patch earlier. Can one really just unset CONFIG_ options that have
previously been set? I'd actually prefer this, but doing so generated a
.config that looked like:

CONFIG_X86_TSC=y
...
# CONFIG_X86_TSC is not set

So I assumed CONFIG_X86_TSC would still hold. Am I wrong, or is there
another way to do this?

Thanks
-john


