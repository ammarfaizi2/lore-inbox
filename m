Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270661AbTGNQxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270690AbTGNQrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:47:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1371 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270684AbTGNQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:47:01 -0400
Date: Mon, 14 Jul 2003 13:00:24 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>,
       anton@samba.org, ak@muc.de, schwidefsky@de.ibm.com, matthew@wil.cx
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714130024.M15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com> <20030715025252.17ec8d6f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030715025252.17ec8d6f.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Tue, Jul 15, 2003 at 02:52:52AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:52:52AM +1000, Stephen Rothwell wrote:
> diff -ruN 2.6.0-test1/include/asm-s390/siginfo.h 2.6.0-test1-sfr.1/include/asm-s390/siginfo.h
> --- 2.6.0-test1/include/asm-s390/siginfo.h	2002-11-05 16:58:19.000000000 +1100
> +++ 2.6.0-test1-sfr.1/include/asm-s390/siginfo.h	2003-07-15 02:34:55.000000000 +1000
> @@ -9,78 +9,12 @@
>  #ifndef _S390_SIGINFO_H
>  #define _S390_SIGINFO_H
>  
> -#define HAVE_ARCH_SI_CODES
> +#include <linux/config.h>
...
> +#ifdef CONFIG_ARCH_S390X
> +#define	__ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
> +#endif

This is not correct for the merged header.
It needs to be:
#ifdef __s390x__
#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
#endif

Furthermore, there needs to be a pad inserted fo arch/s390x/kernel/signal.c
(rt_sigframe right after info member) to keep binary compatibility.

	Jakub
