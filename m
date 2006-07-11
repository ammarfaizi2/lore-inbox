Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWGKJxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWGKJxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWGKJxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:53:00 -0400
Received: from gate.perex.cz ([85.132.177.35]:35772 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750889AbWGKJw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:52:59 -0400
Date: Tue, 11 Jul 2006 11:52:56 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Cc: rlrevell@joe-job.com, galibert@pobox.com, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
In-Reply-To: <20060711110811.947e15ed.atlka@pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
 <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl>
 <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
 <20060710235934.GC26528@dspnet.fr.eu.org> <1152578344.21909.12.camel@mindpipe>
 <20060711085952.f1254229.atlka@pg.gda.pl> <Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
 <20060711110811.947e15ed.atlka@pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1798431545-1152611576=:9147"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1798431545-1152611576=:9147
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Jul 2006, Adam Tla=B3ka wrote:

> OSS kernel compatibility is only partial and aoss method is not fully=20

Partial? Elaborate please. And talk about OSS drivers in 2.6 kernel.

> > b) you're requestion to avoid scheduler participation in the audio=20
> >    processing and yes, we have this solution already (dmix), but not in=
=20
> >    kernel
>=20
> just the contrary - scheduler participation is needed to avoid sound=20
> distortion and missing samples

Nope. You're missing that dmix does not add any extra latencies, because
samples are written directly to the DMA buffer.

> > c) as you said, the kernel should contain only critical code to drive
> >    hardware, sample rate conversion, sample format conversions and so o=
n
> >    are NOT part of this code in my opinion
>=20
> if doing this operations behind application back can lead to not deliveri=
ng
> data to kernel driver in time then these are time critical operations too=
!

Sorry, but you have limited resources (CPU power). It's completely=20
irrelevant, if you do processing in the user space or in kernel (in my=20
opinion it's even worse to do such things in the interrupt context).
It's probably better to think how to instruct scheduler to wake up
the sound applications as soon as possible.

> > > ALSA in lib way has its limitations and drawbacks and adding more=20
> > > feaures this way leads to more complications only IMHO.
> >=20
> > Which limitations? We can do all things like OSS API. The whole point o=
f=20
> > all problems is that OSS has the API entry point in syscalls which is=
=20
> > quite bad so the redirection is problematic.
>=20
> Yes but what a complicated way. And you cannot use kernel OSS emulation
> and ALSA aware apps at the same time. Also aoss with dmix are in
> conflict with jackd for example.

??? Elaborate. It should work.

> Kernel redirector is not a bad solution - there should be some kind of=20
> interface for such redirectors for different purposes. netlink device=20
> maybe? For example you should redirect all these traffic to some RT=20
> daemon doing all job.

I would prefer probably a network lowlevel ALSA driver. You'll get the=20
network transparency as benefit.

> Same with filesystem redirections. I hate these special gnomevfs or kdeio
> helpers which forces to rebuilding apps with more and more libs.
> Change LD_PRELOAD or LD_LIBRARY_PATH and you app will go to hell.
> This is the Windows way of doing uncontrolled mess.
> This plugin architecture without mandatory kernel access control leads
> to serious security risc.

Unfortunately, more functionality requires more code. You have to deal=20
with bloating the user or kernel space.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-1798431545-1152611576=:9147--
