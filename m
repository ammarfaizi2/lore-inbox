Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316005AbSEJO3G>; Fri, 10 May 2002 10:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316006AbSEJO3F>; Fri, 10 May 2002 10:29:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316005AbSEJO3E>; Fri, 10 May 2002 10:29:04 -0400
Date: Fri, 10 May 2002 10:28:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Keith Owens <kaos@ocs.com.au>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spin-locks 
In-Reply-To: <26626.1021040270@redhat.com>
Message-ID: <Pine.LNX.3.95.1020510102809.156A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, David Woodhouse wrote:

> 
> root@chaos.analogic.com said:
> >  Well, here is code that worked on linux 2.2.17.  Same CPUs, same
> > everything... Just a different version of OS...
> 
> I suspect your code was protected by the BKL in 2.2.17, not by your 
> 'spinlocks'.
> 
> root@chaos.analogic.com said:
> > 	cli
> > 	lock
> > 	incb	(lockf)		# Bump lock-value 
> 
> Ponder what happens if two CPUs get here at the same time. Lock count is 
> now two.
> 
> > 1:	cmpb	$1,(lockf)	# See if we own it
> > 	jnz	1b		# Nope, spin until we do. 
> 
> Now they both spin forever.

Yep. You are correct. Obvious bug that went undetected for over
a year.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

