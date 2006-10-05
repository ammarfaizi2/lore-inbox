Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWJEVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWJEVJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWJEVJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:09:11 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:45249 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932197AbWJEVJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:09:09 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: "Fatih =?utf-8?q?A=C5=9F=C4=B1c=C4=B1?=" <asici.f@gmail.com>
Subject: Re: 2.6.19-rc1: forcedeth, nobody cared
Date: Thu, 5 Oct 2006 23:08:57 +0200
User-Agent: KMail/1.9.4
Cc: mingo@redhat.com, manfred@colorfullife.com,
       "Linux List" <linux-kernel@vger.kernel.org>
References: <200610050938.10997.prakash@punnoor.de> <5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
In-Reply-To: <5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1717542.gPIN8GQ4uE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610052309.01155.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1717542.gPIN8GQ4uE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A=C5=9F=C4=B1c=C4=B1:
> 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > Hi,
> >
> > subjects say it all. Without irqpoll my nic doesn't work anymore. I add=
ed
> > Ingo
> > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > the
> > like.

> > Can you try booting with pci=3Dnomsi ? I have a similar problem with my

I used snd-hda-intel.disable_msi=3D1 and this actually helped! Now the nfor=
ce=20
nic works w/o problems. So it was the audio driver causing havoc on the nic=
=2E=20
But (I noticed this with the kernel booted with irqpoll, as well) IRQ=20
balancing seems not to work anymore:

           CPU0       CPU1
  0:      53826          0   IO-APIC-edge     timer
  1:         66          0   IO-APIC-edge     i8042
  7:          0          0   IO-APIC-edge     parport0
  8:          0          0   IO-APIC-edge     rtc
  9:          0          0   IO-APIC-fasteoi  acpi
 12:       1650          0   IO-APIC-edge     i8042
 14:         63          0   IO-APIC-edge     ide0
 16:       2095          0   IO-APIC-fasteoi  nvidia
 19:          6          0   IO-APIC-fasteoi  ohci1394
 20:          0          0   IO-APIC-fasteoi  ohci_hcd:usb1
 21:         66          0   IO-APIC-fasteoi  ehci_hcd:usb2
 22:       5652          0   IO-APIC-fasteoi  libata
 23:       5105          0   IO-APIC-fasteoi  HDA Intel, eth0
NMI:        155         75
LOC:      53715      53649
ERR:          0


=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1717542.gPIN8GQ4uE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJXRtxU2n/+9+t5gRAv2DAKC9o/Bp5a6sFWfPoLFuzLqWHigjUwCg/pv5
/6pJ1ObwjqSZkRWe8iJKHes=
=HVXd
-----END PGP SIGNATURE-----

--nextPart1717542.gPIN8GQ4uE--
