Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWAEOpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWAEOpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWAEOp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:45:29 -0500
Received: from mail.cs.tut.fi ([130.230.4.42]:25847 "EHLO mail.cs.tut.fi")
	by vger.kernel.org with ESMTP id S1751354AbWAEOpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:45:25 -0500
Date: Thu, 5 Jan 2006 16:45:21 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105144521.GF757@jolt.modeemi.cs.tut.fi>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.9i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 03:24:18PM +0100, Jaroslav Kysela wrote:
> On Thu, 5 Jan 2006, Heikki Orsila wrote:
> This sentence makes this in my mind: real people = lazy people.

Yes, but it has good reasons too. The real point of userspace libraries 
and programs rather than kernel space is saving effort. Laziness in 
programming is good so long as programs are readable and correct.

Your success must be measured according to the number of bugs with ALSA 
programs and the time used to develop ALSA support for them. Right now 
it looks very bad to me. Even libao can't handle ALSA well, and knowing 
some XMMS developers they have hard time with ALSAs complexity. KISS.

> The error codes are documented well.

That's a bad excuse for requiring buffer underruns to be handled 
specially because it's not a fatal error. Errors should be handled 
as close to the error source as possible, and the ALSA lib is the 
logical place to handle underrun by default (unless the application 
really is interested in handling underruns specially). Passing errors 
through unreasonably many layers causes more complexity for programmers.

> > 	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate, frames_in_period /* 0 for automated default */ );
> > 	err = alsa_simple_writei(); /* handless signal brokeness automagically */
> > 	alsa_simple_close();
> 
> Well, it's better to create only "fast parameter setup" and "default error 
> recovery" functions.

As long as all applications PCM code can be written into 10-20 C lines. 
That includes: opening device, writing pcm data and closing the device. 

> > Basically ogg123/mpg123 like applications would only need 3 alsa calls. 
> > Now everyone reimplementing their own buggy versions of simple mechanisms.
> 
> While "official" examples exists for a long time.

btw. your official examples don't work on simple PCM playback didn't 
work when I last time tried. Sorry, I can't remember details because it 
is so long ago.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
