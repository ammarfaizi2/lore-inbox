Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWA1Pwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWA1Pwz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWA1Pwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:52:55 -0500
Received: from inutil.org ([193.22.164.111]:6072 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S1751447AbWA1Pwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:52:54 -0500
Date: Sat, 28 Jan 2006 16:52:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Display corruption with radeonfb after resuming from suspend-to-ram
Message-ID: <20060128155237.GA4601@informatik.uni-bremen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 82.83.220.218
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a hard-to-reproduce problem with radeonfb and suspend-to-ram:

I'm using radeonfb with fbcon in a pure console environment for most
os the time (with mplayer on X11 being the rare exception) and I
sometimes encounter display corruption after resuming from suspend to
RAM. My notebook is a ThinkPad X31 with this Radeon model:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 052f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at c0120000 [disabled] [size=128K]
        Capabilities: <available only to root>

Resuming from suspend-to-ram works flawless in roughly 98% of all cases, but
sometimes the display gets corrupted; some bits are set in the display in a
weird way and the display starts to shift with every line break. An example:

 $ foo
   $ foo
      $ foo

(The display wraps around on the after side for each line)

When running reset(1) the display returns to a state where the whole screen is shifted
to the left by two chars.

The last time the problem occured I started X11 to check, whether it is affected as well
and everything seemed alright expect a blocky area following the mouse cursor, but after
roughly 30 seconds the system locked up hard.

I cannot really reproduce it reliably, but if someone tells me which data I would
need to collect (a register dump or something similar?) I can send it the next time
the problem occurs.

This problem is not specific to the 2.6.15 kernel, it occured with several previous
kernels as well.

Cheers,
        Moritz
