Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRIVPyy>; Sat, 22 Sep 2001 11:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRIVPyn>; Sat, 22 Sep 2001 11:54:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35084 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271708AbRIVPy0>; Sat, 22 Sep 2001 11:54:26 -0400
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
To: gward@python.net (Greg Ward)
Date: Sat, 22 Sep 2001 16:58:53 +0100 (BST)
Cc: davidgrant79@hotmail.com (David Grant), bugs@linux-ide.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010922110945.B678@gerg.ca> from "Greg Ward" at Sep 22, 2001 11:09:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpB7-0003XS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> up... or it locks up.  (I had the lockup problem with kernel 2.4.2 and
> the suspect drive on my Promise IDE interface.  On the VIA interface, it
> booted eventually after ~60 sec of timeout errors.  Under 2.4.9, the
> kernel doesn't take as long to timeout, and it's not as noisy as it was
> under 2.4.2, but the underlying problem is still there: no DMA.)

The timeout is it issuing DMA requests that failed. 

> > 10, sometimes 100), the installer halts, the hard disk light stays on, and
> > if I use CTRL-ALT-F4, I see these DMA timeout errors.  The hard drive is
> > unresponsive unless I do a cold boot, as opossed to warm boot.

For RH and other stuff that picked up the RH diffs (now in Linus 2.4.7+
tree or so) you can boot with the option "ide=nodma"

> drive.  I've had positive reports from two people with the ASUS A7V
> motherboard and ATA/100 drives under Linux 2.4, so it's certainly
> possible.  I just need to find someone with some redundant hardware that

Older trees take one DMA timeout and go PIO. That turns out to be bad
because very very occasionally other things (I guess drive calibration etc)
will cause the DMA to timeout.

With the 2.4.9-ac tree I have two boxes which get DMA timeouts. One of them
very very rarely and the retry recovers nicely, the other DMA does not work
and after poking around I discovered windows also disables DMA on this
mini notebook..
