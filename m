Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbTACXxv>; Fri, 3 Jan 2003 18:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTACXxv>; Fri, 3 Jan 2003 18:53:51 -0500
Received: from havoc.daloft.com ([64.213.145.173]:43680 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267727AbTACXxr>;
	Fri, 3 Jan 2003 18:53:47 -0500
Date: Fri, 3 Jan 2003 19:02:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver merges
Message-ID: <20030104000211.GA32508@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More to come, this is just today's batch :)

The crc32 cset fixes an ugly bug that's been there since crc32 was
originally merged.  I guess nobody uses multicast, because nearly every
net driver's multicast was broken due to broken ether_crc() function
until right now.  Good spotting on Manfred's part.




Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/Kconfig               |   14 
 drivers/net/Makefile              |    1 
 drivers/net/Makefile.lib          |    1 
 drivers/net/amd8111e.c            | 1651 ++++++++++++++++++++++++++++++++++++++
 drivers/net/amd8111e.h            |  786 ++++++++++++++++++
 drivers/net/e100/e100.h           |   13 
 drivers/net/e100/e100_config.c    |   16 
 drivers/net/e100/e100_main.c      |  371 ++++----
 drivers/net/e100/e100_test.c      |   26 
 drivers/net/e1000/e1000.h         |    1 
 drivers/net/e1000/e1000_ethtool.c |   22 
 drivers/net/e1000/e1000_main.c    |   83 +
 drivers/net/e1000/e1000_osdep.h   |    2 
 drivers/net/e1000/e1000_param.c   |   25 
 drivers/net/e1000/e1000_proc.c    |   24 
 drivers/net/eepro100.c            |    1 
 drivers/net/mii.c                 |    8 
 drivers/net/natsemi.c             |   44 -
 drivers/net/tulip/de4x5.c         |    1 
 include/linux/crc32.h             |   12 
 lib/crc32.c                       |   21 
 21 files changed, 2815 insertions(+), 308 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/01/03 1.962.1.14)
   [netdrvr amd8111e] add to drivers/net/Makefile.lib too, as it uses crc32

<jgarzik@redhat.com> (03/01/03 1.962.1.13)
   [netdrvr e100] changelog/whitespace updates, small fixes:
   * Updated change log
   * Spelling corections
   * Bug fix: remove confusing sign-on message that's printed when no link
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.12)
   [netdrvr e100] better debugging for command failures/timeouts
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.11)
   [netdrvr] ethernet crc fixes
   * ether_crc has always been wrong in 2.5.x. ug. we want
     bitreverse crc32_le instead
   * use ether_crc in natsemi

<jgarzik@redhat.com> (03/01/03 1.962.1.10)
   [netdrvr e100] fix ethtool/mii interface up/down issues:
   * Bug fix: Not able to set autoneg on using ethtool when interface
     down, Not able to change speed/duplex using ethtool/mii when interface
     up, Ethtool shows autoneg on when forced to 100/Full
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.9)
   [netdrvr e100] Bug fix: enable/disable WOL based on EEPROM settings
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.8)
   [netdrvr e100] Bug fix: system panic in watchdog when repeating ifdown, rmmod, insmod
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.7)
   [netdrvr e1000] small cleanups and fixes:
   * Update change log
   * Whitespace cleanup
   * Bug fix: protect against zero-length skb in hard_start
   * Bug fix: validate MAC address using is_valid_ether_addr()
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.6)
   [netdrvr e1000] restore VLAN settings after resume
   
   Contributed by Scott Feldman @ Intel.

<jgarzik@redhat.com> (03/01/03 1.962.1.5)
   [netdrver e1000] wol updates:
   * Get WOL settings from EEPROM
   * Remove PHY WOL support as device downshofts from 1GbE to 10/100 during
     suspend, which causes a PHY event, which causes the system to wake up!
     The downshifting to 10/100 is to reduce power.
   
   Contributed by Scott Feldman @ Intel

<jgarzik@redhat.com> (03/01/03 1.962.1.4)
   [netdrvr de4x5] fix uninitializer timer
   
   Contributed by Richard Henderson

<jgarzik@redhat.com> (03/01/03 1.962.1.3)
   [netdrvr eepro100] new pci id
   
   Contributed by Jonathan Shapiro

<jgarzik@redhat.com> (03/01/03 1.962.1.2)
   [netdrvr] add AMD-8111 ethernet driver (yet another PCI lance)

<jgarzik@redhat.com> (03/01/03 1.962.1.1)
   [netdrvr mii] fix ugly lack of useful bit masking
   
   Found by Ion Badulescu.

