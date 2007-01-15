Return-Path: <linux-kernel-owner+w=401wt.eu-S932299AbXAOMn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbXAOMn3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbXAOMn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:43:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36174 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbXAOMn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:43:28 -0500
Date: Mon, 15 Jan 2007 13:43:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ntp.c : possible inconsistency?
In-Reply-To: <200701101629.44528.bernhard@schiffner-limbach.de>
Message-ID: <Pine.LNX.4.64.0701151338120.14457@scrub.home>
References: <200701101423.36740.bernhard@schiffner-limbach.de>
 <Pine.LNX.4.64.0701101516420.14458@scrub.home> <200701101629.44528.bernhard@schiffner-limbach.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-802229199-1168865006=:14457"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-802229199-1168865006=:14457
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 10 Jan 2007, Bernhard Schiffner wrote:

> > Without a further explanation of this craziness, it's a little hard to
> > discuss...
> Let's try it:
> time_constant is created for internal use of ntp.c and added by 4
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 time_constant =3D min(txc->constant + 4, (l=
ong)MAXTC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 time_constant =3D min(txc->constant + 4, (l=
ong)MAXTC + 4);

MAXTC is already adjusted.

> But sometimes it is written back to data referenced from outside. So let'=
s do=20
> the + 4 backwards ...
> - =A0 =A0 =A0 txc->constant =A0 =A0 =A0=3D time_constant;
> + =A0 =A0 =A0 txc->constant =A0 =A0 =A0=3D time_constant - 4;

ntpd doesn't read it back for it's own purposes, it only prints it, when=20
the kernel info is queried, it doesn't adjust the constant there, so I=20
didn't do it in the kernel either.

bye, Roman
---1463811837-802229199-1168865006=:14457--
