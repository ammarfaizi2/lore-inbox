Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRLQNga>; Mon, 17 Dec 2001 08:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRLQNgU>; Mon, 17 Dec 2001 08:36:20 -0500
Received: from [195.66.192.167] ([195.66.192.167]:21005 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278932AbRLQNgI>; Mon, 17 Dec 2001 08:36:08 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan-Benedict Glaw <jbglaw@microdata-pos.de>, linux-kernel@vger.kernel.org
Subject: Re: xchg and GCC's optimisation:-(
Date: Mon, 17 Dec 2001 15:33:47 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011217134526.A31801@microdata-pos.de>
In-Reply-To: <20011217134526.A31801@microdata-pos.de>
MIME-Version: 1.0
Message-Id: <01121715334709.02146@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 10:45, Jan-Benedict Glaw wrote:

> void free_dma(unsigned int dmanr)
> {
>         if (dmanr >= MAX_DMA_CHANNELS) {
>                 printk("Trying to free DMA%d\n", dmanr);
>                 return;
>         }
>
>         if (xchg(&dma_chan_busy[dmanr].lock, 0) == 0) {
> /* ERROR */     printk("Trying to free free DMA%d\n", dmanr);
>                 return;
>         }
>
> } /* free_dma */
>
> Including a real_printk() at the line marked with ERROR will
> result in:
[snip]
> ...which is fine and contains the needed xchg call. However,
> substituting the printk() with "do {} while (0)" above,
> the "if" path seems to be completely removed by the optimizer:
>
> 00000088 <free_dma>:
>   88:   c3                      ret
>   89:   8d b4 26 00 00 00 00    lea    0x0(%esi,1),%esi
>
>
> I've looked at ./include/asm-i386/system.h which does some black
> magic with it, and I don't really understand that. However, the
> result is that the xchg gets optimized away, rendering at least
> the floppy module unuseable:-(

There is a comment that asm is not 100% valid.
My GCC 3.0.1 does not produce buggy code, guess why?
It does _not_ inline __xchg() even at -O99!

So much of compiler improvement  8-(
--
vda
