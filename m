Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291898AbSBIAZ7>; Fri, 8 Feb 2002 19:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIAZv>; Fri, 8 Feb 2002 19:25:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287279AbSBIAZn>;
	Fri, 8 Feb 2002 19:25:43 -0500
Message-ID: <3C646C85.D244BB44@mandrakesoft.com>
Date: Fri, 08 Feb 2002 19:25:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver merges
Content-Type: multipart/mixed;
 boundary="------------332E093425EA79245C0B60E5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------332E093425EA79245C0B60E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------332E093425EA79245C0B60E5
Content-Type: text/plain; charset=us-ascii;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"



Pull from:  http://gkernel.bkbits.net/net-drivers-2.5


---------------------------------------------------------------------------
ChangeSet@1.236, 2002-02-08 18:38:05-05:00, jgarzik@rum.normnet.org
  Update eepro100 net driver link state tracking:
  * Initialize interface carrier state in speedo_open.
  * Update previous netif_carrier_{on,off} change to use
    linux/mii.h constants.
  
  Contributor: Andrew Morton, with modifications from me

 eepro100.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)


ChangeSet@1.235, 2002-02-08 18:36:39-05:00, jgarzik@rum.normnet.org
  Fix natsemi net driver rx-related hang, by polling for RX events
  on all RX interrupts.  Prior to this fix, RX FIFO overrun and RX
  buffer overrun interrupts did not trigger an RX poll; now they do.
  
  Contributor: Manfred Spraul

 natsemi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.234, 2002-02-08 18:35:21-05:00, jgarzik@rum.normnet.org
  Update tulip net driver to indicate link beat to system,
  via netif_carrier_{on,off}.  Some placeholders to do this were
  already in the code, making this an even easier and more obvious patch.
  
  Also, decrease time until next link beat check, if link beat
  is not present.  (previously the code would wait 60 seconds until
  next check, regardless of current link state)
  
  Contributor: Stefan Rompf, with changes from me

 21142.c   |    9 +++++++--
 ChangeLog |   12 ++++++++++++
 timer.c   |   16 +++++++++-------
 3 files changed, 28 insertions(+), 9 deletions(-)


ChangeSet@1.233, 2002-02-08 18:32:41-05:00, jgarzik@rum.normnet.org
  tulip net driver updates:
  * Add support for Conexant tulip clones.
  * Do not store eeprom data on stack (128 or 512 bytes), it's a
  large object, and also, we already have a copy in kmalloc'd RAM.
  
  Contributor: Pavel Roskin

 ChangeLog    |   10 ++++++++++
 tulip.h      |    3 ++-
 tulip_core.c |   27 ++++++++++++++++++---------
 3 files changed, 30 insertions(+), 10 deletions(-)


ChangeSet@1.232, 2002-02-08 18:30:08-05:00, jgarzik@rum.normnet.org
  Fix naming conflict with pcnet32 net driver and ethtool,
  by cleaning up the pcnet32 namespace a bit.
    
  s/PORT_/PCNET32_PORT_/ for local constants, to avoid conflicting
  with linux/ethtool.h.
    
  Contributor: William Lee Irwin III

 pcnet32.c |   80 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 40 insertions(+), 40 deletions(-)


ChangeSet@1.231, 2002-02-08 18:27:49-05:00, jgarzik@rum.normnet.org
  Add config option to enable natsemi net driver hardware bug workaround.
  
  "some" systems with "some" cables see a large amount of errors,
  due to a hardware bug.  This bug is (apparently) not probe-able;
  however it only appears on rare reference boards and the like,
  so we simply add a config option and default the option to OFF.
  
  Further detail:
  When CONFIG_NATSEMI_CABLE_MAGIC option is enabled, PMDCSR_VAL
  register value becomes 0x1898, a value provided by a NatSemi
  app note.  This enables a workaround for a hardware bug
  which is (apparently) not probe-able.  Luckily the hardware bug
  is (apparently) not common either, so we default to disabling
  this workaround.
  
  Contributor: Tim Hockin

 Config.help |   11 +++++++++++
 Config.in   |    3 +++
 natsemi.c   |    4 ++++
 3 files changed, 18 insertions(+)


ChangeSet@1.230, 2002-02-08 18:23:41-05:00, jgarzik@rum.normnet.org
  Fix typo in the winbond-840 net driver which doubled
  the size of the Tx data buffer list without cause.
  Spotted by Dave Jones.

 winbond-840.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
---------------------------------------------------------------------------

--------------332E093425EA79245C0B60E5--

