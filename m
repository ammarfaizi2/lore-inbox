Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280517AbRJaVLl>; Wed, 31 Oct 2001 16:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280521AbRJaVLb>; Wed, 31 Oct 2001 16:11:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28801 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280517AbRJaVLS>; Wed, 31 Oct 2001 16:11:18 -0500
Date: Wed, 31 Oct 2001 16:11:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.3.95.1011031160627.21906A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Tim Schmielau wrote:

> On Wed, 31 Oct 2001, vda wrote:
> 
[SNIPPED...]
> 
> btw.: can someone please explain to me why do_timer uses
> 	(*(unsigned long *)&jiffies)++;
> instead of just doing jiffies++ ?
> 
> Tim

It's an attempt to prevent the 'C' compiler from doing this:

	movl	(jiffies), %eax   # Read
	incl	%eax              # Modify
	movl	%eax, (jiffies)   # Write

Instead, we want it to do this:

	movl	jiffies, %ebx     # init a pointer
	incl	(%ebx)            # Modify directly

With some gcc versions, it works. Others, it doesn't hurt.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


