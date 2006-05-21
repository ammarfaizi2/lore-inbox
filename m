Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWEUTiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWEUTiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWEUTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:38:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3602 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964924AbWEUTiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:38:18 -0400
Date: Sun, 21 May 2006 21:38:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521193818.GE3339@stusta.de>
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <20060521160332.GA8250@redhat.com> <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com> <20060521185000.GB8250@redhat.com> <20060521185610.GC8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521185610.GC8250@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 02:56:10PM -0400, Dave Jones wrote:
> 
> Actually it is kinda throttled, but only on process name.
> This patch just removes that stuff completely.
> (Also removes a bunch of trailing whitespace)
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c~	2006-05-21 14:50:57.000000000 -0400
> +++ linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c	2006-05-21 14:51:48.000000000 -0400
> @@ -522,17 +522,9 @@ sys32_waitpid(compat_pid_t pid, unsigned
>  }
>  
>  int sys32_ni_syscall(int call)
> -{ 
> -	struct task_struct *me = current;
> -	static char lastcomm[sizeof(me->comm)];
> -
> -	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
> -		printk(KERN_INFO "IA32 syscall %d from %s not implemented\n",
> -		       call, me->comm);
> -		strncpy(lastcomm, me->comm, sizeof(lastcomm));
> -	} 
> -	return -ENOSYS;	       
> -} 
> +{
> +	return -ENOSYS;
> +}
>...

Why can't we remove sys32_ni_syscall() and call sys_ni_syscall() 
instead if all we want to do is to return -ENOSYS?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

