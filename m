Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVBHTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVBHTQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVBHTQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:16:21 -0500
Received: from hera.kernel.org ([209.128.68.125]:56219 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261633AbVBHTQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:16:19 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Date: Tue, 8 Feb 2005 11:16:25 -0800
Organization: Open Source Development Lab
Message-ID: <20050208111625.0bb1896d@dxpl.pdx.osdl.net>
References: <20050207221107.GA1369@elf.ucw.cz>
	<20050207145100.6208b8b9.akpm@osdl.org>
	<20050208175106.GA1091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1107890173 13594 172.20.1.103 (8 Feb 2005 19:16:13 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 8 Feb 2005 19:16:13 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 18:51:06 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > I wonder if reverting the patch will restore the old behaviour?
> 
> This seems to be minimal fix to get Kylix application back to the
> working state... Maybe it is good idea for 2.6.11?
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 								Pavel
> 
> --- clean/fs/binfmt_elf.c	2005-02-03 22:27:19.000000000 +0100
> +++ linux/fs/binfmt_elf.c	2005-02-08 18:46:38.000000000 +0100
> @@ -803,11 +803,8 @@
>  				nbyte = ELF_MIN_ALIGN - nbyte;
>  				if (nbyte > elf_brk - elf_bss)
>  					nbyte = elf_brk - elf_bss;
> -				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
> -					retval = -EFAULT;
> -					send_sig(SIGKILL, current, 0);
> -					goto out_free_dentry;
> -				}
> +				if (clear_user((void __user *) elf_bss + load_bias, nbyte))
> +					printk(KERN_ERR "Error clearing BSS, wrong ELF executable? (Kylix?!)\n");

do once or rate limit rather than log spamming.

-- 
Stephen Hemminger	<shemminger@osdl.org>
