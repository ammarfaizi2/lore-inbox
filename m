Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBIPHz>; Fri, 9 Feb 2001 10:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBIPHp>; Fri, 9 Feb 2001 10:07:45 -0500
Received: from winds.org ([207.48.83.9]:517 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129026AbRBIPHh>;
	Fri, 9 Feb 2001 10:07:37 -0500
Date: Fri, 9 Feb 2001 10:05:44 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: vojtech@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PCI clock
 detection
Message-ID: <Pine.LNX.4.21.0102090959530.582-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've decided that too much trouble has been caused by a wrong PCI clock
> specified to the IDE drivers (which in turn compute wrong IDE timings).
> 
> I've made the VIA and AMD drivers detect the PCI clock automatically.
> Because this is a very significant change, I've upped the major release
> numbers to 4 and 2.
> 
> Could anyone with these chipsets check these drivers if they detect the
> PCI clock correctly on their systems?

Certainly. I tested this on my machine with PCIClk 33, 34, and 36.6. The driver
correctly tuned the clocks to 33, 34, and 37 (expected and not harmful). It
works very well.

One thing to note: You should probably display the new clock speed in the
kernel debug messages on bootup. Also I don't know if you've done this already,
but if the user specifies an idebus=xx then that should override the auto
detection.

I do have a concern however. When you autodetect the PCI clock, does that
propagate to other IDE controllers that have been initialized? For instance, my
Abit KT7-Raid also has a Highpoint 370 controller. My fear is that it may get
initialized to 33 before the VIA controller is started and before detecting
that the true PCI clock is really 37. Unless the Highpoint controller has an
external timing mechanism I think this could pose a problem.

If it could help things, maybe a patch can be made to the standard IDE setup
routines that will replace the message "Assuming 33MHz for PIO modes" to
"Autodetected PCI Clock at 37MHz". This would ensure that all the IDE drivers
get set up with the correct detected PCI clock, and not just VIA/AMD's.

Thoughts/comments?
 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
