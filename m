Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbTGIJSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbTGIJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:18:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17404 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265853AbTGIJSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:18:40 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm3
Date: Wed, 9 Jul 2003 11:25:38 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307091106.00781.schlicht@uni-mannheim.de> <20030709021849.31eb3aec.akpm@osdl.org>
In-Reply-To: <20030709021849.31eb3aec.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307091125.40879.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 11:18, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > This gives following compile error when compiling the kernel with APM
> > support for UP:
> >
> >  arch/i386/kernel/apm.c: In function `apm_bios_call':
> >  arch/i386/kernel/apm.c:600: error: incompatible types in assignment
> >  arch/i386/kernel/apm.c: In function `apm_bios_call_simple':
> >  arch/i386/kernel/apm.c:643: error: incompatible types in assignment
> >
> >  The attached patch fixes this...
>
> Seems complex.  I just have this:
>
>
> diff -puN arch/i386/kernel/apm.c~cpumask-apm-fix-2 arch/i386/kernel/apm.c
> --- 25/arch/i386/kernel/apm.c~cpumask-apm-fix-2	2003-07-08
> 23:09:23.000000000 -0700 +++ 25-akpm/arch/i386/kernel/apm.c	2003-07-08
> 23:28:50.000000000 -0700 @@ -528,7 +528,7 @@ static inline void
> apm_restore_cpus(cpum
>   *	No CPU lockdown needed on a uniprocessor
>   */
>
> -#define apm_save_cpus()	0
> +#define apm_save_cpus()		CPU_MASK_NONE
>  #define apm_restore_cpus(x)	(void)(x)
>
>  #endif

I thought about this one, too, but I wasn't sure if gcc is able to optimize 
away the assignment and the local cpumask_t variable with this oneliner...

But for me it is OK, too...
