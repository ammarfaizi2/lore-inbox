Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129289AbQK0SmH>; Mon, 27 Nov 2000 13:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130013AbQK0Sl6>; Mon, 27 Nov 2000 13:41:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S129289AbQK0Sls>; Mon, 27 Nov 2000 13:41:48 -0500
Date: Mon, 27 Nov 2000 13:11:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001127182113.A15029@athlon.random>
Message-ID: <Pine.LNX.3.95.1001127130308.760B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Andrea Arcangeli wrote:

> On Mon, Nov 27, 2000 at 12:39:55AM -0800, David S. Miller wrote:
> > Also I believe linkers are allowed to arbitrarily reorder members in
> > the data and bss sections.  I could be wrong on this one though.
> 
> I'm not sure either, but we certainly rely on that behaviour somewhere.
> Just to make an example fs/dquot.c:
> 
> 	int nr_dquots, nr_free_dquots;
> 
> kernel/sysctl.c:
> 
> 	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
> 
> The above is ok also on mips in practice though.
> 

This code is simply wrong! You can't assume that the declaration of
two variables, no matter how similar, makes them adjacent in
memory! You also can't assume any order. We have good 'C' compilers
that do order things as we assume, however it is only fortuitous, and
not defined any any rule(s).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
