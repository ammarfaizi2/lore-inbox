Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSAPQ0c>; Wed, 16 Jan 2002 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289986AbSAPQ0Y>; Wed, 16 Jan 2002 11:26:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23681 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289954AbSAPQ0K>; Wed, 16 Jan 2002 11:26:10 -0500
Date: Wed, 16 Jan 2002 11:16:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <20020116151852.B31993@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.3.95.1020116110901.13296A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Jamie Lokier wrote:

> Alan Cox wrote:
> > > What's the point of optimizing an IF to a cmov if I have
> > > to insert another IF to see if I can use cmov?
> > 
> > I've always wondered. Intel made the instruction optional yet there isnt
> > an obvious way to do runtime fixups on it
> 
> Yes there is -- emulation! :-)
> 

It's just as bad, probably worse! You trap on an invalid op-code. The
trap-handler checks the op-code and if it's emulated, it emulates it
and returns to the executing task. This takes many instruction cycles,
certainly more than `if(cmov) doit; else do_something_else;` --which,
itself, takes many more instruction cycles than cmov is supposed to
reduce. It's a no-win situation. The only way to win is a compile-time
choice. This means customizing for your CPU IFF it has the cmov
instruction.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


