Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUIPT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUIPT7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUIPT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:59:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4102 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268182AbUIPT7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:59:40 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH] reduce [compat]_do_execve stack usage
Date: Thu, 16 Sep 2004 22:59:27 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200409151705.11356.vda@port.imtp.ilyichevsk.odessa.ua> <1095359422.5527.22.camel@tdi>
In-Reply-To: <1095359422.5527.22.camel@tdi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409162259.27676.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 21:30, Alex Williamson wrote:
>    Looks like a couple struct to pointer conversions were missed.
> Current bk won't build for me w/o this:
>
> ===== fs/compat.c 1.41 vs edited =====
> --- 1.41/fs/compat.c	2004-09-14 17:24:46 -06:00
> +++ edited/fs/compat.c	2004-09-16 12:19:26 -06:00
> @@ -1399,11 +1399,11 @@
>  	if (retval < 0)
>  		goto out_mm;
>
> -	bprm.argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
> +	bprm->argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
>  	if ((retval = bprm->argc) < 0)
>  		goto out_mm;
>
> -	bprm.envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
> +	bprm->envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
>  	if ((retval = bprm->envc) < 0)
>  		goto out_mm;

Seems I missed that. Probably with my .config
this code does not get included in the build...

Thanks.
--
vda

