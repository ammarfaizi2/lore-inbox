Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUCAMcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUCAMcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:32:16 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:36229 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261178AbUCAMcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:32:14 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][5/7] Fix ppc32 hooks.
Date: Mon, 1 Mar 2004 18:01:59 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net> <20040227214605.GH1052@smtp.west.cox.net>
In-Reply-To: <20040227214605.GH1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011801.59447.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok to checkin.

-Amit

On Saturday 28 Feb 2004 3:16 am, Tom Rini wrote:
> Hello.  The following removes the only PPC32 CHK_DEBUGGER statement,
> as we've always been making kgdb take over the various debugger pointers.
>
> diff -zrupN linux-2.6.3+config+serial/arch/ppc/mm/fault.c
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/ppc/mm/fault.c ---
> linux-2.6.3+config+serial/arch/ppc/mm/fault.c	2004-02-27 12:16:13.000000000
> -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/ppc/mm/fault.c	2004-02-27
> 12:16:14.000000000 -0700 @@ -351,13 +351,11 @@ bad_page_fault(struct
> pt_regs *regs, uns
>  	}
>
>  	/* kernel has accessed a bad area */
> -#if defined(CONFIG_XMON)
> +#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
>  	if (debugger_kernel_faults)
>  		debugger(regs);
>  #endif
>
> -	CHK_DEBUGGER(14, sig,0, regs,)
> -
>  	die("kernel access of bad area", regs, sig);
>  }

