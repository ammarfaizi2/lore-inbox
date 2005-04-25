Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVDYT57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVDYT57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVDYT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:57:59 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:37761 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262749AbVDYT5v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:57:51 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [patch 1/1] uml: fix handling of no fpx_regs [critical, for
	2.6.12]
From: Alexander Nyberg <alexn@dsv.su.se>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, aleidenf@bigpond.net.au
In-Reply-To: <20050425191253.B9FE045EBB@zion>
References: <20050425191253.B9FE045EBB@zion>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 25 Apr 2005 21:57:47 +0200
Message-Id: <1114459067.983.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mån 2005-04-25 klockan 21:12 +0200 skrev blaisorblade@yahoo.it:
> From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Fix the error path, which is triggered when the processor misses the fpx regs
> (i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Tested and
> obvious, please merge ASAP.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling arch/um/os-Linux/sys-i386/registers.c
> --- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling	2005-04-25 21:03:11.000000000 +0200
> +++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25 21:08:07.000000000 +0200
> @@ -105,14 +105,15 @@ void init_registers(int pid)
>  		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
>  		      err);
>  
> +	errno = 0;
>  	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
>  	if(!err)
>  		return;
> +	if(errno != EIO)
> +		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
> +		      errno);

Looks like you mean "if (err != EIO)" here


>  	have_fpx_regs = 0;
> -	if(err != EIO)
> -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
> -		      err);
>  
>  	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
>  	if(err)



