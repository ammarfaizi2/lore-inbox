Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbRESJFM>; Sat, 19 May 2001 05:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbRESJFD>; Sat, 19 May 2001 05:05:03 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:34316 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261715AbRESJEp>; Sat, 19 May 2001 05:04:45 -0400
Date: 19 May 2001 10:42:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <81BywVLHw-B@khms.westfalen.de>
In-Reply-To: <p05100301b72a335d4b61@[10.128.7.49]>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <811opRpHw-B@khms.westfalen.de> <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com> <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de> <p05100301b72a335d4b61@[10.128.7.49]>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlundell@pobox.com (Jonathan Lundell)  wrote on 17.05.01 in <p05100301b72a335d4b61@[10.128.7.49]>:

> At 11:23 PM +0200 2001-05-17, Kai Henningsen wrote:
> >jlundell@pobox.com (Jonathan Lundell)  wrote on 15.05.01 in
> ><p05100316b7272cdfd50c@[207.213.214.37]>:
> >
> >>  What about:
> >>
> >>  1 (network domain). I have two network interfaces that I connect to
> >>  two different network segments, eth0 & eth1; they're ifconfig'd to
> >>  the appropriate IP and MAC addresses. I really do need to know
> >>  physically which (physical) hole to plug my eth0 cable into.
> >
> >Sorry, the software doesn't know that. Never has, for that matter.
>
> Well, no, it doesn't. That's a problem.

Maybe, but it's not a problem you can solve from the kernel.

> Jeff Garzik's ethtool
> extension at least tells me the PCI bus/dev/fcn, though, and from
> that I can write a userland mapping function to the physical
> location.

I don't see how PCI bus/dev/fcn lets you do that.

> My point, though, is that finding the socket is a real-life
> problem on systems with multiple interfaces. I don't expect the
> kernel to know the physical locations, but the user has to be able to
> get from kernel/ifconfig names (eth#) to sockets, one way or another.

Local documentation is just about the only way to do it.

And one way that'd work fairly well with at least PC network cards is  
putting a sticker with the MAC address on them where you can see it while  
looking for the right place to put your plug.

Not the only way, either.

> Support for a uniform means of doing the mapping, even if it needs
> userland help, would be good.

It doesn't need userland *or* kernel help.

> >  > (Extension: same situation, but it's a firewall and I've got 12 ports
> >>  to connect.) (Extension #2: if I add a NIC to the system and reboot,
> >>  I'd really prefer that the NICs already in use didn't get renumbered.)
> >
> >Make your config script look at the hardware MAC addresses. Those don't
> >change.
>
> They're not necessarily unique, though.

So if you plug both into the same network segment, that segment is broken?  
That looks like very stupid design to me.

It's not as if getting enough unique MAC addresses was particularly  
expensive. These days, even el-cheapo PC network cards get that right.  
(And have for quite a number of years.)

> >  > 2 (disk domain). I have multiple spindles on multiple SCSI adapters.
> >>  I want to allocate them to more than one RAID0/1/5 set, with the
> >>  usual considerations of putting mirrors on different adapters,
> >>  spreading my RAID5 drives optimally, ditto stripes. I need (eg) SCSI
> >>  paths to config all this, and I further need real physical locations
> >>  to identify failed drives that need to be hot-replaced. The mirror
> >>  members will move around as drives are replaced and hot spares come
> >>  into play.
> >
> >Use partition UUIDs, or SCSI serial numbers, or whatever. This works
> >today.
>
> This pushes the problem back in time: I need to write the UUID, for

But not the SCSI serial number.

> example, at some point. And, with hot-swappable drives, I'm still
> interested in the physical location. I really know know that there's
> a good answer to this problem, especially with FC, but I need to tell
> an operator, "replace this particular physical drive". It doesn't do
> any good to tell the operator the UUID.

Well, if it's a small system, any enumeration plus id-page query will let  
you identify *a* name for the device. There's no need for that name to be  
stable. (The only stable names you need are for mount and friends, and  
those can easily use UUIDs.)

In a big system, where presumably you use lots of similar drives, those  
better have some sort of serial number (which you can, of course, get at  
the same way as above). In that case, part of the preparation of a hot  
swap drive would be to put the serial number on a sticker on the drive (or  
put some other id there and note the correspondence in some database).

And, of course, your software can note which UUID goes with which serial  
number.

If your drives have *no* serial number, you can try a software one ... or  
follow the old advice: don't do that, then. Don't use unidentifiable  
drives in many-similar-drive production systems.

> >  > Seems like more that merely informational.
> >
> >The *location*? Nope. Some unique id for the device, if available at all:
> >sure.
>
> What good does it do to tell an operator to connect a cable to a MAC
> address? Or to remove a drive having a particular UUID? If it's "mere
> information", it's *necessary* mere information.

See above for how that works. As in, actually works in practice. As in, I  
really shouldn't have to explain this.

MfG Kai
