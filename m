Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWBKLWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWBKLWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBKLWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:22:10 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:39995 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751405AbWBKLWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:22:08 -0500
Date: Sat, 11 Feb 2006 12:21:57 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] updated fstatat64 support
Message-ID: <20060211112157.GA9371@osiris.boeblingen.de.ibm.com>
References: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.15.i686/arch/i386/kernel/syscall_table.S-at	2006-02-06 13:11:24.000000000 -0800
> +++ linux-2.6.15.i686/arch/i386/kernel/syscall_table.S	2006-02-06 13:11:34.000000000 -0800
> @@ -299,7 +299,7 @@
>  	.long sys_mknodat
>  	.long sys_fchownat
>  	.long sys_futimesat
> -	.long sys_newfstatat		/* 300 */
> +	.long sys_fstatat64		/* 300 */
>  	.long sys_unlinkat
>  	.long sys_renameat
>  	.long sys_linkat
> --- linux-2.6.15.i686/arch/x86_64/ia32/ia32entry.S-at	2006-02-06 13:05:04.000000000 -0800
> +++ linux-2.6.15.i686/arch/x86_64/ia32/ia32entry.S	2006-02-06 13:05:21.000000000 -0800
> @@ -677,7 +677,7 @@
>  	.quad sys_mknodat
>  	.quad sys_fchownat
>  	.quad compat_sys_futimesat
> -	.quad compat_sys_newfstatat	/* 300 */
> +	.quad sys32_fstatat		/* 300 */
>  	.quad sys_unlinkat
>  	.quad sys_renameat
>  	.quad sys_linkat

So we end up with sys_newfstatat for 64 bit architectures, sys_fstatat64
for 32 bit architectures and sys32_fstatat for compat mode. Shouldn't the
name of the compat call changed to sys32_fstatat64?
At least that is how it used to be for all other *64 compat system calls
like e.g. fstat64.

Heiko
