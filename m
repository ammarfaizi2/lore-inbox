Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263385AbTC2FfI>; Sat, 29 Mar 2003 00:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263386AbTC2FfI>; Sat, 29 Mar 2003 00:35:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263385AbTC2FfG>;
	Sat, 29 Mar 2003 00:35:06 -0500
Message-ID: <3E85334A.9010303@pobox.com>
Date: Sat, 29 Mar 2003 00:46:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver merges
Content-Type: multipart/mixed;
 boundary="------------070505070003030807080003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505070003030807080003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

nothing terribly interesting

--------------070505070003030807080003
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 Documentation/networking/bonding.txt |  142 ++++++--
 drivers/net/3c509.c                  |    2 
 drivers/net/bonding.c                |  581 ++++++++++++++++++++---------------
 drivers/net/gt96100eth.c             |   17 -
 drivers/net/mace.c                   |   36 +-
 drivers/net/r8169.c                  |    2 
 drivers/net/tulip/de4x5.c            |    1 
 drivers/net/tulip/dmfe.c             |    6 
 include/linux/if_bonding.h           |    9 
 9 files changed, 491 insertions(+), 305 deletions(-)

through these ChangeSets:

<mbligh@aracnet.com> (03/03/29 1.1029)
   [PATCH] remove warning for 3c509.c
   
   Get this compile warning:
   drivers/net/3c509.c:207: warning: `el3_device_remove' declared `static' but never defined
   because the function definition is under
   "#if defined(CONFIG_EISA) || defined(CONFIG_MCA)".
   
   This patch puts the declaration under the same conditions.
   I'd be shocked if it wasn't correct ;-)
   
   M.

<paulus@samba.org> (03/03/29 1.1028)
   [PATCH] MACE ethernet driver update
   
   This patch updates the MACE ethernet driver, used on older powermacs,
   to remove the uses of save_flags/restore_flags/cli/sti and use a
   spinlock instead.
   
   Jeff, please send this on to Linus.
   
   Paul.

<davej@codemonkey.org.uk> (03/03/29 1.1027)
   [PATCH] finish init_etherdev conversion for gt96100eth
   
   - No need to alloc dev->priv (due to init_etherdev usage)
   - No need to kfree dev->priv (kfree'd with (dev) already)

<bunk@fs.tum.de> (03/03/29 1.1026)
   [PATCH] fix .text.exit error in drivers/net/r8169.c
   
   In drivers/net/r8169.c the function rtl8169_remove_one is __devexit but
   the pointer to it didn't use __devexit_p resulting in a.text.exit
   compile error when !CONFIG_HOTPLUG.
   
   The fix is simple:

<fubar@us.ibm.com> (03/03/29 1.1025)
   [bonding] bug fixes, and a few minor feature additions
   
   Mainly sync w/ 2.4.x version.

<davej@codemonkey.org.uk> (03/03/29 1.1024)
   [tulip dmfe] add pci id

<bwindle@fint.org> (03/03/28 1.1023)
   [tulip] remove unnecessary linux/version.h includes


--------------070505070003030807080003--

