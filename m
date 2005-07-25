Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVGYKqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVGYKqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGYKqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:46:21 -0400
Received: from lugor.de ([212.112.242.222]:30421 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S261185AbVGYKqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:46:18 -0400
From: Christian Hesse <mail@earthworm.de>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [2.6.12.3] dyntick 050610-1 breaks makes S3 suspend
Date: Mon, 25 Jul 2005 12:46:02 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Jan De Luyck <lkml@kcore.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200507231435.05015.lkml@kcore.org> <200507231451.04630.mail@earthworm.de> <20050725102747.GH5837@atomide.com>
In-Reply-To: <20050725102747.GH5837@atomide.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2797575.SD178IPKMa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507251246.08045.mail@earthworm.de>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2797575.SD178IPKMa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 25 July 2005 12:27, Tony Lindgren wrote:
> * Christian Hesse <mail@earthworm.de> [050723 05:51]:
> > On Saturday 23 July 2005 14:35, Jan De Luyck wrote:
> > > Hello,
> > >
> > > I recently tried out dyntick 050610-1 against 2.6.12.3, works great, =
it
> > > actually makes a noticeable difference on my laptop's battery life. I
> > > don't have hard numbers, lets just say that instead of the usual ~3
> > > hours i get out of it, i was ~4 before it started nagging, usual use
> > > pattern at work.
> > >
> > > The only gripe I have with it that it stops S3 from working. If the
> > > patch is compiled in the kernel, it makes S3 suspend correctly, but
> > > resuming goes into a solid hang (nothing get's it back alive, have to
> > > keep the powerbutton for ~5 secs to shutdown the system)
> > >
> > > Anything I could test? The logs don't give anything useful..
> >
> > I reported this some time ago [1], but there's no sulution so far...
> >
> > [1] http://groups.google.com/groups?selm=3D4b4NI-7mJ-9%40gated-at.bofh.=
it
>
> In theory it should not happen... And it's working on my laptop for resume
> just fine with dyntick on. Can you try it without APIC support? Maybe
> that's the differerence again. (I don't have APIC on my laptop)

root@logo:~# zcat /proc/config.gz | grep APIC
CONFIG_X86_GOOD_APIC=3Dy
# CONFIG_X86_UP_APIC is not set

Only the second one can be changed in make (menu)config. So I think this is=
=20
what you have?

> Also a workaround is to disable dyntick before suspend with:
>
> # echo 0 > /sys/devices/system/timer/timer0/dyn_tick_state
>
> and then enable it again after resume.

IIRC, this didn't work, system hangs at resume as well. Will try again if=20
you've released an updated version.

=2D-=20
Christian

--nextPart2797575.SD178IPKMa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBC5MLwlZfG2c8gdSURAmn+AJ487ffSM9Sp59MrVjg7j5+WgLcKBgCgqLJL
sI/R1bAZj228Sm1URraVR44=
=kEcx
-----END PGP SIGNATURE-----

--nextPart2797575.SD178IPKMa--
