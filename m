Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSKOWoX>; Fri, 15 Nov 2002 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSKOWoX>; Fri, 15 Nov 2002 17:44:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:1163 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266888AbSKOWoW>;
	Fri, 15 Nov 2002 17:44:22 -0500
Message-ID: <3DD57A5F.87119CB4@digeo.com>
Date: Fri, 15 Nov 2002 14:51:11 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 22:51:11.0568 (UTC) FILETIME=[7E6E0500:01C28CF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> 
> On Fri, Nov 15, 2002 at 09:26:00PM +0000, Linus Torvalds wrote:
> 
> > I dunno. I might even be willing to apply kgdb patches to my tree if it
> > just could use the regular network card I already have connected on all
> > my machines. None of my laptops have a serial line, for example, but
> > they all have networking.
> >
> > Soon even _desktops_ probably won't have serial lines any more, only USB.
> 
> Using USB instead of the serial line or the network card would be
> the best IMHO, because:
> 

Here is the kgdb stub's "send a byte" function:

static void
write_char(int chr)
{
       while (!(inb(gdb_port + UART_LSR) & UART_LSR_THRE)) ;

       outb(chr, gdb_port + UART_TX);
}

Need I say more?
