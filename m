Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRBKKqX>; Sun, 11 Feb 2001 05:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRBKKqO>; Sun, 11 Feb 2001 05:46:14 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8964 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132152AbRBKKqD>;
	Sun, 11 Feb 2001 05:46:03 -0500
Message-ID: <20010210233255.H7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 23:32:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: clock@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Inadmissible sound dropouts on 2.2.18
In-Reply-To: <20010204120728.48319@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010204120728.48319@ghost.btnet.cz>; from clock@ghost.btnet.cz on Sun, Feb 04, 2001 at 12:07:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I found that 2.2.18 probably rudely drops samples (lets ocassionally one sample
> be played several times) on the Gravis Ultrasound output device. I use 2.2.18
> and the native kernel drivers. I wrote this program that should produce a clean
> sine tone. Instead I hear a sine interspaced with crackling. The crackling
> repeats at 100Hz I guess. There runs nothing CPU-consuming. The sound process
> takes 5% CPU. It's funny Linux drops sound samples just at 5% of CPU load. I
> got AMD K6-2 3D 400Mhz at 400Mhz, 4*100MHz, running stably between 20-35 deg C
> of case temperature. I got PCI / AGP board FIC VA-503+.  There are three serial
> ports, none of them was transceiving at that time. There is one ISA
> NE2000 NIC

And receiving?

There are tools for measuring latency problems. Look at kernel archives.

> The crackling is not dependent on the buffer size you can set up in the C code.
> The crackling is dependent on the frequency of the sine. It's clearly audible
> (read: annoying) at 10kHz, audible at 1kHz, inaudible at 100Hz. So I think
> they are sample dropouts - the card stops playing and repeats one sample until
> kernel gets the breath and whips itself up to supply next audio
> data.

Or it is just Graivs driver bug...

> There are no custom changes in the drivers - no buffer tweaking, nothing. The
> Gravis plays modules, midules and mp3 with nearly no problems (apart from when
> Loreena Mc Kennith sings too high and too loud, I hear something that looks like
> MP3 frames bounds, but I can't surely tell who's responsible for this - if the
> Fraunhofer Institute or Linux Kernel)

;) Or maybe problem is in your application. Can you generate sample
file than "play" it with cat samples > /dev/dsp? You can do it on
different machines to learn if it is gravis or something else.

									Pavel
PS: I think it is your app that is buggy. You write to soundcard, then
you do _lots_ of floating point computation, then you write
again.... If your computtation takes too long, you'll hear
cracking... Of course. You wrote latency critical app!

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
