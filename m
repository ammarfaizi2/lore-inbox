Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbTCPWQB>; Sun, 16 Mar 2003 17:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbTCPWQB>; Sun, 16 Mar 2003 17:16:01 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:50183 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262771AbTCPWQA>; Sun, 16 Mar 2003 17:16:00 -0500
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
From: James Bottomley <James.Bottomley@steeleye.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.GSO.4.21.0303162058200.17014-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303162058200.17014-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Mar 2003 16:26:37 -0600
Message-Id: <1047853600.4371.40.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 14:00, Geert Uytterhoeven wrote:
> On 16 Mar 2003, James Bottomley wrote:
> > On Sun, 2003-03-16 at 12:36, Geert Uytterhoeven wrote:
> > > Actually, it was my suggestion to remove the dereference for PIO accesses. In
> > > that case SASR contains the I/O port register.
> > 
> > There's still something wrong with the implementation in this patch. 
> > For non PIO SASR is defined as volatile unsigned char *SASR.  Its access
> > has gone from being outb(n, *regs.SASR) to outb(n, regs.SASR).  What
> > expansion can outb have on m68k and MIPS that makes this change
> > idempotent?
> 
> outb() and friends are only used if CONFIG_WD33C93_PIO is set. In all other
> cases, it uses the old implementation, e.g. `*regs.SASR = reg_num'.

Ah, OK, I see what it's doing.  Instead of having a single redefine of
wd33c93_outb to be either outb or readb etc, it has a whole chunk of
code in wd33c93.c that #ifdef's for this.

Perhaps, while you're cleaning this up, you'd like to move this into the
header?  Shouldn't it also be using readb/writeb instead of just direct
memory accesses?

James


