Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbRLRE4L>; Mon, 17 Dec 2001 23:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285134AbRLRE4A>; Mon, 17 Dec 2001 23:56:00 -0500
Received: from holomorphy.com ([216.36.33.161]:24708 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285130AbRLREzv>;
	Mon, 17 Dec 2001 23:55:51 -0500
Date: Mon, 17 Dec 2001 20:55:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011217205547.C821@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@transmeta.com
In-Reply-To: <20011217200946.D753@holomorphy.com> <Pine.LNX.4.33.0112172014530.2281-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112172014530.2281-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 17, 2001 at 08:27:18PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> The most likely cause is simply waking up after each sound interrupt: you
> also have a _lot_ of time handling interrupts. Quite frankly, web surfing
> and mp3 playing simply shouldn't use any noticeable amounts of CPU.

I think we have a winner:
/proc/interrupts
------------------------------------------------
           CPU0       
  0:   17321824          XT-PIC  timer
  1:          4          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:   46490271          XT-PIC  soundblaster
  9:     400232          XT-PIC  usb-ohci, eth0, eth1
 11:     939150          XT-PIC  aic7xxx, aic7xxx
 14:         13          XT-PIC  ide0

Approximately 4 times more often than the timer interrupt.
That's not nice...

On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> Which sound driver are you using, just in case this _is_ the reason?

SoundBlaster 16
A change of hardware should help verify this.


Cheers,
Bill
