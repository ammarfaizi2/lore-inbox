Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTLPGcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTLPGcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:32:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39134 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263660AbTLPGcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:32:39 -0500
Message-ID: <3FDEA6FA.4010906@pobox.com>
Date: Tue, 16 Dec 2003 01:32:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       davem@redhat.com
Subject: [BK PATCHES] 2.6.x experimental net driver updates
Content-Type: multipart/mixed;
 boundary="------------000800080303090907080207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000800080303090907080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Another edition of net driver updates.

Summary of new changes:
* revert skfddi janitorial patches.  no skfddi changes are included in 
this patchkit anymore.  Stephen Hemminger has a much better skfddi patch 
which obsoleted the already-merged skfddi changes.
* atmel wireless SKB leak fix
* 3c574_cs deadlock fix
* bonding destruction fix
* more work from Al making net_device allocation dynamic and sane 
(including fast, const-offset private structure allocation for drivers)
* sk98lin update from vendor
* TG3 update from DaveM
* new pc200syn WAN driver from WAN maintainer Krzysztof Halasa
* r8169 fixes from Francois Romieu


Summary of patchkit:
* new e100 driver (rewritten from scratch)
* new nVidia nForce NIC driver
* new pc200syn WAN driver

* tg3 bug fixes
* r8169 major bug fixes
* e1000 minor updates / fixes
* sk98lin vendor updates / fixes
* misc bug fixes

* 8139too NAPI support
* tulip NAPI support

* netconsole / netdump support
* net_device allocation and reference counting work


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp1.patch.bz2

Full changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp1.log

BK repo:
bk://gkernel.bkbits.net/net-drivers-2.5-exp

Changelog delta attached.


--------------000800080303090907080207
Content-Type: text/plain;
 name="2.6.0-test11-bk11-netdrvr-exp1.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.6.0-test11-bk11-netdrvr-exp1.txt"

ChangeSet@1.1548, 2003-12-16 01:13:32-05:00, jgarzik@redhat.com
  Cset exclude: shemminger@osdl.org|ChangeSet|20031029195339|20158
  
  Revert more skfddi stuff... better patch coming.

ChangeSet@1.1545, 2003-12-16 00:57:23-05:00, scott.feldman@intel.com
  [PATCH] ICH6 IDs + ia64 memcpy fix + module_param
  
  * Add ICH6 device IDs.  Devices funcionally equivalent to supported ICH5
    devices, but new IDs.
  * Fixed unaligned access to casted skb->data (Matt Willcox
    [willy@debian.org]).
  * MODULE_PARM -> module_param
  * Bug printk after register_netdev to identify nic details.
  * misc cleanups.

ChangeSet@1.1474.1.30, 2003-12-16 00:56:37-05:00, dtor_core@ameritech.net
  [PATCH] Fwd: Re: Atmel - possible SKB leak?
  
  Jeff,
  
  Atmel driver in 2.6.0-test11 is leaking SKBs if card gets disassociated
  from an AP when it's about to transfer packet. Simon (atmel maintainer)
  is OK with the patch. Given the fact that we are leaking memory I think
  it may be beneficial to push it to Linus (if you like the patch).
  
  Dmitry
  
  ===================================================================
  
  
  ChangeSet@1.1517, 2003-12-11 01:44:56-05:00, dtor_core@ameritech.net
    NET: atmel - do not leak SKBs when dropping packets
  
  
   atmel.c |    6 ++++--
   1 files changed, 4 insertions(+), 2 deletions(-)
  
  
  ===================================================================

ChangeSet@1.1474.1.29, 2003-12-16 00:52:31-05:00, akpm@osdl.org
  [PATCH] Re: Deadlock in 3c574_cs.c (fwd)
  
  Patch looks fine to me, thanks.   I've queued up the below.
  
  
  From: Ville Nuorvala <vnuorval@tcs.hut.fi>
  
  I've experienced random lockups witch become almost certain under heavy
  loads, like when doing ping6 -f. The culprit seems to be the 3c574_cs
  driver, which locks lp->window_lock twice when calling update_stats() from
  el3_interrupt().
  
  
  
   drivers/net/pcmcia/3c574_cs.c |   15 +++++++++------
   1 files changed, 9 insertions(+), 6 deletions(-)

ChangeSet@1.1543, 2003-12-16 00:47:59-05:00, jgarzik@redhat.com
  Cset exclude: felipewd@terra.com.br|ChangeSet|20031014182245|09592
  
  Revert skfddi request_region patch...  better patch coming.

ChangeSet@1.1541, 2003-12-16 00:25:32-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr axnet_cs] use embedded private struct

ChangeSet@1.1540, 2003-12-16 00:23:22-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [NET] s/kfree/free_netdev/ in bridge driver

ChangeSet@1.1474.1.27, 2003-12-16 00:16:23-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr bonding] use destructor to properly free net device
  
  (required because of driver's use of rtnl_lock/unlock)

ChangeSet@1.1539, 2003-12-16 00:14:52-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr 8390] convert 8390 lib to use const-offset priv struct

ChangeSet@1.1538, 2003-12-16 00:14:01-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr pcnet_cs] alloc_ei_netdev-associated cleanups
  
  Create __alloc_ei_netdev() helper, which takes a size argument for
  allocation of driver-private structures.
  
  Use __alloc_ei_netdev in pcnet_cs, for embedded priv struct.

ChangeSet@1.1537, 2003-12-16 00:10:35-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr smc-mca] alloc_ei_netdev(), other fixes
  
  Move all initialization between alloc_ei_netdev() and register_netdev(),
  and fix bugs on error paths.  Also s/kfree/free_netdev/

ChangeSet@1.1536, 2003-12-16 00:08:57-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr] convert most 8390 drivers to using alloc_ei_netdev()

ChangeSet@1.1535, 2003-12-16 00:03:04-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [wireless wl3501_cs] remove unused constructor

ChangeSet@1.1534, 2003-12-16 00:02:37-05:00, viro@parcelfarce.linux.theplanet.co.uk
  [netdrvr] s/kfree/free_netdev/ where appropriate
  
  Affected drivers:  ixgb, sk98lin, ibmtr, airport, orinoco, wl3501_cs

ChangeSet@1.1533, 2003-12-15 23:55:18-05:00, mlindner@syskonnect.de
  [PATCH] sk98lin-2.6: pci.ids Update to Driver Version v6.21
  
  Patch 4/4 (Update to version 6.21)
  * Add: Update of the Vendors list

ChangeSet@1.1532, 2003-12-15 23:54:52-05:00, mlindner@syskonnect.de
  [PATCH] sk98lin-2.6: Kconfig Update to Driver Version v6.21
  
  Patch 3/4 (Update to version 6.21)
  * Add: Update of the Vendors list

ChangeSet@1.1531, 2003-12-15 23:54:31-05:00, mlindner@syskonnect.de
  [PATCH] sk98lin-2.6: Readme Update to Driver Version v6.21
  
  Patch 2/4 (Update to version 6.21)
  * Fix: Readme changes

ChangeSet@1.1530, 2003-12-15 23:54:21-05:00, mlindner@syskonnect.de
  [PATCH] sk98lin-2.6: Kernel Update to Driver Version v6.21
  
  Patch 1/4 (Update to version 6.21)
  * Add: Common module update
  * Add: New function for PCI initialization (SkGeInitPCI)
  * Add: Yukon Plus changes (ChipID, PCI...)
  * Add: Code for DIAG tool
  * Fix: Problems while unloading the linux driver
  * Fix: PrefPort=B not allowed on single NICs
  * Fix: Fixed Linux System crash when using vlans
  * Fix: Remove useless register_netdev
  * Fix: Initalize Board before network configuration
  * Fix: Modifications regarding try_module_get() and capable()

ChangeSet@1.1474.12.6, 2003-12-08 21:54:23-08:00, xose@wanadoo.es
  [TG3]: Add new device IDs.

ChangeSet@1.1529, 2003-12-07 19:17:51-05:00, khc@pm.waw.pl
  [wan] add new pc200syn driver

ChangeSet@1.1528, 2003-12-07 19:00:04-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Stats fix (Fernando Alencar Marótica <famarost@unimep.br>).

ChangeSet@1.1527, 2003-12-07 18:59:29-05:00, romieu@fr.zoreil.com
  [netdrvr r8169] Endianness update (original idea from Alexandra N. Kossovsky):
  - descriptors status (bitfields enumerated as _DescStatusBit);
  - address of buffers stored in Rx/Tx descriptors.

ChangeSet@1.1474.12.5, 2003-12-02 19:42:50-08:00, davem@nuts.ninka.net
  [TG3]: Update to latest non-5705 TSO firmware.

ChangeSet@1.1474.12.4, 2003-12-02 02:35:21-08:00, davem@nuts.ninka.net
  [TG3]: Update version and release date.

ChangeSet@1.1474.12.3, 2003-12-02 02:34:45-08:00, davem@nuts.ninka.net
  [TG3]: Clear on-chip stats/status block after resetting flow-through queues.
  
  On systems where the config cycles might take a long time, we
  can end up with the ASF firmware using the FTQs before we get
  to resetting them.

ChangeSet@1.1474.12.2, 2003-12-02 02:34:13-08:00, davem@nuts.ninka.net
  [TG3]: Do not set RX_MODE_KEEP_VLAN_TAG when ASF is enabled.

ChangeSet@1.1474.12.1, 2003-12-02 02:33:45-08:00, davem@nuts.ninka.net
  [TG3]: Do not drop existing GRC_MODE_HOST_STACKUP when writing to GRC_MODE.


--------------000800080303090907080207--

