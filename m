Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283780AbRLROVg>; Tue, 18 Dec 2001 09:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283782AbRLROV1>; Tue, 18 Dec 2001 09:21:27 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:15233
	"HELO tabris.net") by vger.kernel.org with SMTP id <S283780AbRLROVR>;
	Tue, 18 Dec 2001 09:21:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
Date: Tue, 18 Dec 2001 09:21:08 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011217200946.D753@holomorphy.com> <Pine.LNX.4.33.0112172014530.2281-100000@penguin.transmeta.com> <20011217205547.C821@holomorphy.com>
In-Reply-To: <20011217205547.C821@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011218142110.A0DD2FB8C0@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 23:55, William Lee Irwin III wrote:
> On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> > The most likely cause is simply waking up after each sound interrupt: you
> > also have a _lot_ of time handling interrupts. Quite frankly, web surfing
> > and mp3 playing simply shouldn't use any noticeable amounts of CPU.
>
> I think we have a winner:
> /proc/interrupts
> ------------------------------------------------
>            CPU0
>   0:   17321824          XT-PIC  timer
>   1:          4          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:   46490271          XT-PIC  soundblaster
>   9:     400232          XT-PIC  usb-ohci, eth0, eth1
>  11:     939150          XT-PIC  aic7xxx, aic7xxx
>  14:         13          XT-PIC  ide0
>
> Approximately 4 times more often than the timer interrupt.
> That's not nice...

FWIW, I have an ES1371 based sound card, and mpg123 drives it at 172 
interrupts/sec (calculated in procinfo). But that _is_ only when playing. And 
(my slightly hacked) timidity drives my card w/ only 23(@48kHz sample rate; 
21 @ 44.1kHz) interrupts/sec

Is this 172 figure right? (Not through esd either. i almost always turn it 
off, and sp recompiled mpg123 to use the std OSS driver)

>
> On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> > Which sound driver are you using, just in case this _is_ the reason?
>
> SoundBlaster 16
> A change of hardware should help verify this.
>
>
> Cheers,
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
