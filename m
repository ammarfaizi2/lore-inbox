Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284445AbRLRSZx>; Tue, 18 Dec 2001 13:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLRSZo>; Tue, 18 Dec 2001 13:25:44 -0500
Received: from holomorphy.com ([216.36.33.161]:31106 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S284445AbRLRSZd>;
	Tue, 18 Dec 2001 13:25:33 -0500
Date: Tue, 18 Dec 2001 10:25:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011218102526.A736@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <20011217205547.C821@holomorphy.com> <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 17, 2001 at 10:09:22PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 10:09:22PM -0800, Linus Torvalds wrote:
> Well, looking at the issue, the problem is probably not just in the sb
> driver: the soundblaster driver shares the output buffer code with a
> number of other drivers (there's some horrible "dmabuf.c" code in common).
> And yes, the dmabuf code will wake up the writer on every single DMA
> complete interrupt. Considering that you seem to have them at least 400
> times a second (and probably more, unless you've literally had sound going
> since the machine was booted), I think we know why your setup spends time
> in the scheduler.
> A number of sound drivers will use the same logic.

I've chucked the sb32 and plugged in the emu10k1 I had been planning
to install for a while, to good effect. It's not an ISA sb16, but it
apparently uses the same driver.

I'm getting an overall 1% reduction in system load, and the following
"top 5" profile:

 53374 total                                      0.0400
 11430 default_idle                             238.1250
  8820 handle_IRQ_event                          91.8750
  2186 do_softirq                                10.5096
  1984 schedule                                   1.2525
  1612 number                                     1.4816
  1473 __generic_copy_to_user                    18.4125

Oddly, I'm getting even more interrupts than I saw with the sb32...

  0:    2752924          XT-PIC  timer
  9:   14223905          XT-PIC  EMU10K1, eth1

(eth1 generates orders of magnitude fewer interrupts than the timer)

On Mon, Dec 17, 2001 at 10:09:22PM -0800, Linus Torvalds wrote:
> You may be able to change this more easily some other way, by using a
> larger fragment size for example. That's up to the sw that actually feeds
> the sound stream, so it might be your decoder that selects a small
> fragment size.
> Quite frankly I don't know the sound infrastructure well enough to make
> any more intelligent suggestions about other decoders or similar to try,
> at this point I just start blathering.

Already more insight into the problem I was experiencing than I had
before, and I must confess to those such as myself this lead certainly
seems "plucked out of the air". Good work! =)

On Mon, Dec 17, 2001 at 10:09:22PM -0800, Linus Torvalds wrote:
> But yes, I bet you'll also see much less impact of this if you were to
> switch to more modern hardware.

I hear from elsewhere the emu10k1 has a bad reputation as source of
excessive interrupts. Looks like I bought the wrong sound card(s).
Maybe I should go shopping. =)


Thanks a bunch!
Bill
