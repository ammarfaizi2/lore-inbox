Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSJJOZl>; Thu, 10 Oct 2002 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJJOZl>; Thu, 10 Oct 2002 10:25:41 -0400
Received: from thinkpad.c0202001.roe.itnq.net ([217.112.132.138]:42624 "EHLO
	thinkpad.c0202001.roe.itnq.net") by vger.kernel.org with ESMTP
	id <S261605AbSJJOZk>; Thu, 10 Oct 2002 10:25:40 -0400
Date: Thu, 10 Oct 2002 16:31:43 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.c0202001.roe.itnq.net
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
 forever)
In-Reply-To: <Pine.LNX.4.44L.0210100240120.1477-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.43.0210101626350.475-100000@thinkpad.c0202001.roe.itnq.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've applied patch sent by Marcelo (below) (by hand since it fails with
patch -p0)  and now I'm able to boot 2.4.19pre3. The result of this
testing is that this kernel has the bug too, so IMHO this bug/feature was
introduced between 2.4.19pre2 and 2.4.19pre3.

Any other patch/idea which should I try?

Thanks a lot,

Karel

> > 2.4.18      - OK (I'm using this now)
> > 2.4.19pre1  - OK
> > 2.4.19pre2  - OK
> > 2.4.19pre3  - doesn't boot for me.^
> > 2.4.19pre4  - BUG
> > 2.4.19pre5  - BUG
> > 2.4.19      - BUG
> > 2.4.20pre10 - BUG
> >

[sniped]

> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.181   -> 1.181.1.1
> #	arch/i386/kernel/bluesmoke.c	1.13    -> 1.14
> #
> # --------------------------------------------
> # 02/03/14	marcelo@plucky.distro.conectiva	1.181.1.1
> # Remove off-by-one Davej's fix in bluesmoke.c: it causes some
> # machines to crash at boot.
> #
> # --------------------------------------------
> #
> diff -Nru a/arch/i386/kernel/bluesmoke.c b/arch/i386/kernel/bluesmoke.c
> --- a/arch/i386/kernel/bluesmoke.c	Thu Oct 10 02:40:07 2002
> +++ b/arch/i386/kernel/bluesmoke.c	Thu Oct 10 02:40:07 2002
> @@ -169,7 +169,7 @@
>  	if(l&(1<<8))
>  		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>  	banks = l&0xff;
> -	for(i=0;i<banks;i++)
> +	for(i=1;i<banks;i++)
>  	{
>  		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
>  	}
>
>

--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

