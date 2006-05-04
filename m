Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWEDWuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWEDWuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWEDWuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:50:17 -0400
Received: from ozlabs.org ([203.10.76.45]:40376 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932346AbWEDWuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:50:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17498.34041.993647.189930@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 08:49:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
In-Reply-To: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes:

> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -236,6 +236,7 @@ arch_initcall(ppc_init);
>  void __init setup_arch(char **cmdline_p)
>  {
>  	extern void do_init_bootmem(void);
> +	extern void setup_panic(void);

Urk.

> @@ -285,6 +286,9 @@ #endif
>  	/* reboot on panic */
>  	panic_timeout = 180;
>  
> +	if (ppc_md.panic)
> +		setup_panic();

Since no 32-bit platform sets ppc_md.panic AFAICS, I guess this
doesn't need to be pushed into 2.6.17.  Please redo with setup_panic
declared in a header file.

Paul.
