Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSDDTZp>; Thu, 4 Apr 2002 14:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310468AbSDDTZb>; Thu, 4 Apr 2002 14:25:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6413 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310434AbSDDTZO>; Thu, 4 Apr 2002 14:25:14 -0500
Date: Thu, 4 Apr 2002 21:25:15 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Superfluous videomode reload during VT switch
Message-ID: <20020404192515.GA31252@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I got a

  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 PF (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
      I/O at 0xc800 [0xc8ff].
      Non-prefetchable 32 bit memory at 0xff4fc000 [0xff4fffff].

and framebuffer.

When I switch between the consoles the monitor picture gets 1/3 of its width
and slowly ramps up to normal size during next 400ms. It is obviously weird
because framebuffer uses the same video mode on all consoles so that there
is no point is resetting it again and again when it is the same mode.

When I hold alt & -> what I get is 1/3 of width and a stress-test on my
horizontal power transistor.

I believe that rapid console switches by user are common task and today's
monitor's hsync stages are very stressed (must generate pretty strong magnetic
field and at 150kHz of hsync this makes huge voltages that may even climb up
during such transients) and this "games" with them usually activates
accelerated aging mechanism.

Not mentioning the fact that monitors usually do nasty things during mode switch as:
a) Loud clicking (relays)
b) Audible hiss from the desynchronized hsync subsystem
c) Picture dropouts for up to seconds
d) Annoying boxes with mode information

Clock

