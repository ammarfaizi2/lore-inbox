Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSL2XYL>; Sun, 29 Dec 2002 18:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSL2XYL>; Sun, 29 Dec 2002 18:24:11 -0500
Received: from mx2out.umbc.edu ([130.85.25.11]:52931 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S262208AbSL2XYK>;
	Sun, 29 Dec 2002 18:24:10 -0500
Date: Sun, 29 Dec 2002 18:32:31 -0500 (EST)
From: Stephen Brown <sbrown7@umbc.edu>
X-X-Sender: sbrown7@linux3.gl.umbc.edu
To: linux-kernel@vger.kernel.org
Subject: Micron Samurai chipset in 2.4.x (ide-pci.c)
Message-ID: <Pine.LNX.4.44L.01.0212291740470.13872-100000@linux3.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Avmilter-Status: Skipped (size)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	I recently put together a system based on an off-cast mobo from
a Micron Powerdigm XSU -- dual PII-266 and not much else.  Problem was
that most of the stock distros failed to boot the system at install.  To
make a long story short, the Samurai chipset's IDE controller is not
connected, and there is an Intel PIIX4 to handle the IDE chains --
unfortunately, both are seen by the PCI probing, and the kernel hangs
trying to figure out how to handle the Samurai piece.  I was able to get
the system to boot by unsetting CONFIG_BLOCK_DEV_IDEPCI, but that seemed
Draconian.  I am now happily running having changed line 290 in
linux/drivers/ide/ide-pci.c (kernel 2.4.20) from:
#define INIT_SAMURAI    NULL
to:
#define INIT_SAMURAI    IDE_IGNORE

	When I checked the changelogs for 2.4.21-pre2, I saw comments
that the pci subsystem had been reworked, so I tried that patch to no
avail -- kernel still hangs trying to probe the disconnected IDE
controller.  However, my workaround is no longer valid, since ide-pci.c
has been removed from the tree, and I haven't had the time yet to find
where that functionality now resides (it did seem weird finding all
those #defines in a .c instead of a .h).

	If anyone wants more info, I can post output from a serial
console during the unsuccessful boots, and try other investigations as
needed (at least until class starts again at the end of January).  I'm
not subscribed to this list (but will be checking the public archives
frequently) so send mail directly or cc:

Steve Brown
sbrown7@umbc.edu


