Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbTC3IRc>; Sun, 30 Mar 2003 03:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263526AbTC3IRc>; Sun, 30 Mar 2003 03:17:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12051 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263524AbTC3IR3>; Sun, 30 Mar 2003 03:17:29 -0500
Date: Sun, 30 Mar 2003 09:28:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [BK PULL] PCMCIA updates
Message-ID: <20030330092846.B3375@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A gnu patch for this can be found at:

	http://patches.arm.linux.org.uk/pcmcia/20030330.diff

There's a few things outstanding from hch and Dominik, but this
provides a set of fixes, and allows the ARM SA11xx drivers to work
sanely with the recent pcmcia changes.

Please note: I don't mind if people pull this around the time of the
announcement.  However, some people have been regularly pulling from
them "just in case" there's changes.  Please do not indescriminately
pull from it without talking to myself first - these trees are *not*
separate from the ones I work in.  If people disregard this, I will
have to tweak my firewall appropriately, although I'd prefer not to.

----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----

From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [BK PULL] PCMCIA updates

Linus, please do a

	bk pull bk://bk.arm.linux.org.uk/linux-2.5-pcmcia

to include the latest ARM changes.  This will update the following files:

 drivers/pcmcia/Kconfig                 |   14 
 drivers/pcmcia/Makefile                |    4 
 drivers/pcmcia/cs.c                    |   72 +-
 drivers/pcmcia/cs_internal.h           |    1 
 drivers/pcmcia/ds.c                    |   19 
 drivers/pcmcia/hd64465_ss.c            |    2 
 drivers/pcmcia/i82092.c                |   17 
 drivers/pcmcia/i82365.c                |    2 
 drivers/pcmcia/pci_socket.c            |   15 
 drivers/pcmcia/sa1100.h                |   85 --
 drivers/pcmcia/sa1100_adsbitsy.c       |  127 +--
 drivers/pcmcia/sa1100_assabet.c        |  144 +---
 drivers/pcmcia/sa1100_badge4.c         |   69 --
 drivers/pcmcia/sa1100_cerf.c           |  157 +---
 drivers/pcmcia/sa1100_flexanet.c       |  227 ++----
 drivers/pcmcia/sa1100_freebird.c       |  193 ++---
 drivers/pcmcia/sa1100_generic.c        | 1122 +--------------------------------
 drivers/pcmcia/sa1100_generic.h        |   93 --
 drivers/pcmcia/sa1100_graphicsclient.c |  165 ++--
 drivers/pcmcia/sa1100_graphicsmaster.c |  111 +--
 drivers/pcmcia/sa1100_h3600.c          |  104 ---
 drivers/pcmcia/sa1100_jornada720.c     |   32 
 drivers/pcmcia/sa1100_neponset.c       |  122 +--
 drivers/pcmcia/sa1100_pangolin.c       |  176 ++---
 drivers/pcmcia/sa1100_pfs168.c         |   52 -
 drivers/pcmcia/sa1100_shannon.c        |   89 --
 drivers/pcmcia/sa1100_simpad.c         |  177 ++---
 drivers/pcmcia/sa1100_stork.c          |  108 +--
 drivers/pcmcia/sa1100_system3.c        |   39 -
 drivers/pcmcia/sa1100_trizeps.c        |  103 +--
 drivers/pcmcia/sa1100_xp860.c          |   47 -
 drivers/pcmcia/sa1100_yopy.c           |  106 ---
 drivers/pcmcia/sa1111_generic.c        |  179 +----
 drivers/pcmcia/sa1111_generic.h        |   16 
 drivers/pcmcia/sa11xx_core.c           | 1054 +++++++++++++++++++++++++++++++
 drivers/pcmcia/sa11xx_core.h           |  122 +++
 drivers/pcmcia/tcic.c                  |    7 
 drivers/serial/8250_cs.c               |   25 
 include/pcmcia/ss.h                    |    5 
 39 files changed, 2299 insertions, 2903 deletions

through these ChangeSets:

<rmk@flint.arm.linux.org.uk> (03/03/30 1.999)
	[PCMCIA] Reorganise SA11xx PCMCIA support.
	
	The SA1100 PCMCIA structure didn't lend itself well to the device
	model.  With this reorganisation, we end up with a reasonable
	structure which fits better with the driver model.  It is now
	obvious that SA11x0-based socket drivers are separate from
	SA1111-based socket drivers, and are treated as two separate drivers
	by the driver model.

<linux@de.rmk.(none)> (03/03/30 1.998)
	[PCMCIA] Fix "Removing wireless card triggers might_sleep warnings."
	
	Bug 516.
	
	Use schedule_delayed_work instead of a timer should fix this. Thanks
	to Andrew Morton and Russell King.
	
	(Added flush_scheduled_work() to ensure our delayed work completes
	before we free the pcmcia_bus_socket structure. --rmk)

<hch@de.rmk.(none)> (03/03/29 1.997)
	[SERIAL] switch over 8250_cs to pcmcia_register_driver

<linux@de.rmk.(none)> (03/03/28 1.996)
	[PCMCIA] don't inform "driver services" of cardbus-related events

<linux@de.rmk.(none)> (03/03/28 1.995)
	[PCMCIA] generic suspend/resume capability
	
	The socket drivers already offer suspend and resume
	capability. Integrate this with the driver model, based on a
	suggestion by Russell King.
	
	Also, remove two never-used functions from the socket drivers (to_ns).
	
	 drivers/pcmcia/cs.c             |   70 ++++++++++++++++++++--------------------
	 drivers/pcmcia/cs_internal.h    |    1
	 drivers/pcmcia/hd64465_ss.c     |    2 +
	 drivers/pcmcia/i82092.c         |   17 ++++++---
	 drivers/pcmcia/i82365.c         |    2 +
	 drivers/pcmcia/pci_socket.c     |   15 +-------
	 drivers/pcmcia/sa1100_generic.c |    2 +
	 drivers/pcmcia/sa1111_generic.c |   14 +-------
	 drivers/pcmcia/tcic.c           |    7 +---
	 include/pcmcia/ss.h             |    5 ++
	 10 files changed, 64 insertions(+), 71 deletions(-)


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

