Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSFZViO>; Wed, 26 Jun 2002 17:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFZViO>; Wed, 26 Jun 2002 17:38:14 -0400
Received: from stateless2.tiscali.cz ([213.235.135.71]:18379 "EHLO
	mail.tiscali.cz") by vger.kernel.org with ESMTP id <S316659AbSFZViN>;
	Wed, 26 Jun 2002 17:38:13 -0400
Date: Wed, 26 Jun 2002 23:27:00 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: linux-kernel@vger.kernel.org
Subject: another way to activate AMD disconnect on VIA KT266 (aka cooling bits)
Message-ID: <20020626212659.GA3565@utx.vol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have been experimenting with AMD disconnect with my VIA KT266 based
MSI K7T266Pro (MS-6380).

LVCool does not yet support KT266, method discussed in LKML in past
(http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html)
does not activate low power mode on my mainboard. The only bit set by
this patch is already set probably by BIOS of my motherboard and does
not help. So I have checked VCool (http://vcool.occludo.net/) & Wine &
lspci and found following bit changes:

enable:
setpci -v -H1 -s 0:0.0 70=86
setpci -v -H1 -s 0:0.0 95=1e
disable:
setpci -v -H1 -s 0:0.0 70=82
setpci -v -H1 -s 0:0.0 95=1c

The result is 15 degrees temperature decrease on low system load!

I don't know exactly, what I am doing (and chipset docs are not
available), explanation is welcome, (un)success stories for other
motherboards too.

It works with both APM and ACPI.


Stability issues:

Allthrough I have experienced visible unstability of video voltage
(unstability of white on PCI video card) on periodic high load
(e. g. software OpenGL screensaver), the machine seems to be stable
for one week. No sound skips nor DMA slowdown was observed.

For unknown reasons, the system is stable only for whole number in
processor multiplier. For half-number multiplier system sometimes
crashes.


Notes:

1)
I have no feedback from VCool author (Martin Peters <mpet@bigfoot.de>).

2)
The method discussed in past
(by Daniel Nofftz <nofftz@castor.uni-trier.de>), which should work with
ACPI (but not for me) is:

VIA KT133/133A a KX133:
enable: setpci -v -H1 -s 0:0.0 52=EB
disable: setpci -v -H1 -s 0:0.0 52=6B

VIA KT266/266A:
enable: setpci -v -H1 -s 0:0.0 92=EB
disable: setpci -v -H1 -s 0:0.0 92=6B

3)
You can see also Fan Speed Control Daemon (stupid AWK script, but working):
http://www.penguin.cz/~utx/fanscd

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
