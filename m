Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVC2IYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVC2IYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVC2IVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:21:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:51417 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262219AbVC2ITc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:19:32 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 18:18:31 +1000
Message-Id: <1112084311.5353.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > dmix has been around for a while but softvol plugin is very new, you
> > will need ALSA CVS or the upcoming 1.0.9 release.
> 
> Instead of the lame claims on how ugly it is to do hardware mixing in
> kernel space the ALSA fans should ask them self the following questions:

Well, we are claiming _and_ obviously proposing a solution ;)

> 1. Where do you have true "real-time" under linux? Kernel or user space?

That's bullshit. you don't need "true" real time for the mixing/volume
processing in most cases. I've been doing sound drivers on various
platforms who don't have anything that look like true realtime neither
and beleive, it works. Besides, if doing it linux shows latency
problems, let's just fix them.

> 2. Where would you put the firmware for an DSP? Far away or as near to 
> hardware as possible?

Yes. This point is moot. The firmware is somewhere in your filesystem
and obtained with the request_firmware() interface, that has nothing to
do in the kernel. If it's really small, it might be ok to stuff it in
the kernel. But anyway, this point is totally unrelated to the statement
you are replying to.

> 3. How do you synchronize devices on non real time system?

I'm not sure I understand what you mean here. I suppose it's about
propagation of clock sources, which is traditionally done in the slave
way; that is the producer (whatever it is, mixer, app, ...) is "sucked"
by the lowest level at a given rate, the sample count beeing the
timestamp, variable sample size having other means (and less precise of
course) to synchronize.

> 4. Why the hell do we have whole network protocols inside the kernel? 
> Couldn't those
> be perfectly handled in user space? Or maybe there are good reasons?

Network protocol do very few computation on the data in the packets
(well, except for IPsec for security reasons mostly) but this is a gain
totally unrelated. Like comparing apples and pears.

> 5. Should a driver just basically map the hardware to the user space or 
> shouldn't
> it perhaps provide abstraction from the actual hardware implementing it?

This is in no way incompatible with having the mixing and volume control
in userspace. It's actually quite a good idea to have a userland library
that isolates you from the low level "raw" kernel intefaces of the
driver, and in the case of sound, provides you with the means to setup
codec chains, mixing components, etc...

> 6. Is there really a conceptual difference between a DSP+CPU+driver and 
> just
> looking at the MMX IP core of the CPU as an DSP?

Again, I don't see how this makes any point in the context of the
discussion above and your heated reply.

Ben.


