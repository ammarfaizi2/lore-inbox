Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVBHRR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVBHRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBHRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:17:28 -0500
Received: from gprs214-193.eurotel.cz ([160.218.214.193]:42134 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261586AbVBHRRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:17:24 -0500
Date: Tue, 8 Feb 2005 18:13:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, dsd@gentoo.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050208171315.GA1062@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org> <420801D7.3020405@gentoo.org> <20050207161810.23fcc4f1.akpm@osdl.org> <Pine.LNX.4.61.0502080154200.31698@alpha.polcom.net> <20050207200627.51c029cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207200627.51c029cd.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > How should one set about reproducing this problem?
> > 
> >  IIRC, Some minimal "personal" version can be downloaded from borland.com.
> 
> Well I'd prefer that we not back out the whole patch.  Could someone please
> test with something like the below, let us know exactly where it's falling
> over?

Sorry, it seems your debugging traps do not trigger. I'll try other
patches...
								Pavel

> --- 25/fs/binfmt_elf.c~a	2005-02-07 20:01:16.000000000 -0800
> +++ 25-akpm/fs/binfmt_elf.c	2005-02-07 20:03:51.000000000 -0800
> @@ -44,6 +44,8 @@
>  
>  #include <linux/elf.h>
>  
> +#define D() do { printk("%s:%d\n", __FILE__, __LINE__); dump_stack(); } while (0)
> +
>  static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
>  static int load_elf_library(struct file*);
>  static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
> @@ -181,8 +183,10 @@ create_elf_tables(struct linux_binprm *b
>  			STACK_ALLOC(p, ((current->pid % 64) << 7));
>  #endif
>  		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
> -		if (__copy_to_user(u_platform, k_platform, len))
> +		if (__copy_to_user(u_platform, k_platform, len)) {
> +			D();
>  			return -EFAULT;
> +		}

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
