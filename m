Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTH0RX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTH0RX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:23:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24960 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263685AbTH0RXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:23:10 -0400
Date: Wed, 27 Aug 2003 13:23:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: LGW <large@lilymarleen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: porting driver to 2.6, still unknown relocs... :(
In-Reply-To: <20030827100745.0d944f33.shemminger@osdl.org>
Message-ID: <Pine.LNX.4.53.0308271319350.2174@chaos>
References: <3F4CB452.2060207@lilymarleen.de> <20030827081312.7563d8f9.rddunlap@osdl.org>
 <3F4CCF85.1020502@lilymarleen.de> <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
 <20030827100745.0d944f33.shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Stephen Hemminger wrote:

> On 27 Aug 2003 16:59:38 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > On Mer, 2003-08-27 at 16:34, LGW wrote:
> > > The driver is mostly a wrapper around a generic driver released by the
> > > manufacturer, and that's written in C++. But it worked like this for the
> > > 2.4.x kernel series, so I think it has something todo with the new
> > > module loader code. Possibly ld misses something when linking the object
> > > specific stuff like constructors?
> >
> > The new module loader is kernel side, it may well not know some of the
> > C++ specific relocation types.
>
> You did something that was explicitly not supported on 2.4 and it worked,
> it broke on 2.6.
>
> The fact that it worked it all on 2.4 was a fluke.
>
> It's time to breakdown, do the right thing and figure out how to rewrite/translate the
> C++ code to C.
>

> You did something that was explicitly not supported on 2.4 and it worked,
                             ^^^^^^^^^^^^^^^^^^^^^^^^_______ Yes!

There was lots of discussion/flames back-and-forth with newbies
requiring that modules be written in C++.  This is what you get.
Some of the C++ built-ins are not even global so the linker
won't be able to find them if they are used. It's not just
a matter of emulating 'new'. Parameter-passing 'by reference' also
won't work so putting 'C' wrappers around stuff like they do
in Dr. Jobbs and C/C++ Journal isn't going to work inside
the kernel where there is no support.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


