Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbREYEZz>; Fri, 25 May 2001 00:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263522AbREYEZp>; Fri, 25 May 2001 00:25:45 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:52198 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S263521AbREYEZh>; Fri, 25 May 2001 00:25:37 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2CE@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Andrew Morton'" <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>
Cc: Dawson Engler <engler@csl.stanford.edu>, linux-kernel@vger.kernel.org
Subject: RE: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Date: Thu, 24 May 2001 21:23:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:andrewm@uow.edu.au]
> 
> Andreas Dilger wrote:
> > 
> > On a side note, does anyone know if the kernel does checking if the
> > stack overflowed at any time?
> 
> There's a little bit of code in show_task() which calculates
> how close this task ever got to overrunning its kernel stack:
> 
>         {
>                 unsigned long * n = (unsigned long *) (p+1);
>                 while (!*n)
>                         n++;
>                 free = (unsigned long) n - (unsigned long)(p+1);
>         }
>         printk("%5lu %5d %6d ", free, p->pid, p->p_pptr->pid);
> 
> SYSRQ-T will trigger this.
> 
> However it doesn't work, because do_fork() doesn't zero
> out the stack pages when they're created.

If do_fork() performance is an issue, at least clearing the stack
pages as a build option would be nice for some of us.

~Randy

