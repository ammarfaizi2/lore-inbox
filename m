Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTBRK1m>; Tue, 18 Feb 2003 05:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTBRK1m>; Tue, 18 Feb 2003 05:27:42 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:48394 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264790AbTBRK1l>; Tue, 18 Feb 2003 05:27:41 -0500
Date: Tue, 18 Feb 2003 10:37:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (2/26) APM
Message-ID: <20030218103741.A11969@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217134955.GB4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217134955.GB4799@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Mon, Feb 17, 2003 at 10:49:55PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 10:49:55PM +0900, Osamu Tomita wrote:
> +#include "io_ports.h"

Isn't this introduced in a later patch?  Please make sure your patchkit
never breaks the compile of the existing subarches when applied in order.

>  		"pushl %%edi\n\t"
>  		"pushl %%ebp\n\t"
> +#ifdef CONFIG_X86_PC9800
> +		"pushfl\n\t"
> +#endif
>  		"lcall *%%cs:apm_bios_entry\n\t"
>  		"setc %%al\n\t"
>  		"popl %%ebp\n\t"
> @@ -682,6 +687,9 @@
>  		__asm__ __volatile__(APM_DO_ZERO_SEGS
>  			"pushl %%edi\n\t"
>  			"pushl %%ebp\n\t"
> +#ifdef CONFIG_X86_PC9800
> +			"pushfl\n\t"
> +#endif

Maybe add a

#ifdef CONFIG_X86_PC9800
#define COND_PUSHFL	"pushfl\n\t"
#else
#define COND_PUSHFL	"pushfl\n\t"
#endif

to the top of this file and then use it?

> +#ifndef CONFIG_X86_PC9800

Once again please always use #ifdef instead of #ifndef where possible.

