Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCXVmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUCXVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:42:50 -0500
Received: from gate.in-addr.de ([212.8.193.158]:31981 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262007AbUCXVmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:42:40 -0500
Date: Wed, 24 Mar 2004 22:43:55 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: siginfo -> si_band is long
Message-ID: <20040324214355.GZ2095@marowsky-bree.de>
References: <20040324135737.GB9355@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040324135737.GB9355@suse.de>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-24T14:57:37,
   Marcus Meissner <meissner@suse.de> said:

Hi Andrew, the patch looks good to me (I originally stumbled across this
when debugging an application trying to use SIGIO, which is currently
broken on ppc64).

Could you please pick it up?

s390x, sparc64 might also be affected, btw.

Why are all these archs not using the asm-generic/siginfo.h anyway?
*sigh*. Oh well.

> Hi,
> 
> After discussion on the glibc list the result was that 
> si_band is "long int" according to POSIX:
> 
> 	http://www.opengroup.org/onlinepubs/007904975/basedefs/signal.h.html
> 
> Ulrich Drepper refused a patch to fix glibc due to this reason:
> 	http://sources.redhat.com/ml/libc-alpha/2004-03/msg00254.html
> 
> so here is the patch to fix it in the kernel.
> 
> ppc64 and s390x were broken before and are fixed by this patch too.
> 
> Please apply.
> 
> Ciao, Marcus
> 
> --- linux-2.6.4/include/asm-generic/siginfo.h.xx	2004-03-24 14:44:23.000000000 +0100
> +++ linux-2.6.4/include/asm-generic/siginfo.h	2004-03-24 14:44:36.000000000 +0100
> @@ -27,7 +27,7 @@
>  #endif
>  
>  #ifndef __ARCH_SI_BAND_T
> -#define __ARCH_SI_BAND_T int
> +#define __ARCH_SI_BAND_T long int
>  #endif
>  
>  #ifndef HAVE_ARCH_SIGINFO_T
> --- linux-2.6.4/include/asm-x86_64/siginfo.h.xx	2004-03-24 14:45:26.000000000 +0100
> +++ linux-2.6.4/include/asm-x86_64/siginfo.h	2004-03-24 14:45:34.000000000 +0100
> @@ -3,8 +3,6 @@
>  
>  #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
>  
> -#define __ARCH_SI_BAND_T long
> -
>  #define SIGEV_PAD_SIZE ((SIGEV_MAX_SIZE/sizeof(int)) - 4)
>  
>  #include <asm-generic/siginfo.h>
> 
> Ciao, Marcus


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

