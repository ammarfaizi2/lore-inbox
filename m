Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264819AbSJ3TQo>; Wed, 30 Oct 2002 14:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264817AbSJ3TQn>; Wed, 30 Oct 2002 14:16:43 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24963 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264822AbSJ3TQk>; Wed, 30 Oct 2002 14:16:40 -0500
Subject: Re: prevent swsusp from eating disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021030154836.14201@192.168.4.1>
References: <1035991224.5141.70.camel@irongate.swansea.linux.org.uk> 
	<20021030154836.14201@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 19:42:36 +0000
Message-Id: <1036006956.5141.117.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 15:48, Benjamin Herrenschmidt wrote:
> The way it should be done is as follow (propagation of suspend/resume):
> 
> arch->pci_bus->...->pci_driver->ide_subdriver
                                             ----> disk


> The details as I see them (and that would match my needs on ppc) are
> that the suspend request originates from the bus binding of the
> controller, as any other device. (non PCI hosts will need specific
> arch tweaks here or whatever parent bus they have in the news model
> will deal with sending them the suspend call).

We have the hwif structures (ugly I know) which know what the interface
is nailed to and what is nailed to each device so it isnt that bad.
There are the odd complications of course - chips that appear as two PCI
devices and either one of them turns off both for example 8)


> Another is that I feel (and I know Pavel doesn't agree here) that
> the disk driver should also block further incoming requests (that
> is leave them in the queue) instead of panic'ing. That is the
> driver should not rely on not beeing fed any more request, but
> rather make sure it will leave them in the queue and deal with
> them when resumed.

It is cleaner if the ordering of power off is right. If the model is
right then the first suspend would be the drives. Part of drive suspend
ought to be corking the queue.

Alan

