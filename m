Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSIEQzA>; Thu, 5 Sep 2002 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSIEQzA>; Thu, 5 Sep 2002 12:55:00 -0400
Received: from [192.216.249.93] ([192.216.249.93]:26118 "EHLO willie.n0ano.com")
	by vger.kernel.org with ESMTP id <S317836AbSIEQy7>;
	Thu, 5 Sep 2002 12:54:59 -0400
From: Don Dugger <n0ano@n0ano.com>
Date: Thu, 5 Sep 2002 10:43:12 -0600
To: davidm@hpl.hp.com
Cc: R Sreelatha <rsreelat@in.ibm.com>, linux-ia64@linuxia64.org,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: patch for IA64: fix do_sys32_msgrcv bad address error.
Message-ID: <20020905104312.A30920@willie.n0ano.com>
References: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com> <15735.35748.328193.108301@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15735.35748.328193.108301@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Thu, Sep 05, 2002 at 09:51:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but Dave Millier claims that this patch is still broken, he says the
fix needs to be in `ipc_kludge'.  I don't have access to my source tree
until this evening, have you looked at this?

On Thu, Sep 05, 2002 at 09:51:48AM -0700, David Mosberger wrote:
> >>>>> On Thu, 5 Sep 2002 19:46:40 +0530, "R Sreelatha" <rsreelat@in.ibm.com> said:
> 
>   R> In sys_ia32.c file, in the do_sys32_msgrcv() function call, the
>   R> value of ipck.msgp is interpreted as a 64 bit address, whereas it
>   R> is a 32 bit address.  Hence, do_sys32_msgrcv() finally returns
>   R> EFAULT(bad address) error.  The patch below takes care of this by
>   R> type casting ipck.msgp to type u32.  The patch is created for
>   R> 2.5.32 version of the kernel.
> 
> Yes, this was obviously broken.  I committed the attached patch to my 2.5
> tree.
> 
> 	--david
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.532   -> 1.533  
> #	arch/ia64/ia32/sys_ia32.c	1.18    -> 1.19   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/09/05	davidm@tiger.hpl.hp.com	1.533
> # ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix proposed by
> # 	Dave Miller).
> # --------------------------------------------
> #
> diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
> --- a/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
> +++ b/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
> @@ -2111,8 +2111,8 @@
>  };
>  
>  struct ipc_kludge {
> -	struct msgbuf *msgp;
> -	long msgtyp;
> +	u32 msgp;
> +	s32 msgtyp;
>  };
>  
>  #define SEMOP		 1
> 
> _______________________________________________
> Linux-IA64 mailing list
> Linux-IA64@linuxia64.org
> http://lists.linuxia64.org/lists/listinfo/linux-ia64

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@n0ano.com
