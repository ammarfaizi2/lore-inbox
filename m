Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVHWVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVHWVtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHWVo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:29 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:40940 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S932442AbVHWVoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 6/8] remove duplicated sys_open32() code from 64bit archs
Date: Tue, 23 Aug 2005 23:44:05 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508232344.05666.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 23 August 2005 22:43, Miklos Szeredi wrote:
> 64 bit architectures all implement their own compatibility sys_open(),
> when in fact the difference is simply not forcing the O_LARGEFILE
> flag.  So use the a common function instead.

> Index: linux/arch/x86_64/ia32/sys_ia32.c
> ===================================================================
> --- linux.orig/arch/x86_64/ia32/sys_ia32.c	2005-08-23 20:22:33.000000000 +0200
> +++ linux/arch/x86_64/ia32/sys_ia32.c	2005-08-23 21:00:19.000000000 +0200
> @@ -971,28 +971,7 @@ long sys32_kill(int pid, int sig)
>   
>  asmlinkage long sys32_open(const char __user * filename, int flags, int mode)
>  {
> -	char * tmp;
> -	int fd, error;

Please don't leave the functions inside of the architecture specific code.
The code is common enough to be shared, so just put a new compat_sys_open()
function into fs/compat.c.

I'm also not sure wether s390, mips and/or parisc need to use the
same function instead of the standard sys_open().

	Arnd <><
