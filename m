Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbRFKQFf>; Mon, 11 Jun 2001 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRFKQFY>; Mon, 11 Jun 2001 12:05:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31719 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261296AbRFKQFR>;
	Mon, 11 Jun 2001 12:05:17 -0400
Message-ID: <3B24EC2F.175B088A@mandrakesoft.com>
Date: Mon, 11 Jun 2001 12:05:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
				<20010610093838.A13074@flint.arm.linux.org.uk>
				<Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
				<20010610173419.B13164@flint.arm.linux.org.uk>
				<15140.5762.589629.252904@pizda.ninka.net>
				<3B24C185.824EBBE0@uow.edu.au> <15140.51018.942446.320621@pizda.ninka.net> <3B24CC80.D880510@mandrakesoft.com> <3B24D3F0.F2B6DA76@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jeff Garzik wrote:
> >
> > "David S. Miller" wrote:
> > >
> > > Andrew Morton writes:
> > >  > It'd need to be callable from interrupt context - otherwise
> > >  > each device/driver which has link status change interrupts
> > >  > will need to implement some form of interrupt->process context
> > >  > trick.
> > >
> > > Well, we could make the netif_carrier_*() implementation do the
> > > "interrupt->process context" trick.
> > >
> > > Jamal can feel free to post what he has.
> >
> > If we have any problems with context we can always use schedule_task()
> 
> Yep.  With dev_hold() and dev_put() to avoid module removal
> races.  One would also have to be sure that the right things
> happen if the interface is downed between the interrupt and
> execution of the schedule_task() callback.

Why not call MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT?  It makes it much
more obvious you are closing a race related to modules, and it goes away
when the module is built into the kernel.

(as a tangent, I have run into cases where it would be nice to always
have a module ref count, whether or not you were built into the kernel. 
this would be ok with me...)


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
