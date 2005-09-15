Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbVIOVRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbVIOVRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVIOVRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:17:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:38105 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030508AbVIOVRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:17:04 -0400
Date: Thu, 15 Sep 2005 23:16:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Message-ID: <20050915211659.GB4625@midnight.suse.cz>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.931769000.dtor_core@ameritech.net> <1126770894.28510.10.camel@station6.example.com> <d120d50005091507225659868e@mail.gmail.com> <1126795310.3505.47.camel@station6.example.com> <20050915190700.GA3354@midnight.suse.cz> <d120d50005091512226a339890@mail.gmail.com> <20050915202553.GA3977@midnight.suse.cz> <d120d50005091513552688cd75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005091513552688cd75@mail.gmail.com>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 03:55:23PM -0500, Dmitry Torokhov wrote:
> On 9/15/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Thu, Sep 15, 2005 at 02:22:34PM -0500, Dmitry Torokhov wrote:
> > > They are devices - class devices :). I have the following distinction
> > > in my head - "normal" devices (bus devices) are real hardware devices
> > > and their drivers need to do resource and/or power management. Class
> > > devices represent virtual devices - some kind of abstraction - that
> > > unify and combine "real" devices from several buses into one class.
> > 
> > Yes. While input drivers do need to care about power management usually,
> > the input device abstraction itself doesn't have to, which makes it
> > indeed a special kind of a device.
> > 
> 
> Right. They just signal to underlying hardware driver when they are in
> use (open), but the actual power management is left to the specific
> bus/driver, not input core.
> 
> > I was always wondering whether the distinction between bus/class was
> > needed, as the border isn't very clear.
> > 
> 
> Classes combine devices which are logically the same, i.e. they
> perform similar functions. Buses combine devices that are perform
> different functions but have similar hardware interface. For example a
> network cards - it is a class. You can have network card sit on a PCI,
> USB, ISA buses but for the rest of the kernel they are accesses
> through netdev abstraction. At least this is my understanding of our
> device model ;)
 
Especially with things like Ethernet - there is not much difference
between it and other busses like SCSI. Both the Ethernet card and the
SCSI card give access to a bus behind them, they're in fact just
bridges.

You can have a harddrive sitting on both SCSI and Ethernet (iSCSI), and
there even is an IP-over-SCSI patch somewhere that allows connecting two
machines with a SCSI cable.

Similarly, you can have USB on PCI and on ISA. There will be two
different USB controllers in different places in the bus hierarchy. Yet
they can be accessed through the same means, something that would make
them a class.

[I'm playing a bit of a devil's advocate here - I see what the
distinction is trying to achieve.]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
