Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWAaLWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWAaLWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 06:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWAaLWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 06:22:30 -0500
Received: from mail.gmx.net ([213.165.64.21]:47294 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750745AbWAaLW3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 06:22:29 -0500
X-Authenticated: #428038
Date: Tue, 31 Jan 2006 12:22:23 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: psusi@cfl.rr.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060131112223.GA23149@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	psusi@cfl.rr.com, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <43DE495A.nail2BR211K0O@burner> <43DE75F5.40900@cfl.rr.com> <43DF403F.nail2RF310RP6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <43DF403F.nail2RF310RP6@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-31:

> > It certainly does return something useful, just not what you are looking 
> > for.  It does not return information that allows you to cleanly build 
> > your bus:device:lun view of the world, but it does return sufficient 
> > information to enumerate and communicate with all devices in the 
> > system.  Is that not sufficient to be able to implement cdrecord?  If it 
> > is, then the real issue here is that you want Linux to conform to the 
> > bus:device:lun world view, which it seems many people do not wish to do. 
> 
> It does not allow libscg to find all devices.

On my system,

sudo cdrecord -scanbus ; \
sudo cdrecord -scanbus dev=ATA:

finds all devices that talk ATAPI, SCSI, MMC.

> > Maybe it would be more constructive if you were to make a good argument 
> > for why the bus:device:lun view is better than /dev/*, but right now it 
> > seems to me that they are just two different ways of doing the same 
> > thing, and you prefer one way while the rest of the Linux developers 
> > prefer the other. 
> 
> It would help if someone would give arguments why Linux does treat all 
> SCSI devices equal, except for ATAPI transport based ones.

1a The question is rather, what is the reason that you claim libscg is
allegedly unable to find all devices?

  1b Not scanning all of the devices perhaps?

  1c Not asking the right enumeration interface perhaps?

2 And what devices are actually missing?
Name tangible devices or groups, not phantoms that no-one uses.

3 Why does libscg need to care at all which kernel driver provides SG_IO?
The device node give access to the target the user desires. Add serial
number listing to -scanbus to make those happy that have several drives
of the same brand and model.

4 Why have you not yet responded to the suggestion to use freedesktop.org
HAL to enumerate devices?

Summarizing past discussions, it appears as though you have not
presented sufficiently substantiated arguments to prove libscg is
actually missing out on device, and not sufficient evidence to convince
kernel developers to CHANGE things.

The same way as you want them to justify their using device nodes
instead bus:id:lun to map everything into a narrow namespace, they can
make you justify your request. Fact is that cdrecord+libscg appear to
work well enough so that nobody wants to care about theoretical gaps
that have no practical impact.

And given that libscg's namespace is already transport:bus:id:lun which
comprises /dev/hd* and /dev/sg* so nicely that CD writing works today,
it seems hard to justify changes beyond 1. removing irritating warnings
from cdrecord/libscg, 2. making libscg actually scan all transports and
not just one when looking for devices.

It is pretty clear now that the Linux kernel developers do not care if
your application bitches at users because you don't like a particular
interface.

-- 
Matthias Andree
