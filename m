Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266306AbUHMVwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUHMVwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUHMVwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:52:32 -0400
Received: from maximus.kcore.de ([213.133.102.235]:49458 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S266306AbUHMVwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:52:16 -0400
From: Oliver Feiler <kiza@gmx.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: eth*: transmit timed out since .27 (was: linux-2.4.27 released)
Date: Fri, 13 Aug 2004 23:56:25 +0200
User-Agent: KMail/1.5
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
References: <200408072328.i77NSRNi031514@hera.kernel.org> <200408101423.42402.kiza@gmx.net> <20040813101525.GD24479@logos.cnet>
In-Reply-To: <20040813101525.GD24479@logos.cnet>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_PkTHBjawfickeFe";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408132356.31778.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_PkTHBjawfickeFe
Content-Type: multipart/mixed;
  boundary="Boundary-01=_JkTHBXpvesns1hg"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_JkTHBXpvesns1hg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi Marcelo,

On Friday 13 August 2004 12:15, Marcelo Tosatti wrote:

> On Tue, Aug 10, 2004 at 02:23:34PM +0200, Oliver Feiler wrote:
> > Hi,
> >
> > I've upgraded a server from .26 to .27, but ran into problems with the
> > network cards.
> >
> > The kernel throws a lot of errors into the syslog and the net devices
> > don't work:
> > Aug 10 13:39:25 spot kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Aug 10 13:39:26 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
> > Aug 10 13:39:26 spot kernel: eth1: Transmit timeout, status 00000004
> > 00000249 Aug 10 13:39:34 spot kernel: NETDEV WATCHDOG: eth1: transmit
> > timed out Aug 10 13:39:34 spot kernel: eth1: Transmit timeout, status
> > 00000004 00000241 Aug 10 13:39:42 spot kernel: NETDEV WATCHDOG: eth1:
> > transmit timed out Aug 10 13:39:42 spot kernel: eth1: Transmit timeout,
> > status 00000004 00000240 [...]
> >
> > and:
> > Aug 10 13:39:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D=
0x3,
> > ISR=3D0x3, t=3D515.
> > Aug 10 13:40:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D=
0x3,
> > ISR=3D0x3, t=3D5015.
> > Aug 10 13:40:40 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D=
0x3,
> > ISR=3D0x3, t=3D1014.
> > [...]
> >
> > The system has three network cards.
> > eth0: SIS900 (sis900.c)
> > eth1: RTL-8029 (ne2k-pci.c)
> > eth2: onboard VIA VT6102 Rhine-II (via-rhine.c)
> >
> > eth0 and eth1 share the same interrupt
> >
> >            CPU0
> >   0:      91986          XT-PIC  timer
> >   1:        935          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   8:          1          XT-PIC  rtc
> >   9:          0          XT-PIC  acpi
> >  10:      25109          XT-PIC  via82cxxx, usb-uhci, usb-uhci, eth0,
> > eth1 11:         24          XT-PIC  usb-uhci, eth2
> >  14:       7523          XT-PIC  ide0
> >  15:       7021          XT-PIC  ide1
> > NMI:          0
> > ERR:          0
>
> Wow, you have four devices on the same interrupt line. /proc/interrupts
> from 2.4.26/27 looks the same?

There are five on int10. ;) It's worse on my desktop box with six devices o=
n=20
int11. But hey, Linux works just fine so I never cared.

Yes, /proc/interrupts from .26 and .27 is the same.

> > Either way .27 doesn't want to boot. I've attached dmesg from a running
> > 2.4.26 kernel and the config used for 2.4.27.
>
> You mean it boots but you get the Tx timeouts?

Yes.


> Well there are some changes to sis900 between .26 and .27 but I doubt
> they could be causing it.
>
> Can you try to boot with ACPI disabled? I think the problem might be
> related to ACPI configuration.
>
> Also, can you post the boot messages from 2.4.27?

I've attached three boots with .27. One without any parameters, one with=20
acpi=3Doff and pci=3Dnoacpi (the way I booted previous kernels).

It seems I've found the problem. The network errors were caused by the=20
pci=3Dnoacpi boot parameter. Once I boot without any parameter or acpi=3Dof=
f it=20
works just fine.

Btw, how can I boot with ACPI disabled? I thought it was acpi=3Doff, but it=
=20
doesn't seem to make any difference, the kernel still uses ACPI (see=20
dmesg-2.4.27-acpi=3Doff.gz attachement).

Also there must have been some (positive) changes to ACPI in 2.4.27? With=20
earlier kernels I had this problem:

=46eb 6 18:31:27 spot kernel: PCI: Using ACPI for IRQ routing
=46eb 6 18:31:27 spot kernel: PCI: if you experience problems, try using op=
tion=20
'pci=3Dnoacpi' or even 'acpi=3Doff'
[...]
=46eb 6 18:31:27 spot kernel: PCI: No IRQ known for interrupt pin A of devi=
ce=20
00:11.1 - using IRQ 255

This seems to have been corrected as of 2.4.27. I still get the
PCI: No IRQ known for interrupt pin A of device 00:11.1
warning, but it doesn't assign IRQ 255 anymore which I take as a good sign.=
 :)

So, it seems to work fine now. If you still want me to test something=20
regarding ACPI on this mainboard feel free to ask.

Thanks for your help,

Oliver

=2D-=20
Oliver Feiler  -  http://kiza.kcore.de/

--Boundary-01=_JkTHBXpvesns1hg
Content-Type: application/x-gzip;
  name="dmesg-2.4.27-acpi.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg-2.4.27-acpi.gz"

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

--Boundary-01=_JkTHBXpvesns1hg
Content-Type: application/x-gzip;
  name="dmesg-2.4.27-acpi=off.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg-2.4.27-acpi=off.gz"

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

--Boundary-01=_JkTHBXpvesns1hg
Content-Type: application/x-gzip;
  name="dmesg-2.4.27-pci=noacpi.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg-2.4.27-pci=noacpi.gz"

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
32n/D6PMTP4XKgAA

--Boundary-01=_JkTHBXpvesns1hg--

--Boundary-03=_PkTHBjawfickeFe
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBBHTkPOpifZVYdT9IRAn+sAJ9gi4JmnjZt7PThOT3EsAYiK0rPmQCgkJF8
33cvUNSWmZo116rwu+b0Acw=
=XVJh
-----END PGP SIGNATURE-----

--Boundary-03=_PkTHBjawfickeFe--

