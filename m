Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289582AbSAJSK3>; Thu, 10 Jan 2002 13:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289122AbSAJSKT>; Thu, 10 Jan 2002 13:10:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:54942
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289428AbSAJSKJ>; Thu, 10 Jan 2002 13:10:09 -0500
Message-Id: <200201101753.g0AHrlA17591@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Thu, 10 Jan 2002 05:06:59 -0500
X-Mailer: KMail [version 1.3.1]
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu>
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 January 2002 09:25 pm, Alan Cox wrote:
> > Do you want an operating system capable of running real-world code
> > written by people who know more about their specific problem domain
> > (audio) than about optimal coding in general, or do you want an operating
> > system intended to only run well-behaved applications designed and
> > implemented by experts?
>
> I want an OS were a reasonably cluefully written audio program works. That
> to me means aiming at the 1mS latency mark. Which doesn't seem to be
> needing pre-empt. Beyond a typical 1mS latency you have hardware fun to
> worry about, and the BIOS SMM code eating you.

I don't know what BIOS SMM code is, or what you mean by "hardware fun".  But 
the worst audio dropouts I have are "cp file.wav /dev/audio" when I forgot to 
kill cron and updatedb started up.  (This is considerably WORSE than mp3 
playing.)  I take it "cp" is badly written? :)

And a sound card with only 1mS of buffer in it is definitely not useable on 
windoze, the minimum buffer in the cheapest $12 PCI sound card I've seen is 
about 1/4 second (250ms).  (Is this what you mean by "hardware fun"?)  Even 
if the app was taking half that, it's still a > 100ms big gap where the OS 
leaves it hanging before you get a dropout.  (Okay, some of that's watermark 
policy, not sending more data to the card until half the buffer is 
exhausted...)  What sound output device DOESN'T have this much cache?  (You 
mentioned USB speakers in your diary at one point, which seemed to be like 
those old "paralell port cable plus a few resistors equals sound output" 
hacks...)

Now VIDEO is a slightly more interesting problem.  (Or synchronizing audio 
and video by sending really tiny chunks of audio.)  There's no hardware 
buffer there to cover our latency sins.  Then again, dropping frames is 
considered normal in the video world, isn't it? :)

Rob
