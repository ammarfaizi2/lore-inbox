Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDIU3q>; Tue, 9 Apr 2002 16:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDIU3p>; Tue, 9 Apr 2002 16:29:45 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35850
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311424AbSDIU3o>; Tue, 9 Apr 2002 16:29:44 -0400
Date: Tue, 9 Apr 2002 13:27:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Roger Larsson <roger.larsson@norran.net>
cc: Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org,
        Mark Mielke <mark@mark.mielke.cc>
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is
 enabled
In-Reply-To: <200204092206.02376.roger.larsson@norran.net>
Message-ID: <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Roger Larsson wrote:

> On tisdagen den 9 april 2002 12.01, Anssi Saari wrote:
> > On Mon, Apr 08, 2002 at 06:02:55PM -0400, Mark Hahn wrote:
> > > I think someone else already pointed out that doing
> > > a kernel profile would be good.  strace would also
> > > be quite useful, even just the -c form.
> >
> > Here it is:
> >
> > With unmaskirq=1 first:
> >
> >
> >     49 handle_IRQ_event                           0.5104
> >    239 file_read_actor                            2.4896
> >   3324 default_idle                              69.2500
> >  20097 ide_output_data                          104.6719
> 
> Hey, what is this?
> 
> Comment of the function is:
> "This is used for most PIO data transfers *to* the IDE interface"
> (see /drivers/ide/ide.c:426)
> Has it reverted to PIO mode?

This is because there are not a proper and correct state diagram data
handler set for ATAPI, period.  Initially the driver evolved out of PIO
calls to the PACKET_COMMAND opcode for the ATA command set.  Since there
has been zero updates/attempts to create a proper ATAPI/ASPI by anyone,
you can expect PIO transactions.

Who knows once I finally have taskfile completed and the kernel fixed to
not violate the basics of hardware atomic for storage devices, I may fix
all of the atapi/aspi transport.  It is a real mess to grunt through all
the docs.  However, I suspect I could get some help (co-author a
standard's proposal) with the original author to outline and create a 500+
page techincal referrence guide.  So if there are any companies want to
fund such an adventure, please let me know off-line.

Understand that only in PIO can you be sure of how much data you could get
from a device, argh it still s a pig in a poke.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

