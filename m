Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293011AbSBVVuK>; Fri, 22 Feb 2002 16:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293013AbSBVVt7>; Fri, 22 Feb 2002 16:49:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:31755 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293011AbSBVVtp>; Fri, 22 Feb 2002 16:49:45 -0500
Date: Fri, 22 Feb 2002 22:47:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, G?rard Roudier <groudier@free.fr>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222224708.D7238@suse.cz>
In-Reply-To: <3C76A4D8.A7838605@mandrakesoft.com> <Pine.LNX.4.10.10202221210430.2519-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202221210430.2519-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Fri, Feb 22, 2002 at 12:19:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:19:52PM -0800, Andre Hedrick wrote:
> On Fri, 22 Feb 2002, Jeff Garzik wrote:
> 
> > Andre Hedrick wrote:
> > > Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
> > > stable for a while.
> > 
> > Stable?  Yes.  But it's not modular nor compatible with current efforts
> > like 2.4 cardbus or 2.4 hotplug pci or 2.5 device mode.  If one cannot
> > do
> > 	modprobe piix4_ide
> > and have the right things happen automatically, the system is not
> > modular.  If it doesn't use the PCI API, it's implementing CardBus
> > support in a non-standard way if at all.
> 
> Now what happens if you have more than one HOST of the same kind or the
> "SAME HOST" with multiple functions but are really one HOST?

Nothing extra. Same as happens when you 'modprobe usb-uhci' or 'modprobe
tulip'. All the PCI devices of the type supported by the module are
found, initialized and registered with the ide/usb/network core.

> I do not see how this will handle the problem.
> But obviously I have been to far down making sure the DATA got to platter
> correct and most likely missed a few things. :-/

Yes, it seems so.

> > > > This is need for transparented support for cardbus and hotplug PCI, not
> > > This is HOST level operation not DEVICE, and you do not see the differenc.
> > I do.  I am talking about a HOST api here.
> 
> Okay we are getting some place now, cause what I was reading and seeing in
> the changes registers a DRIVE to the PCI API and not a HOST.

A drive can't register to a PCI API. A drive isn't a PCI device. That's
quite clear, ain't it?

> > Why not work with Patrick to make sure his device model properly
> > supports disks?
> 
> I thought there were a few conversations to address this point.
> What everyone is maybe missing is PATA (parallel ata) does not permit
> "Disconnect/Release".

Uh? This is quite irrelevant - while it may not support hot(un)plugging,
it still supports power management. Hence the need for Patricks device
model support.

> Maybe I need to sit down w/ Patrick to figure out how to pound the model
> into my thick head.
> 
> Much of my unwillingness to move rapid is because the past has shown
> massive problem, and Linus has never permitted rapid design changes in the
> ata/atapi stack.  So much if this is a shock to the system.

Well, the changes happening now from the hands of Martin are definitely
not rapid at all. They're pretty incremental without any huge steps
which is what Linus dislikes. (And I must agree with him, merging huge
patches is not a nice work.)

-- 
Vojtech Pavlik
SuSE Labs
