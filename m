Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTALTrI>; Sun, 12 Jan 2003 14:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTALTrH>; Sun, 12 Jan 2003 14:47:07 -0500
Received: from AMarseille-201-1-1-174.abo.wanadoo.fr ([193.252.38.174]:49009
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267437AbTALTrE>; Sun, 12 Jan 2003 14:47:04 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042401074.525.219.camel@zion.wanadoo.fr>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042401443.525.223.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Jan 2003 20:57:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 20:51, Benjamin Herrenschmidt wrote:
> On Sun, 2003-01-12 at 21:27, Alan Cox wrote:
> 
> > which currently has two problems Ross found
> > 
> > 1.  The processors or so fast we have to enforce the 400nS delay nowdays
> 
> What about PCI write posting ? How can we enforce the 400ns delay here ?
> I suspect we can't read back from the taskfile registers after writing
> the command. Especially when using DMA, I think I remember Andre telling
> me even tapping alt status might not be safe... So we need to issue
> a read from the same bus path, but not on any taskfile register from
> this channel... hrm... any idea ?

Actually, do we really need that delay as we are waiting for an
interrupt anyway ? my understanding is that this delay is the required
before we start polling for BSY bit (that is the max time the drive may
take to assert BSY after getting the command), but in our case, unless
we have other bugs, we shall have the channel marked busy, so nobody
will tap it, except the actual interrupt coming in. Or will the case of
shared interrupt potentially cause a read of status at the wrong time ?

Ben.


