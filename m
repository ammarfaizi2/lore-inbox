Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268159AbTBSJ3J>; Wed, 19 Feb 2003 04:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268161AbTBSJ3I>; Wed, 19 Feb 2003 04:29:08 -0500
Received: from AMarseille-201-1-1-193.abo.wanadoo.fr ([193.252.38.193]:19751
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268159AbTBSJ3I>; Wed, 19 Feb 2003 04:29:08 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045619583.25795.11.camel@irongate.swansea.linux.org.uk>
References: <E18lC5R-00067P-00@the-village.bc.nu>
	 <20030218230910.A27653@flint.arm.linux.org.uk>
	 <1045619583.25795.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045647562.12533.1.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 10:39:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 02:53, Alan Cox wrote:
> On Tue, 2003-02-18 at 23:09, Russell King wrote:
> > On Tue, Feb 18, 2003 at 06:03:21PM +0000, Alan Cox wrote:
> > > +static u8 ide_unplugged_inb (unsigned long port)
> > > +{
> > > +	return 0xFF;
> > > +}
> > 
> > Shouldn't this return 0x7f, ie bit 7 clear, as if we have an interface
> > without drive attached?
> 
> 0xFF is what most hardware returns for an unclaimed pci address. I'd rather
> make sure it also works when we don't get the event, or the device 
> summarily explodes than fake up something to make it look good. If
> 0xff doesnt work we have a bug anyway, lets find them.

Hrm... I tend to agree with Russell here... 0x7f is the "safe" value
for IDE. IDE controllers with nothing wired shall have a pull down
on D7. The reason is simple: busy loops in the IDE code waiting for
BSY to go down.

Now, if your point is to keep BSY up and have wait loops timeout,
then 0xff may actually make some sense ;)

Ben.
