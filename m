Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVKDXWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVKDXWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVKDXWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:22:48 -0500
Received: from mail01.solnet.ch ([212.101.4.135]:53266 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S1751060AbVKDXWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:22:47 -0500
From: Damir Perisa <damir.perisa@solnet.ch>
To: Greg KH <greg@kroah.com>
Subject: ide-cs broken / udev magic
Date: Sat, 5 Nov 2005 00:22:36 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Archlinux Developers <arch-dev@archlinux.org>
References: <20051103220305.77620d8f.akpm@osdl.org> <20051104071932.GA6362@kroah.com>
In-Reply-To: <20051104071932.GA6362@kroah.com>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2746583.Ps3nqrbJWt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511050022.41472.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2746583.Ps3nqrbJWt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Friday 04 November 2005 08:19, Greg KH a =E9crit=A0:
 | <apologies for the broken threading>

no problem

@Judd + Tobias: this is a ide-cs trouble thing that exists in arch with=20
default udev rules as of 071-1

 | > [17194333.620000] cs: memory probe 0xf0000000-0xf80fffff: excluding
 | > 0xf0000000-0xf87fffff
 | > [17194333.644000] pcmcia: Detected deprecated PCMCIA ioctl usage.
 | > [17194333.644000] pcmcia: This interface will soon be removed from
 | > the kernel; please expect breakage unless you upgrade to new tools.
 | > [17194333.644000] pcmcia: see
 | > http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
 | > details.
 | > [17194334.032000] Probing IDE interface ide2...
 | > [17194334.320000] hde: 1024MB Flash Card, CFA DISK drive
 | > [17194334.992000] ide2 at 0x4100-0x4107,0x410e on irq 3
 | > [17194334.992000] hde: max request size: 128KiB
 | > [17194334.992000] hde: 2001888 sectors (1024 MB) w/1KiB Cache,
 | > CHS=3D1986/16/63
 | > [17194334.992000] hde: cache flushes not supported
 | > [17194334.992000]  hde: hde1
 | > [17194335.004000] ide-cs: hde: Vcc =3D 3.3, Vpp =3D 0.0
 | > [17194335.224000]  hde: hde1
 | > [17194335.632000]  hde: hde1
 | > [17194335.736000]  hde: hde1
 | > [17194335.744000]  hde: hde1
 | > ... ("hde: hde1" repeating)...
 | >
 | > ok, now the situation is less lethal, but still no proper ide-cs
 | > working. there are no unknown symbols now, but the other output in
 | > dmesg is the same. especially, the loop to output "hde: hde1" is
 | > here, but if i remove the card, it stops and the system is still
 | > responsible.
 | >
 | > /sys/block/hde/hde1/
 | > presents itself fully normal like other ide drives. in
 | > /sys/block/hde/hde1/sample.sh
 | > i found "mknod /dev/hde1 b 33 1" and tried to run it. successfully!
 | > the result is: in dmesg, the "hde: hde1" output loop stopped and my
 | > card is working again!!!
 |
 | Heh, the poor-man's udev worked for someone :)

:D ... true, sometimes one has to do things manually to have it done.

 | The problem is in your udev rules. You are running something in them=20
 | that is opening up your ide-cs device, which causes another hotplug
 | event to happen, which causes udev to run again, and so on.

thanx for the explaination. i'm using archlinux and it seems that i'm the=20
only one who uses ide-cs and therefore ran into this trouble. i just=20
added

BUS=3D=3D"ide", SYSFS{removable}=3D"1", GOTO=3D"no_volume_id"
BUS=3D=3D"ide", SYSFS{../removable}=3D"1", GOTO=3D"no_volume_id"

to /etc/udev/rules.d/udev.rules

as other distros use to ignore removable ide's. now i need to load the=20
ide-cs module by hand (bad thing, as module should be loaded=20
automagically with udev/hotplug) but on the other hand, no more=20
dmesg-spamming, no freezes and also the node is created successfully=20
after module is loaded.=20

is there some other rules that may be usefull adding in this case?=20

is there planed action to change ide-cs to work without making it being=20
ignored ... without this exception that needs to be specified in udev=20
rules?=20

thank you for the analysis and the workaround that i'm now using to have=20
ide-cs working again. making it behave like any other ide would be cool,=20
but is only aesthetical for me, as things work now :)

greetings,
Damir

=2D-=20
Build a system that even a fool can use and only a fool will want to use=20
it.

--nextPart2746583.Ps3nqrbJWt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDa+1BPABWKV6NProRAicgAJ418r3wST3PiLhEvFxR0Jnd9GTmswCgoTo3
95bJRjf2aJNnqj09zZFvv6s=
=9CET
-----END PGP SIGNATURE-----

--nextPart2746583.Ps3nqrbJWt--
