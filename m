Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbTCPTt0>; Sun, 16 Mar 2003 14:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbTCPTt0>; Sun, 16 Mar 2003 14:49:26 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:53497 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262744AbTCPTtZ>;
	Sun, 16 Mar 2003 14:49:25 -0500
Date: Sun, 16 Mar 2003 21:00:18 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
In-Reply-To: <1047840886.4371.34.camel@mulgrave>
Message-ID: <Pine.GSO.4.21.0303162058200.17014-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Mar 2003, James Bottomley wrote:
> On Sun, 2003-03-16 at 12:36, Geert Uytterhoeven wrote:
> > Actually, it was my suggestion to remove the dereference for PIO accesses. In
> > that case SASR contains the I/O port register.
> 
> There's still something wrong with the implementation in this patch. 
> For non PIO SASR is defined as volatile unsigned char *SASR.  Its access
> has gone from being outb(n, *regs.SASR) to outb(n, regs.SASR).  What
> expansion can outb have on m68k and MIPS that makes this change
> idempotent?

outb() and friends are only used if CONFIG_WD33C93_PIO is set. In all other
cases, it uses the old implementation, e.g. `*regs.SASR = reg_num'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

