Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCWNZN>; Sat, 23 Mar 2002 08:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSCWNZE>; Sat, 23 Mar 2002 08:25:04 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:50227 "EHLO
	tsmtp10.mail.isp") by vger.kernel.org with ESMTP id <S293071AbSCWNYx>;
	Sat, 23 Mar 2002 08:24:53 -0500
Date: Sat, 23 Mar 2002 14:25:24 +0100
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Reproducible oops in 2.5.7-pre2
Message-Id: <20020323142524.17331624.DiegoCG@teleline.es>
In-Reply-To: <20020323141920.2ccd858e.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This oops happens _always_ when I try to boot with 2.4.7-pre2. It happens just after:
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
> found reiserfs format "3.6" with standard journal

OK, this problem has been reported, and it seems there's a patch. I'm sorry for not reading all messages of the list ;)



> Another thing with 2.5.7-pre2 kernel is that i can't compile it without having nfs server sopport enabled.
> This is the error:
> arch/i386/kernel/kernel.o: In function 'sys_call_table':
> arch/i386/kernel/kernel.o(.data+0x304): undefined reference to 'sys_nfsservctl'
> make: *** [vmlinux] Error 1
> 
> I think the problem is in include/linux/nfsd/syscall.h:
> 
> /*
>  * Kernel syscall implementation
>  */
> #if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
> extern asmlinkage long sys_nfsservctl(int, struct nfsctl_arg *, void);
> #else
> #define sys_nsfservctl		sys_ni_syscall
> #endif
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
