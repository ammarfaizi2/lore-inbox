Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbRFKO3O>; Mon, 11 Jun 2001 10:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263396AbRFKO3D>; Mon, 11 Jun 2001 10:29:03 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:33746 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263372AbRFKO25>; Mon, 11 Jun 2001 10:28:57 -0400
Message-ID: <3B24D3F0.F2B6DA76@uow.edu.au>
Date: Tue, 12 Jun 2001 00:21:36 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
			<20010610093838.A13074@flint.arm.linux.org.uk>
			<Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
			<20010610173419.B13164@flint.arm.linux.org.uk>
			<15140.5762.589629.252904@pizda.ninka.net>
			<3B24C185.824EBBE0@uow.edu.au> <15140.51018.942446.320621@pizda.ninka.net> <3B24CC80.D880510@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> "David S. Miller" wrote:
> >
> > Andrew Morton writes:
> >  > It'd need to be callable from interrupt context - otherwise
> >  > each device/driver which has link status change interrupts
> >  > will need to implement some form of interrupt->process context
> >  > trick.
> >
> > Well, we could make the netif_carrier_*() implementation do the
> > "interrupt->process context" trick.
> >
> > Jamal can feel free to post what he has.
> 
> If we have any problems with context we can always use schedule_task()

Yep.  With dev_hold() and dev_put() to avoid module removal
races.  One would also have to be sure that the right things
happen if the interface is downed between the interrupt and
execution of the schedule_task() callback.
