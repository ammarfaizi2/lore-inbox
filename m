Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTLGUg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTLGUg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:36:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46976 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264504AbTLGUgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:36:21 -0500
Message-ID: <3FD38F39.5070801@pobox.com>
Date: Sun, 07 Dec 2003 15:36:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [BK PATCHES] 2.6.x experimental net driver queue
Content-Type: multipart/mixed;
 boundary="------------070501080508050700070805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501080508050700070805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Another installment in the net-drivers-2.5-exp queue patchkit.

Summary of new changes:
* r8169 bug fixing (Francois Romieu, RealTek, others)
* Make dev->priv calculation a compile-time constant (eliminates extra 
dereference) (Al Viro)
* More netdev allocation work (Al Viro)
* airo fixes (Javier)
* 8139too minor fixes (OGAWA Hirofumi)
* new nVidia nForce NIC driver "forcedeth" (Manfred Spraul)
* misc net driver fixes/cleanups (Stephen Hemminger)


Summary of patchkit:
* e100 driver rewrite
* new nVidia nForce NIC driver
* r8169 bug fixing
* 8139too NAPI support
* tulip NAPI support
* netconsole / netdump support
* net_device allocation and reference counting work
* e1000 minor updates
* misc bug fixes


Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk5-netdrvr-exp1.patch.bz2

Full changelog:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk5-netdrvr-exp1.log

BK repo:
http://gkernel.bkbits.net/net-drivers-2.5-exp

Changelog delta attached.


--------------070501080508050700070805
Content-Type: text/plain;
 name="2.6.0-test11-bk5-netdrvr-exp1.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.6.0-test11-bk5-netdrvr-exp1.txt"

ChangeSet@1.1526, 2003-12-07 14:01:09-05:00, jgarzik@redhat.com
  Merge redhat.com:/spare/repo/net-drivers-2.5
  into redhat.com:/spare/repo/net-drivers-2.5-exp

ChangeSet@1.1474.1.26, 2003-12-07 13:58:53-05:00, jgarzik@redhat.com
  Merge redhat.com:/spare/repo/linux-2.5
  into redhat.com:/spare/repo/net-drivers-2.5

ChangeSet@1.1525, 2003-12-07 13:50:47-05:00, shemminger@osdl.org
  [PATCH] pc300 - get rid of MOD_INC/MOD_DEC
  
  Remove old style mod inc/dec from this WAN driver.

ChangeSet@1.1524, 2003-12-07 13:49:20-05:00, shemminger@osdl.org
  [PATCH] get rid of MOD INC/DEC for farsync
  
  Get rid of leftover MOD INC/DEC in this driver.  Ref counting now done
  by network core.
  
  Jeff, please apply to net-drivers-2.5-exp

ChangeSet@1.1523, 2003-12-07 13:45:51-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [atm clip] convert to using alloc_netdev(), const-offset priv

ChangeSet@1.1522, 2003-12-07 13:42:37-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [pcmcia] synclink_cs] convert net_device to dynamic allocation

ChangeSet@1.1521, 2003-12-07 13:42:04-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [char synclinkmp] convert net_device to dynamic allocation

ChangeSet@1.1520, 2003-12-07 13:40:52-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [hamradio dmascc] convert embedded net_device to dynamic allocation

ChangeSet@1.1519, 2003-12-07 13:39:29-05:00, viro@parcelfarce.linux.theplanet.co.uk
  net_device and netdev private struct allocation improvements.
  
  1) Ensure alignment of both net_device and private area.
  2) Introduce netdev_priv(), an inline which allows the dynamic private
     area (dev->priv) to be calculated as a constant offset from the
     base struct net_device at compile time.

ChangeSet@1.1518, 2003-12-07 13:21:55-05:00, achirica@telefonica.net
  [wireless airo] Delay MIC activation to prevent Oops

ChangeSet@1.1517, 2003-12-07 13:21:47-05:00, achirica@telefonica.net
  [wireless airo] Fix PCI registration

ChangeSet@1.1516, 2003-12-07 13:18:43-05:00, hirofumi@mail.parknet.co.jp
  [PATCH] 8139too tx queue handling fix
  
  Hi,
  
  	netif_stop_queue(dev);
  	[....]
  	netif_start_queue(dev);
  	netif_wake_queue(dev);
  and
  	netif_stop_queue(dev);
  	[....]
  	netif_wake_queue(dev);
  
  is not same. After tx_timeout, this was needed for restarting tx work
  immediately.
  
  Are you interested in this patch?
  
   drivers/net/8139too.c |    3 +--
   1 files changed, 1 insertion(+), 2 deletions(-)

ChangeSet@1.1515, 2003-12-07 13:18:34-05:00, hirofumi@mail.parknet.co.jp
  [PATCH] 8139too warning fix (1/2)
  
   drivers/net/8139too.c |    2 ++
   1 files changed, 2 insertions(+)

ChangeSet@1.1514, 2003-12-07 13:13:24-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] fix RX
  
  Brown paper bag time: the Rx descriptors are contiguous and EORbit only
  marks the last descriptor in the array. OWNbit implicitly marks the end
  of the Rx descriptors segment which is owned by the nic.

ChangeSet@1.1513, 2003-12-07 13:12:27-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Suspend/resume code (Fernando Alencar Marótica).

ChangeSet@1.1512, 2003-12-07 13:11:46-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Modification of the interrupt mask (RealTek).

ChangeSet@1.1511, 2003-12-07 13:10:49-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Driver forgot to update the transmitted bytes counter.
  Originally done in rtl8169_start_xmit() by Realtek.

ChangeSet@1.1510, 2003-12-07 13:10:04-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Merge of changes from Realtek:
  - register voodoo in rtl8169_hw_start().

ChangeSet@1.1509, 2003-12-07 13:08:55-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Merge of timer related changes from Realtek:
  - changed their timeout value from 100 to HZ to trigger rtl8169_phy_timer();
  - s/TX_TIMEOUT/RTL8169_TX_TIMEOUT/ to have RTL8169_{TX/PHY}_TIMEOUT.

ChangeSet@1.1508, 2003-12-07 13:07:25-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Merge of changes done by Realtek to rtl8169_init_one():
  - phy capability settings allows lower or equal capability as suggested
    in Realtek's changes;
  - I/O voodoo;
  - no need to s/mdio_write/RTL8169_WRITE_GMII_REG/;
  - s/rtl8169_hw_PHY_config/rtl8169_hw_phy_config/;
  - rtl8169_hw_phy_config(): ad-hoc struct "phy_magic" to limit duplication
    of code (yep, the u16 -> int conversions should work as expected);
  - variable renames and whitepace changes ignored.

ChangeSet@1.1507, 2003-12-07 13:05:55-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Add {mac/phy}_version.
  - change of identification logic in rtl8169_init_board();
  - {chip/rtl_chip}_info are merged in rtl_chip_info;
  - misc style nits (lazy braces, SHOUTING MACROS from realtek converted to
    functions).

ChangeSet@1.1506, 2003-12-07 12:58:13-05:00, manfred@colorfullife.com
  [netdrvr] add "forcedeth" driver for nVidia nForce NICs

--------------070501080508050700070805--

