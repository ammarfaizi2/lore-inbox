Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWACUGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWACUGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWACUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:06:09 -0500
Received: from gate.perex.cz ([85.132.177.35]:5532 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932515AbWACUGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:06:08 -0500
Date: Tue, 3 Jan 2006 21:06:06 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
Cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <1136318187.4106.32.camel@unreal>
Message-ID: <Pine.LNX.4.61.0601032101570.9362@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>  <200601031522.06898.s0348365@sms.ed.ac.uk>
 <20060103160502.GB5262@irc.pl>  <200601031629.21765.s0348365@sms.ed.ac.uk>
  <20060103170316.GA12249@dspnet.fr.eu.org>  <1136312901.24703.59.camel@mindpipe>
 <1136316640.4106.26.camel@unreal>  <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz>
 <1136318187.4106.32.camel@unreal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Thomas Sailer wrote:

> On Tue, 2006-01-03 at 20:37 +0100, Jaroslav Kysela wrote:
> 
> > Anyone reported that? Also what's the exact bug symptom?
> 
> Many people reported this on various mailing lists, but I'm not aware of
> any bugzilla/whatever ticket.
> 
> Problem seems to be that ALSA/OSS does not report the true HW sampling
> rate, but tries to do the sample rate conversion by itself, but
> apparently not doing it good enough for modem type applications.

The "plugin" (or rather conversion, routing and resampling) system in the 
OSS emulation can be turned off using the proc interface:

echo "soundmodem 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "soundmodem 0 0 direct" > /proc/asound/card0/pcm0c/oss

Full documentation is available at:

linux/Documentation/sound/alsa/OSS-Emulation.txt

It's easy to remove the "additional" functionality, but I bet that we
find some users requesting it. Also, in time when the OSS emulation was 
designed, not all OSS applications had own resapling code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
