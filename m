Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270228AbRHRPul>; Sat, 18 Aug 2001 11:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRHRPuW>; Sat, 18 Aug 2001 11:50:22 -0400
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:6670 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S270228AbRHRPuC>; Sat, 18 Aug 2001 11:50:02 -0400
Subject: Compaq Notebook 100, PCMCIA trouble in 2.4.x
To: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Date: Sat, 18 Aug 2001 17:49:20 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E15Y8Lg-0005jD-00@mm.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first I thought it was some APM BIOS bug, but strange things happen on
my Compaq Notebook 100 under 2.4.x (not 2.2.19) even without APM.

After the PCMCIA driver (yenta_socket) is loaded, the machine seems to
suddenly power off (or sometimes just turn off the backlight and lock up
hard with the HDD still spinning, then the power button has to be held
for a few seconds to power off) on anything that might have something to
do with the BIOS.  This includes rebooting, suspending, loading the APM
driver, running "apm" or "apmd" if APM was compiled in, etc.

Same problems with several kernels from 2.4.0 to 2.4.9, statically
compiled by me or completely modular packaged by Debian, always using
the PCMCIA drivers that came with the 2.4.x kernel.

No problems with kernel 2.2.19, pcmcia-cs 3.1.27, pcmcia-modules 3.1.25,
i82365 driver (there was no yenta_socket driver in 2.2.x, and the i82365
driver stopped detecting the "TI 1211 rev 00" under 2.4.x).

PLANET ENW-3503 PCMCIA LAN+modem card works fine under both 2.2.x and
2.4.x - but these power-offs under 2.4.x happen even if the card is not
plugged in and its drivers (pcnet_cs, serial_cs) are not loaded.

The yenta_socket driver does not have to be loaded at the time of the
crash or power-off, just loading and unloading it once is enough to later
cause "apm" or reboot to power off the machine, it's 100% reproducible.
This suggests that yenta_socket initialization might overwrite some BIOS
code in memory.  One more thing is that sometimes after such crash, the
RTC is off by a few hours (but minutes are correct).

I hope you find this bug report useful.  Thanks for any help.

	Marek

