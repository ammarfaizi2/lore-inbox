Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUJSJDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUJSJDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJSJDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:03:53 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:6843 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268080AbUJSJDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:03:49 -0400
Date: Tue, 19 Oct 2004 11:03:46 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 BK build broken
Message-ID: <20041019090346.GB6020@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041019021719.GA22924@merlin.emma.line.org> <20041018221041.184632cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018221041.184632cb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Andrew Morton wrote:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> >
> > include/linux/compiler.h:20: syntax error in macro parameter list
> 
> I used this:
> 
> diff -puN include/linux/compiler.h~builtin_warning-is-not-traditional include/linux/compiler.h
> --- 25/include/linux/compiler.h~builtin_warning-is-not-traditional	2004-10-18 22:08:25.224796488 -0700
> +++ 25-akpm/include/linux/compiler.h	2004-10-18 22:09:05.505672864 -0700
> @@ -17,7 +17,9 @@ extern void __chk_io_ptr(void __iomem *)
>  # define __iomem
>  # define __chk_user_ptr(x) (void)0
>  # define __chk_io_ptr(x) (void)0
> -#define __builtin_warning(x, ...) (1)
> +#ifndef __ASSEMBLY__	/* gcc -traditional fails with varargs-style macros */
> +# define __builtin_warning(x, ...) (1)
> +#endif
>  #endif

This fixes the problem for me with SuSE's gcc-3.3.3-41, with pristine
gcc-3.3.4 and gcc-3.4.2.

Thank you!

-- 
Matthias Andree
