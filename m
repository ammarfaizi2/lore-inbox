Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbREaU1x>; Thu, 31 May 2001 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbREaU1n>; Thu, 31 May 2001 16:27:43 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:45270 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S263208AbREaU12>;
	Thu, 31 May 2001 16:27:28 -0400
From: thunder7@xs4all.nl
Date: Thu, 31 May 2001 22:27:08 +0200
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: [lkml]Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
Message-ID: <20010531222708.A8295@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com>; from manfred@colorfullife.com on Thu, May 31, 2001 at 10:21:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 10:21:55PM +0200, Manfred Spraul wrote:
> > 
> > I know that with MPS 1.4, the USB controller finds itself at an 
> > unshared interrupt 19. I can't reboot at the moment to check. 
> >
> lspci -vxxx -s 00:07.0
> 
> the APIC sits in the southbridge.
> the low 2 bits of offset 0x58 must be set [route USB IRQ to APIC], and 
> 
> lspci -vx -s 00:07.2
> 
> offset 0x3C must be set to 3 [19 & 15]
> 
> There was some discussion about the same problem with the sound part of
> the southbridge.
> 
> What are the current values of these registers?
> 
current, as in MPS 1.1:


00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
50: 02 76 04 00 00 f0 ab 50 1f 06 ff 08 00 00 00 00

I'd say the lower 2 bits at 0x58 are set.

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at a000 [size=32]
	Capabilities: [80] Power Management version 2
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

0x3X is at 5, not at 3.

Greetings,
Jurriaan
-- 
Endora is where we are, and you need to know that describing this place is
like dancing to no music.
	Peter Hedges - What's eating Gilbert Grape
GNU/Linux 2.4.5-ac4 SMP/ReiserFS 2x1402 bogomips load av: 0.02 0.01 0.00
