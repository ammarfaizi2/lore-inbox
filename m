Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267207AbSKPCBm>; Fri, 15 Nov 2002 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbSKPCBm>; Fri, 15 Nov 2002 21:01:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:44208 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267207AbSKPCBl>; Fri, 15 Nov 2002 21:01:41 -0500
Subject: Re: lan based kgdb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD57A5F.87119CB4@digeo.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	<ar3op8$f20$1@penguin.transmeta.com>
	<20021115222430.GA1877@tahoe.alcove-fr>  <3DD57A5F.87119CB4@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 02:35:03 +0000
Message-Id: <1037414103.21922.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 22:51, Andrew Morton wrote:
> Stelian Pop wrote:
> > 
> > On Fri, Nov 15, 2002 at 09:26:00PM +0000, Linus Torvalds wrote:
> > 
> > > I dunno. I might even be willing to apply kgdb patches to my tree if it
> > > just could use the regular network card I already have connected on all
> > > my machines. None of my laptops have a serial line, for example, but
> > > they all have networking.
> > >
> > > Soon even _desktops_ probably won't have serial lines any more, only USB.
> > 
> > Using USB instead of the serial line or the network card would be
> > the best IMHO, because:
> > 
> 
> Here is the kgdb stub's "send a byte" function:
> 
> static void
> write_char(int chr)
> {
>        while (!(inb(gdb_port + UART_LSR) & UART_LSR_THRE)) ;
> 
>        outb(chr, gdb_port + UART_TX);
> }
> 
> Need I say more?


netdump has polled eepro100 handlers that will plug nicely into this. Of
course you still want a protocol on top of it, but there are some tiny
tcp implementations that are GPL (eg the Linux 8086 TCP by Harry K)

