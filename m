Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262725AbTCPSoI>; Sun, 16 Mar 2003 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTCPSoI>; Sun, 16 Mar 2003 13:44:08 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:26631 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262725AbTCPSoH>; Sun, 16 Mar 2003 13:44:07 -0500
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
From: James Bottomley <James.Bottomley@steeleye.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.GSO.4.21.0303161934340.17014-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303161934340.17014-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Mar 2003 12:54:43 -0600
Message-Id: <1047840886.4371.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 12:36, Geert Uytterhoeven wrote:
> Actually, it was my suggestion to remove the dereference for PIO accesses. In
> that case SASR contains the I/O port register.

There's still something wrong with the implementation in this patch. 
For non PIO SASR is defined as volatile unsigned char *SASR.  Its access
has gone from being outb(n, *regs.SASR) to outb(n, regs.SASR).  What
expansion can outb have on m68k and MIPS that makes this change
idempotent?

James


