Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWAFLrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWAFLrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWAFLrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:47:03 -0500
Received: from mout1.freenet.de ([194.97.50.132]:13206 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751493AbWAFLq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:46:58 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
Date: Fri, 6 Jan 2006 12:45:55 +0100
User-Agent: KMail/1.8.3
References: <1136541243.4037.18.camel@localhost> <200601061200.59376.mbuesch@freenet.de> <1136547494.7429.72.camel@localhost>
In-Reply-To: <1136547494.7429.72.camel@localhost>
Cc: jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200601061245.55978.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart32478718.o1LFTskAdZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart32478718.o1LFTskAdZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 06 January 2006 12:38, you wrote:
> Hi Michael,
>=20
> > How would the virtual interfaces look like? That is quite easy to answe=
r.
> > They are net_devices, as they transfer data.
> > They should probaly _not_ be on top of the ethernet, as 80211 does not
> > have very much in common with ethernet. Basically they share the same
> > MAC address format. Does someone have another thing, which he thinks
> > is shared?
> > How would the master interface look like? A somewhat unusual idea came
> > up. Using a device node in /dev. So every wireless card in the system
> > would have a node in /dev associated (/dev/wlan0 for example).
> > A node for the master device would be ok, because no data is transferred
> > through it. It is only a configuration interface.
> > So you would tell the, yet-to-be-written userspace tool wconfig (or som=
ething
> > like that) "I need a STA in INFRA mode and want to drive it on the
> > wlan0 card". So wconfig goes and write()s some data to /dev/wlan0
> > telling the 80211 code to setup a virtual net_device for the driver
> > associated to /dev/wlan0.
> > The virtual interface is then configured though /dev/wlan0 using write()
> > (no ugly ioctl anymore, you see...). Config data like TX rate,
> > current essid,.... basically everything + xyz which is done by WE today,
> > is written to /dev/wlan0.
> > This config data is entirely cached in the 80211 code for the /dev/wlan0
> > instance. This is important, to have the data persistent throughout
> > suspend/resume cycles, if up/down cycles.
> > After configuring, a virtual net_device (let's call it wlan0) exists,
> > which can be brought up by ifconfig and data can be transferred though
> > it as usual.
>=20
> what is wrong with using netlink and/or sysfs for it? I don't see the
> advantage of defining another /dev something interface.

Nothing is wrong with that.
"brainstorming" was the most dominant word in the whole text. ;)
I just personally liked the idea of having a device node in /dev for
every existing hardware wlan card. Like we have device nodes for
other real hardware, too. It felt like a bit of a "unix way" to do
this to me. I don't say this is the way to go.
If a netlink socket is used (which is possible, for sure), we stay with
the old way of having no device node in /dev for networking devices.
That is ok. But that is really only an implementation detail (and for sure
a matter of taste).
The _real_ main point I wanted to make was to _not_ use a net_device for
the master device. What else should be used for master device, let it
be a device node or a netlink socket, is rather unimportant at
this stage.

=2D-=20
Greetings Michael.

--nextPart32478718.o1LFTskAdZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvlhzlb09HEdWDKgRAiUBAJ9FdlTBjq1J7UQmMI3NSlbMj5INmgCfX8DK
wXRKGjdJPCU1uJbx7jP6YPo=
=9mt/
-----END PGP SIGNATURE-----

--nextPart32478718.o1LFTskAdZ--
