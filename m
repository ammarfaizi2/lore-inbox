Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSCEQiK>; Tue, 5 Mar 2002 11:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293445AbSCEQhx>; Tue, 5 Mar 2002 11:37:53 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:64950 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S293437AbSCEQhd>; Tue, 5 Mar 2002 11:37:33 -0500
Date: Tue, 5 Mar 2002 11:36:59 -0500 (EST)
From: Bill Davidsen <davidsen@prodigy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18-pre/rc broke PLIP
In-Reply-To: <200202242320.AAA15930@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.21.0203051123180.23567-100000@deathstar.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Mikael Pettersson wrote:

> Someone (sorry I forgot who) reported having problems with
> PLIP in recent kernels. I've done some testing and can confirm
> that PLIP worked up to 2.4.17 but broke in 2.4.18-pre/rc.
> The only thing PLIP does is put "plip0: transmit timeout(1,87)"
> messages in the kernel log.
> 
> After a lot of testing I've narrowed it down to the following
> hunk in the 2.4.18-rc4 patch:
> 
> --- linux.orig/drivers/parport/parport_pc.c	Mon Feb 18 20:18:40 2002
> +++ linux/drivers/parport/parport_pc.c	Mon Jan 14 19:08:50 2002
> @@ -2212,7 +2233,7 @@
>  	}
>  	memcpy (ops, &parport_pc_ops, sizeof (struct parport_operations));
>  	priv->ctr = 0xc;
> -	priv->ctr_writable = 0xff;
> +	priv->ctr_writable = ~0x10;
>  	priv->ecr = 0;
>  	priv->fifo_depth = 0;
>  	priv->dma_buf = 0;
> 
> If I back this hunk out, PLIP starts working again.
> Is this fix sufficient or is there something else that need fixing?

  I'm still looking at this, trying to figure out what they were trying to
do here... but I note the same code in parport_gsc.c was NOT
changed. Putting it back makes it work for me, but the code is not long on
comments, and digging up all the data sheets for various supported chips
is not a casual job.

  I'm going to browse the code more this week, the bit not set isn't
documented where I've looked :-(

  Anyway, back to working, perhaps there was a note with the patch giving
some hint of what it was doing?

-- 
bill davidsen <davidsen@tmr.com> CTO, TMR Associates, Inc
  Programming without software engineering is like sculpting with a chain
saw. The very talented can produce a work of art, the mediocre wind up with
a misshapen lump in a pile of rubble, and in neither case does the end
result have more than a passing resemblance to the original intent.

