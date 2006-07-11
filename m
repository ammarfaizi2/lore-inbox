Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWGKG55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWGKG55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWGKG55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:57:57 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:4295 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id S965037AbWGKG5z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:57:55 -0400
Date: Tue, 11 Jul 2006 08:59:52 +0200
From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: galibert@pobox.com, ak@suse.de, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060711085952.f1254229.atlka@pg.gda.pl>
In-Reply-To: <1152578344.21909.12.camel@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
	<44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
Organization: Gdansk University of Technology
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 20:39:03 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-07-11 at 01:59 +0200, Olivier Galibert wrote:
> > ALSA lib has something like 7 different methods just to play a sound.
> > Their view of "low level" is quite interesting.  Using it is pure
> > hell.  Debugging what you've done is worse.  And don't bother to hope
> > that your code will still work in six months.
> > 
> 
> A small FAQ:
> 
> Q: But OSS is kewl and ALSA sucks!
> A: The decision for the OSS->ALSA move was four years ago.
>    If ALSA sucks, please help to improve ALSA.

The problem is that ALSA is done a Windows way with too many not always working ways
of obtaining sound and lack of user docs. So there is still the general question:
Is it the proper way? How I can help improve ALSA if I just dislike its design?

I spent some time improving dmix and aoss in the past. I have a version of aoss
which uses callbacks and works properly with some not properly written OSS apps.
It's very interesting that with some apps aoss method gives better sound A/V synchronization then using native ALSA app support ;-).
But callbacks not always work and LD_PRELOAD method is generally not secure
and some kind of a hack. So I just don't think it could be improved with it's current design.
In my opinion it should work out of the box without need to rewrite old or proprietary apps
and messing with LD_PRELOAD. So /dev/dsp compatibility is a must. But with all input/output
mixing of course. Userspace thread method leads to many problems - swapping and rescheduling leads to bad acustic effects. Of course if an app can't supply data when it should we can't do anything but if scheduling or swapping causes problems the design seems to be bad.

There are many devices which need to be served at the some critical point in time
- sound cards, video and tv grabbers, some dedicated lab cards, i/o ports etc.
Generally on the really low level this is a kernel driver which sticks to the hardware and should ``know'' how critical is to serve hw requests just in time. If we have data in a buffer programing DMA transfer is a quite quick operation but must be done at the proper moment.
So maybe we should delay a bit other io for example and just do it. But it must be done in kernel because kernel should know these critical time parameters for all devices in the system and decide which to serve and when. Maybe this is not needed for all devices but for audio/video devices it's a must. Better kernel support for these kind of devices is absolutely needed.

ALSA in lib way has its limitations and drawbacks and adding more feaures this way
leads to more complications only IMHO.

Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
