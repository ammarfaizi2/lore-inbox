Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271050AbRHOFuO>; Wed, 15 Aug 2001 01:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271047AbRHOFuD>; Wed, 15 Aug 2001 01:50:03 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:28122 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S271048AbRHOFuA>; Wed, 15 Aug 2001 01:50:00 -0400
Subject: Re: [PATCH] CDP handler for linux
From: David Luyer <david_luyer@pacific.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Crowther <chrisc@shad0w.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E15WlHC-0001xF-00@the-village.bc.nu>
In-Reply-To: <E15WlHC-0001xF-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 15 Aug 2001 15:48:00 +1000
Message-Id: <997854480.3451.10.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 2001 21:59:02 +0100, Alan Cox wrote:
> > 	This said, if the consesus is that it belongs in userspace, I
> > shall set about porting the code over to a dameon and possibly maintaing
> > the kernel patch as a secondary "hobby project".
> 
> I really think user space is the right place for it. That keeps it in
> pageable memory and likely to dump a core not an entire box on errors.

You're right (of course), but to a small extent it may depend how
critical CDP is to your routing.  Both CDP and HSRP are things which
can be used by Ciscos to choose backup paths, but neither protocol is
really "urgent, real-time priority required" in the timing so that's
really the main reason to stay out of the kernel.

If you're using "set ip next-hop verify-availability" in a Cisco router
then you don't want CDP to fail unless the machine is unavailable to
route.  But then I guess we don't have OSPF or BGP in the kernel, so CDP
doesn't belong there either.

One thing which would be nice though from a performance perspective is
a kernel NetFlow collector.  I'm currently using a netflow collecter
which uses <asm/unistd.h> and doesn't link against libc or crt0.o,
accumulates all it's write()s as 128k chunks, etc, and that's damn fast,
but the kernel should be able to be even faster (avoid all those
context switches on each packet received).
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
