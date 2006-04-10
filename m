Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDJKyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDJKyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDJKyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:54:13 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:706 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751131AbWDJKyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:54:12 -0400
Date: Mon, 10 Apr 2006 19:51:15 +0900 (JST)
Message-Id: <20060410.195115.109991900.taka@valinux.co.jp>
To: from-linux-kernel@I-love.SAKURA.ne.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cent OS 4.3] Bug in do_execve().
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200604101942.GFJ52540.JMFSOVttFSPMGLNYO@I-love.SAKURA.ne.jp>
References: <200604101942.GFJ52540.JMFSOVttFSPMGLNYO@I-love.SAKURA.ne.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current do_execve() doesn't have the bug.
You should let CentOS team know the bug instead.

> Hello.
> 
> Kernel 2.6.9 has a bug that forgets to undo open_exec() in do_execve().
> This bug was fixed in 2.6.10.
> 
> I noticed this bug remains in kernel-2.6.9-34.EL.src.rpm for Cent OS.
> Distributors who use 2.6.9-based kernels, please check this.
> 
> ---------- Start of patch ----------
> --- before/exec.c	2006-04-10 11:34:58.000000000 +0900
> +++ after/exec.c	2006-04-10 13:04:51.000000000 +0900
> @@ -1168,8 +1168,11 @@ int do_execve(char * filename,
>  
>  	retval = -ENOMEM;
>  	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
> -	if (!bprm)
> +	if (!bprm) {
> +		allow_write_access(file);
> +		fput(file);
>  		goto out_ret;
> +	}
>  	memset(bprm, 0, sizeof(*bprm));
>  
>  	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
> ---------- End of patch ----------
> 
> Regards.

