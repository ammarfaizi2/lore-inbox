Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286315AbRL0Pxv>; Thu, 27 Dec 2001 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286318AbRL0Pxm>; Thu, 27 Dec 2001 10:53:42 -0500
Received: from c88s124h4.upc.chello.no ([62.179.175.88]:30871 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286315AbRL0Pxa>; Thu, 27 Dec 2001 10:53:30 -0500
Subject: Re: Again:syscall from modules
From: Terje Eggestad <terje.eggestad@scali.com>
To: Amber Palekar <amber_palekar@yahoo.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Dec 2001 16:54:25 +0100
Message-Id: <1009468465.15846.0.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the sys_* funcs are declared asmlinkage int sys_*. 
where the asmlinkage differ from platform to platform. 
It's used to tell the compiler if a non standared calling 
convertion is used, typically if params are passed by registers
instead of stack. The asmlinkage define must be sett according to the
syscall dispatcher (entry.S on ia32), and may be changed accordingly. 

In short, if you want to use sys_* you must understand the interaction
between the sys_* funcs and the dispatcher on *every* platform, and
the interaction may change without notice.

In short short, don't don't don't don't use the sys_* functions.

TJ

On Tue, 2001-12-25 at 14:14, Amber Palekar wrote:
> 
>  Hi,
>  
> > Just use sock_sendmsg() and sock_recvmsg() directly.
> > They are both
> > exported in netsyms.c.
>   Is there any specific reason behind not exporting
> sys_sendto and sys_recvfrom ??
> 
> > Cheers,
> >   Trond
> 
> TIA
> Amber
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Send your FREE holiday greetings online!
> http://greetings.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




