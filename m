Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289550AbSAJSut>; Thu, 10 Jan 2002 13:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289593AbSAJSuj>; Thu, 10 Jan 2002 13:50:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6668 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289550AbSAJSu0>; Thu, 10 Jan 2002 13:50:26 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: landley@trommello.org (Rob Landley)
Date: Thu, 10 Jan 2002 19:01:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201101753.g0AHrlA17591@snark.thyrsus.com> from "Rob Landley" at Jan 10, 2002 05:06:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OkSV-0005EZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know what BIOS SMM code is, or what you mean by "hardware fun".  But 
> the worst audio dropouts I have are "cp file.wav /dev/audio" when I forgot to 
> kill cron and updatedb started up.  (This is considerably WORSE than mp3 
> playing.)  I take it "cp" is badly written? :)

Those are ones that Andrew's patch should fix nicely. You might need a
decent VM as well though.

The fun below 1mS comes from

	1.	APM bios calls where the bios decides to take >1mS to have
		a chat with your batteries
	2.	Video cards pulling borderline legal PCI tricks to get
		better benchmarketing by stalling the entire bus

> And a sound card with only 1mS of buffer in it is definitely not useable on 
> windoze, the minimum buffer in the cheapest $12 PCI sound card I've seen is 
> about 1/4 second (250ms).  (Is this what you mean by "hardware fun"?)  Even 

For video conferencing and for real world audio mixing you can't use
that 250ms. Not even for games. If your audio is 150mS late in quake you
will notice it, really notice it. And the buffers on the audio card are
btw generally in RAM not the fifo on the chip, so they dont help when the
PCI bus loads up

> exhausted...)  What sound output device DOESN'T have this much cache?  (You 
> mentioned USB speakers in your diary at one point, which seemed to be like 
> those old "paralell port cable plus a few resistors equals sound output" 
> hacks...)

Umm no USB audio is rather good. USB sends isosynchronous, time guaranteed
sample streams down the USB bus, to the speakers where the A to D is clear
of the machine proper.

> Now VIDEO is a slightly more interesting problem.  (Or synchronizing audio 
> and video by sending really tiny chunks of audio.)  There's no hardware 
> buffer there to cover our latency sins.  Then again, dropping frames is 
> considered normal in the video world, isn't it? :)

You'll see those too. Pure playback is ok because you have to buffer
equally rather than reliably hit deadlines
