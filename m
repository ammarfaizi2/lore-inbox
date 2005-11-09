Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKIN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKIN7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVKIN7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:59:30 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:50344 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S1750768AbVKIN73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:59:29 -0500
Date: Wed, 9 Nov 2005 13:59:25 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Multiple USB DVB devices cause hard lockups
Message-ID: <20051109135925.GF12751@localhost.localdomain>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I'm trying to get a pair of Twinhan Alpha II DVB-USB devices
working on the same machine. With a single device plugged in, I can
quite easily receive and stream data.

   With both devices connected to the machine, both are recognised.
However, use of either device causes some form of stack backtrace (I
can't see the top of it to verify what kind) from the kernel, and a
hard lock-up. Magic SysRQ is non-functional after the lock-up. Failure
cases that I've seen are:

 - Streaming from device 0 is OK for a few seconds, and then the
   system locks hard.

 - Streaming from device 0 is OK. Streaming from device 1 before
   device 0 crashes locks the device 1 process in D state, and then
   locks the system hard a few seconds later.

   I've observed this behaviour on both 2.6.12.2 and 2.6.14. No logs
were left from the crashes, and only incomplete information on screen,
so I presume that I'll need to get a serial console set up to capture
output. A log of the devices being identified on boot-up is attached
below, for what it's worth (probably not much).

   Hugo.

Nov  9 11:49:48 src@vlad kernel: ehci_hcd 0000:00:0c.2: EHCI Host Controller
Nov  9 11:49:48 src@vlad kernel: ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
Nov  9 11:49:48 src@vlad kernel: ehci_hcd 0000:00:0c.2: irq 12, io mem 0xd4000000
Nov  9 11:49:48 src@vlad kernel: ehci_hcd 0000:00:0c.2: park 0
Nov  9 11:49:48 src@vlad kernel: ehci_hcd 0000:00:0c.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Nov  9 11:49:48 src@vlad kernel: hub 1-0:1.0: USB hub found
Nov  9 11:49:48 src@vlad kernel: hub 1-0:1.0: 5 ports detected
Nov  9 11:49:48 src@vlad kernel: usb 1-2: new high speed USB device using ehci_hcd and address 2
Nov  9 11:49:48 src@vlad kernel: usb 1-3: new high speed USB device using ehci_hcd and address 3
Nov  9 11:49:48 src@vlad kernel: dvb-usb: found a 'Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)' in warm state.
Nov  9 11:49:48 src@vlad kernel: dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
Nov  9 11:49:48 src@vlad kernel: DVB: registering new adapter (Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)).
Nov  9 11:49:48 src@vlad kernel: dvb-usb: MAC address: 08:ff:ff:ff:ff:ff
Nov  9 11:49:48 src@vlad kernel: DVB: registering frontend 0 (Twinhan VP7045/46 USB DVB-T)...
Nov  9 11:49:48 src@vlad kernel: dvb-usb: schedule remote query interval to 400 msecs.
Nov  9 11:49:48 src@vlad kernel: dvb-usb: Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II) successfully initialized and connected.
Nov  9 11:49:48 src@vlad kernel: dvb-usb: found a 'Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)' in warm state.
Nov  9 11:49:48 src@vlad kernel: dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
Nov  9 11:49:48 src@vlad kernel: DVB: registering new adapter (Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)).
Nov  9 11:49:48 src@vlad kernel: dvb-usb: MAC address: 08:ff:ff:ff:ff:ff
Nov  9 11:49:48 src@vlad kernel: DVB: registering frontend 1 (Twinhan VP7045/46 USB DVB-T)...
Nov  9 11:49:48 src@vlad kernel: dvb-usb: schedule remote query interval to 400 msecs.
Nov  9 11:49:48 src@vlad kernel: dvb-usb: Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II) successfully initialized and connected.
Nov  9 11:49:48 src@vlad kernel: usbcore: registered new driver dvb_usb_vp7045
Nov  9 11:49:48 src@vlad kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
     --- "Your problem is that you have a negative personality." ---     
                             "No,  I don't!"                             

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcgC9ssJ7whwzWGARAq/KAJ9OzODIZd3oexvXHluJIcxEjBJadACfSDWd
JhtsY6Ycn38PiJcZzDAUqfU=
=lGeV
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
