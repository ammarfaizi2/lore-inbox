Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310405AbSCLFOc>; Tue, 12 Mar 2002 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310414AbSCLFOM>; Tue, 12 Mar 2002 00:14:12 -0500
Received: from ns.crrstv.net ([209.128.25.4]:57050 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S310412AbSCLFOI>;
	Tue, 12 Mar 2002 00:14:08 -0500
Date: Tue, 12 Mar 2002 01:13:48 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: skidley@localhost.localdomain
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: marcelo@conectiva.com.br, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <200203120051.BAA20236@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.43.0203120111280.1508-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Mikael Pettersson wrote:

> Marcelo wrote in the 2.4.19-pre3 announcement:
> >pre3:
> >- Fix off-by-one error in bluesmoke			(Dave Jones)
> 
> NO NO NO! This is the same broken patch that somehow got into
> 2.2.21pre4 as well. The patch changes the code to write to the
> IA32_MC0_CTL MSR, which is a big no-no. Intel's IA32 Vol3 manual
> (#245472-03) sections 13.3.2.1 and 13.5 make that point quite clear.
> 
> I have several P6 boxes that hang hard in MCE init trying to boot
> vanilla 2.2.21pre4 and 2.4.19-pre3. The issue is real.
> 
> Please apply the backup patch below.
> 
> /Mikael
> 
> --- linux-2.4.19-pre3/arch/i386/kernel/bluesmoke.c.~1~	Tue Mar 12 00:25:53 2002
> +++ linux-2.4.19-pre3/arch/i386/kernel/bluesmoke.c	Tue Mar 12 01:11:58 2002
> @@ -169,7 +169,7 @@
>  	if(l&(1<<8))
>  		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>  	banks = l&0xff;
> -	for(i=0;i<banks;i++)
> +	for(i=1;i<banks;i++)
>  	{
>  		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
>  	}
Just to confirm your patch fixes my MCE init lockup problem here as well.

--
Chad Young - Registered Linux User #195191 @ http://counter.li.org
-----------------------------------------------------------------------
Linux localhost 2.4.19-pre3 #1 Tue Mar 12 00:43:17 AST 2002 i686 unknown
  1:10am  up 0 min,  0 users,  load average: 0.39, 0.11, 0.03


