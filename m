Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVKVIUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKVIUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVKVIUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:20:09 -0500
Received: from gate.perex.cz ([85.132.177.35]:10693 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750732AbVKVIUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:20:08 -0500
Date: Tue, 22 Nov 2005 09:20:05 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christian Parpart <trapni@gentoo.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virtual OSS devices [for making selfish apps happy]
In-Reply-To: <1132609221.29178.93.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0511220913320.9659@tm8103-a.perex-int.cz>
References: <200511212216.10837.trapni@gentoo.org> <1132609221.29178.93.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Lee Revell wrote:

> On Mon, 2005-11-21 at 22:16 +0100, Christian Parpart wrote:
> > Hi all,
> > 
> > I'm having some apps running on my desktop that all want
> > exclusive access to my sound device just for playing audio
> > (and a single app for capturing), namely:
> > 
> >  * TeamSpeak (VoIP team voice chat)
> >  * Cedega (for playing some win32 games on my beloved box)
> >  * KDE/arts (my desktop wants to play some sounds as well wtf)
> > 
> > While I could easily disable my desktop sounds, and yeah, forget about the 
> > music, but I'd still like to be in TeamSpeak (talking to friends and alike) 
> > while playing a game using cedega.
> > 
> > Unfortunately, *all* those stupid (2) apps want exclusive access to the OSS 
> > layout of my ALSA drivers, though, there just came into my mind to buy a 
> > second audio device and wear a second headset (a little one below/under my 
> > big one). But I couldn't find it handy anyway :(
> 
> This problem is (mostly) solved already.  You have to use aoss (alsa-lib
> based OSS emulation) on top of dmix (software mixing for soundcards too
> lame to do it in hardware).  With a recent ALSA dmix is already used by
> default so the only change needed is to launch the OSS apps with the
> aoss wrapper e.g. aoss ./foo-oss-app.  Since it's not completely
> transparent this problem will have to be solved at the distro level, by
> making sure all OSS apps are run with this wrapper.
> 
> This method should only be needed for closed source apps, an open source
> app like artsd should be ported to use the ALSA API.

Also note that we have Open Sound System call redirector in our alsa-oss 
package (see http://www.alsa-project.org for download). It's small library 
which can redirects OSS calls to any dynamic library.

It would be nice to convert existing OSS apps to use this library. It 
should be quite fast and easy. The only thing is to persuade sound
developers to use this library instead the direct open/close/ioctl 
OSS syscalls.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
