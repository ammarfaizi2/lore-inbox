Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWAIPNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAIPNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWAIPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:13:37 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:7026 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP id S932343AbWAIPNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:13:36 -0500
Date: Mon, 9 Jan 2006 17:10:58 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <200601091405.23939.rene@exactcode.de>
Message-ID: <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz> <200601091405.23939.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463749119-582612059-1136819458=:21552"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463749119-582612059-1136819458=:21552
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Jan 2006, Ren=E9 Rebe wrote:

> > I don't think so. The library can do such conversions (and alsa-lib doe=
s)=20
> > quite easy. If we have a possibility to remove the code from the kernel=
=20
> > space without any drawbacks, then it should be removed. I don't see any=
=20
> > advantage to have such conversions in the kernel.
>=20
> Also, when the data is already available as single streams in a user-spac=
e
> multi track application, why should it be forced interleaved, when the ha=
rdware
> could handle the format just fine?
Because the conversion doesn't cost anything. Trying to avoid it by=20
making the API more complicated (I would even say confusing) is extreme=20
overkill.=20

Each feature of this kind requires two additional API=20
calls (one for checking in which way the hardware works and another to=20
set the device to use the feature). It's also possible to implement the=20
feature in a way that requires more new calls. By adding support for=20
dozens of features like this it's easy to create an API that has 1500+=20
calls.

Even worse this kind of features weaken the device abstraction provided by=
=20
the API. The applications will have to check for this and=20
that and provide support for 100s of special cases that may be required by=
=20
certain devices.=20

IMHO this has already happened with ALSA. Normal=20
programmers (other than few of the world class gurus) have no way to=20
understand the API. I would consider myself at least moderately=20
experienced sound programmer (25+ years of programming experience and more=
=20
than half of it on sound). However even after two years of more or less=20
intense learning I don't know what is the preferred way to use ALSA. I=20
think this is a general problem because practically all ALSA applications u=
se=20
different ALSA API calls.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
---1463749119-582612059-1136819458=:21552--
