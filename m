Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280130AbRJaKlf>; Wed, 31 Oct 2001 05:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280010AbRJaKlZ>; Wed, 31 Oct 2001 05:41:25 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:10995 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S279961AbRJaKlV>; Wed, 31 Oct 2001 05:41:21 -0500
Date: Wed, 31 Oct 2001 10:41:29 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
Message-ID: <Pine.LNX.4.33.0110311040180.10416-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now I'm looking into why SNDCTL_DSP_SETFMT is failing on 2.2.19
sparc. I've been trying to get ESD to work on my SS20 box so I can play
music.

The situation is that the ioctl() is failing with -EINVAL for a perfectly
valid argument.

Here's the strace output from running ESD (snipped for brevity)

open("/dev/dsp", O_WRONLY)              = 3
ioctl(3, 0x6004500a, 0xefffe944)        = 0
write(1, "DEBUG: 60045005\n", 16DEBUG: 60045005)       = 16
write(1, "DEBUG: 00000010\n", 16DEBUG: 00000010)       = 16
ioctl(3, 0x60045005, 0xefffe944)        = -1 EINVAL (Invalid argument)

The debug statements I put in ESD shows the right argument with the right
value is being passed by the ioctl() call. 0x00000010 is AFTM_S16_BE, by
the way.

I've had a look at audio.c in /drivers/sbus/audio (lines 1046 to 1144),
and everything looks correct, down to the parameters, so why is it
returning -EINVAL?

Weird. Any ideas?

-- 
Top posters will be automatically killfiled.

http://www.tahallah.demon.co.uk

