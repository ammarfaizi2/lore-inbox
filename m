Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSKOVkD>; Fri, 15 Nov 2002 16:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSKOVkD>; Fri, 15 Nov 2002 16:40:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:12936 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266805AbSKOVkC>;
	Fri, 15 Nov 2002 16:40:02 -0500
Message-ID: <3DD56B4C.B96183C9@digeo.com>
Date: Fri, 15 Nov 2002 13:46:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, akale@users.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 21:46:52.0128 (UTC) FILETIME=[82063600:01C28CF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <334960000.1037397999@flay>,
> Martin J. Bligh <mbligh@aracnet.com> wrote:
> >> Is there a source level remote kernel debugger that
> >> communicates over an ethernet interface? The debugger
> >> kgdb from kgdb.sourceforge.net works only with serial port.
> >
> >A cheap terminal server might work ...
> 
> Well, apart from the fact that a lot of machines don't even _have_
> serial ports..
> 
> I dunno. I might even be willing to apply kgdb patches to my tree if it
> just could use the regular network card I already have connected on all
> my machines. None of my laptops have a serial line, for example, but
> they all have networking.
> 
> Soon even _desktops_ probably won't have serial lines any more, only USB.
> 

The only real work which has ever been done on this was by San
Mehat earlier this year.  When he had the advantage of sharing
an office with me and being repeatedly harangued to do it ;)

He did have it working - it was basically the same idea as Ingo's
netconsole code, using a little polling stub in each driver.  He
extended the concept to support Rx as well as Tx.  You provide
a whole bunch of parameters to the kernel and to the debugger, right
down to the MAC address.

But San became quite unwell some months ago and vanished.  As far as
I know, the code is lost.

He may have sent a copy to Amit?

But as far as integrating the stub goes: IMO it would need quite
some cleanup work first.  Great tool, but the implementation is
quite straggly.

An ethernet version could never be as robust as something which
spins on a uart port though.  Anyone who seriously wants to use the
facility would just need to get themselves a 16550.
