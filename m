Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVJaRiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVJaRiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVJaRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:38:50 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:36033 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932503AbVJaRit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:38:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aq14C8JtzgkU/cw6GhfCk1BNVIIlboDSwVQHGs0vkHK8qnblyvNZbeHJ8EFVORb5bTTsk8Lb0RClVHKzYmg5kCAOWEp/G4FrG9xmgkeNs938oXBJXVHCwS/0gTmmeXDmbmEzR/q6PJ7Tj3Ac59RxXziUgXJAh25PFIqMXLFZHcU=
Message-ID: <5bdc1c8b0510310938k48819f4bnec43653e091d61f6@mail.gmail.com>
Date: Mon, 31 Oct 2005 09:38:48 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
Cc: "K.R. Foley" <kr@cybsft.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1130776760.32101.40.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
	 <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>
	 <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
	 <1130776760.32101.40.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-10-31 at 07:26 -0800, Mark Knecht wrote:
> >    I'm going to do as Lee and Ingo suggest, now that I have a test
> > that seems to create xruns pretty qickly. Hopefully I'll capture
> > something of interest. However I'm questioning exactly what the video
> > problem would be since I don't create xruns when watching MythTV full
> > screen. Only get them when watching in this preview window. That said
> > it is an ATI PCI-Express card but since it's 2.6.14 there is no ATI
> > driver support. My kernel is currently trying to load fglrx (the ATI
> > driver) and failing since it doesn't support this kernel. I'll clean
> > up the video driver setup and retest.
>
> Please try my first suggestion, just set Option "NoAccel" to the Device
> section of your xorg.conf.

Too bad I didn't remember that from last evening. Sorry.

Anyway, I've switched to the Xorg-X11 radeon driver and have been
running about 20 minutes in the preview mode. No xruns so far so
that's an improvement over last evening. This is at 64/2, so sub-3mS:

09:10:31.830 /usr/bin/jackd -R -P80 -p512 -dalsa -dhw:1 -r44100 -p64 -n2
09:10:31.842 JACK was started with PID=8175 (0x1fef).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:1|hw:1|64|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:1
configuring for 44100Hz, period = 64 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
09:10:33.858 Server configuration saved to "/home/mark/.jackdrc".
09:10:33.859 Statistics reset.
09:10:34.022 Client activated.
09:10:34.023 Audio connection change.
09:10:34.027 Audio connection graph change.
09:10:36.942 Audio connection graph change.
09:10:37.038 Audio connection change.
09:10:39.062 Audio connection graph change.

mark@lightning ~ $ date
Mon Oct 31 09:32:36 PST 2005
mark@lightning ~ $

Last evening I would have had 5-10 xruns by now.

I'm kicking myself for not cleaning that up earlier. It's one of those
lingering things about ATI drivers and testing new kernels. You load
fglrx because you're running 2.6.13 and it works. You jump to a
testing kernel and the ATI drivers don't support it but you go on
leaving the fglrx call in, and you see the driver load fail at boot
time. I got lazy and never cleaned it up.

My bad...

I wish modprobe.conf was in /lib/modules/XXX so that the modules
loaded could be changed from kernel to kernel.

Anyway, better and better. We'll see how today goes.

Thanks!

- Mark
