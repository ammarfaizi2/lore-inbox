Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVC2JZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVC2JZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVC2JXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:23:14 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:39580 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S262250AbVC2JWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:22:30 -0500
In-Reply-To: <1112084311.5353.6.camel@gaston>
References: <1111966920.5409.27.camel@gaston> <1112067369.19014.24.camel@mindpipe> <4a7a16914e8d838e501b78b5be801eca@dalecki.de> <1112084311.5353.6.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Mac mini sound woes
Date: Tue, 29 Mar 2005 11:22:07 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-29, at 10:18, Benjamin Herrenschmidt wrote:
>
> Well, we are claiming _and_ obviously proposing a solution ;)

I beg to differ.

>> 1. Where do you have true "real-time" under linux? Kernel or user 
>> space?
>
> That's bullshit.

Wait a moment...

> you don't need "true" real time for the mixing/volume
> processing in most cases.

Yeah! Give me a break: *Most cases*. Playing sound and video is
paramount for requiring asserted timing. Isn't that a property
RT is defined by?

> I've been doing sound drivers on various
> platforms who don't have anything that look like true realtime neither
> and beleive, it works. Besides, if doing it linux shows latency
> problems, let's just fix them.

Perhaps as an exercise you could fix the jerky mouse movements on
Linux - too? I would be very glad to see the mouse, which has truly 
modest
RT requirements, to start to behave the way it's supposed to do.
And yes I expect it to still move smoothly when doing "make -j100 
world".

>> 2. Where would you put the firmware for an DSP? Far away or as near to
>> hardware as possible?
>
> Yes. This point is moot. The firmware is somewhere in your filesystem
> and obtained with the request_firmware() interface, that has nothing to
> do in the kernel. If it's really small, it might be ok to stuff it in
> the kernel. But anyway, this point is totally unrelated to the 
> statement
> you are replying to.

No. You didn't get it. I'm taking the view that mixing sound is simply
a task you would typically love to make a DSP firmware do.
However providing a DSP for sound processing at 44kHZ on the same
PCB as an 1GHZ CPU is a ridiculous waste of resources. Thus most 
hardware
vendors out there decided to use the main CPU instead. Thus the 
"firmware"
is simply running on the main CPU now. Now where should it go? I'm 
convinced
that its better to put it near the hardware in the whole stack. You 
think
it's best to put it far away and to invent artificial synchronization
problems between different applications putting data down to the
same hardware device.

>> 3. How do you synchronize devices on non real time system?
>
> I'm not sure I understand what you mean here. I suppose it's about
> propagation of clock sources, which is traditionally done in the slave
> way; that is the producer (whatever it is, mixer, app, ...) is "sucked"
> by the lowest level at a given rate, the sample count beeing the
> timestamp, variable sample size having other means (and less precise of
> course) to synchronize.

No I'm simply taking the view that most of the time it's not only a 
single
application which will feed the sound output. And quite frequently you 
have
to synchronize even with video output.

>
>> 4. Why the hell do we have whole network protocols inside the kernel?
>> Couldn't those
>> be perfectly handled in user space? Or maybe there are good reasons?
>
> Network protocol do very few computation on the data in the packets
> (well, except for IPsec for security reasons mostly) but this is a gain
> totally unrelated. Like comparing apples and pears.

No it's not that far away. The same constraints which did lead most 
people
to move TCP in to the kernel basically apply to sound output.
It's just a data stream those days after all.

>> 5. Should a driver just basically map the hardware to the user space 
>> or
>> shouldn't
>> it perhaps provide abstraction from the actual hardware implementing 
>> it?
>
> This is in no way incompatible with having the mixing and volume 
> control
> in userspace. It's actually quite a good idea to have a userland 
> library
> that isolates you from the low level "raw" kernel intefaces of the
> driver, and in the case of sound, provides you with the means to setup
> codec chains, mixing components, etc...

It is not. At least every other OS out there with significant care for
sound did came to a different conclusion.

