Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRDZEwx>; Thu, 26 Apr 2001 00:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRDZEwn>; Thu, 26 Apr 2001 00:52:43 -0400
Received: from MAIL1.ANDREW.CMU.EDU ([128.2.10.131]:50914 "EHLO
	mail1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S133106AbRDZEwY>; Thu, 26 Apr 2001 00:52:24 -0400
Date: Thu, 26 Apr 2001 00:51:53 -0400 (EDT)
From: Paul Komarek <komarek@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: ross@willow.seitz.com, komarek@andrew.cmu.edu
Subject: 2.4.x APM interferes with FA311TX/natsemi.o
Message-ID: <Pine.LNX.4.21L.0104260037320.17383-100000@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SUMMARY:  the APM call
  apm_bios_call_simple(APM_FUNC_SET_STATE, 0x100, APM_STATE_READY, &eax)
causes my Netgear FA311TX to enter a sleep mode.

DESCRIPTION:
I am having difficulties with the natsemi.o driver with a Netgear FA311TX.  
When the call
  apm_bios_call_simple(APM_FUNC_SET_STATE, 0x100, APM_STATE_READY, &eax)
is made, the PMEEN (PME enable) bit in the CCSR register on my FA311
mysteriously changes from 0 to 1, causing the card to stop processing
received packets.  This APM call is made when unblanking the screen, for
instance when switching from KD_GRAPHICS to KD_TEXT with the KDSETMODE
ioctl on a virtual terminal.

I've modified this APM call to report the status of the PMEEN bit before
and after the short sequence of assembly statement in
apm_bios_call_simple() is executed.  I'm guessing there isn't any
interrupt activity between my "before" and "after" checks.  At least the
natsemi.o driver's interrupt handler isn't being called, but I can't vouch
for other interrupt handlers.

I'm more-or-less stuck for what to do next.  I'm a complete novice with
the kernel, the PCI bus, APM, or network cards, and this is my first
project.  I'd appreciate pointers for what to try next, since I've
received no responses from the driver maintainers Donald Becker, Tjeerd
Mulder, and Jeff Garzik yet.

Please cc me in any responses, as I'm not currently subscribed to the
kernel mailing list.  Thanks in advance.

-Paul Komarek





