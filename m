Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWAJJWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWAJJWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWAJJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:22:43 -0500
Received: from gate.perex.cz ([85.132.177.35]:40339 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932145AbWAJJWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:22:42 -0500
Date: Tue, 10 Jan 2006 10:22:40 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060105144521.GF757@jolt.modeemi.cs.tut.fi>
Message-ID: <Pine.LNX.4.61.0601101018580.10330@tm8103.perex-int.cz>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
 <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
 <20060105144521.GF757@jolt.modeemi.cs.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Heikki Orsila wrote:

> > > 	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate, frames_in_period /* 0 for automated default */ );
> > > 	err = alsa_simple_writei(); /* handless signal brokeness automagically */
> > > 	alsa_simple_close();
> > 
> > Well, it's better to create only "fast parameter setup" and "default error 
> > recovery" functions.
> 
> As long as all applications PCM code can be written into 10-20 C lines. 
> That includes: opening device, writing pcm data and closing the device. 

I've added snd_pcm_set_params() and snd_pcm_recover() functions into 
alsa-lib (they're a bit experimental and I'm still waiting for any 
feedback from others).

The "minimal example" can be reached at:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/test/pcm_min.c?rev=1.2&view=markup

> > > Basically ogg123/mpg123 like applications would only need 3 alsa calls. 
> > > Now everyone reimplementing their own buggy versions of simple mechanisms.
> > 
> > While "official" examples exists for a long time.
> 
> btw. your official examples don't work on simple PCM playback didn't 
> work when I last time tried. Sorry, I can't remember details because it 
> is so long ago.

Any bug report? We don't have a crystal ball to fix bugs without any 
information.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
