Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSDVPpu>; Mon, 22 Apr 2002 11:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314230AbSDVPpt>; Mon, 22 Apr 2002 11:45:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25474 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314227AbSDVPps>; Mon, 22 Apr 2002 11:45:48 -0400
Date: Mon, 22 Apr 2002 11:48:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DJ Barrow <dj.barrow@asitatech.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
In-Reply-To: <20020422151025Z314220-22651+13849@vger.kernel.org>
Message-ID: <Pine.LNX.3.95.1020422113750.11343A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, DJ Barrow wrote:

> Hi ,
> While debugging last night with Brian O'Sullivan I found this beauty.
> 
> char *in_ntoa(__u32 in)
> {
>         static char buff[18];
>         char *p;
> 
>         p = (char *) &in;
>         sprintf(buff, "%d.%d.%d.%d",
>                 (p[0] & 255), (p[1] & 255), (p[2] & 255), (p[3] & 255));
>         return(buff);
> }
> 
> This textbook peice of novice coding which has existed since 2.2.14.
> For those who can't spot the error, please note that this function is 
> returning a static string, excellent stuff if you are hoping to reuse the 
> same function like the following
> printk("%s %s\n",in_ntoa(addr1),in_ntoa(addr2));
> -

I love it! Last guy wins! I wonder how you fix it without having to
pass it a pointer to something the caller owns?  This is, truly,
non-trivial. Also, this is in ../linux/net, not something specific
to Intel, and there is no macro to handle the network-order. It
just 'comes-out-right' with Intel machines.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

