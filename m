Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSLCTLE>; Tue, 3 Dec 2002 14:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSLCTLE>; Tue, 3 Dec 2002 14:11:04 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:28381 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265477AbSLCTK5>; Tue, 3 Dec 2002 14:10:57 -0500
Message-Id: <5.1.0.14.2.20021203110038.07db0e08@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Dec 2002 11:18:04 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] 2.4.x Bluetooth updates and fixes
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, 

I've got whole bunch of Bluetooth fixes and updates for you.

Please from
        bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 Documentation/Configure.help     |   56 +
 drivers/bluetooth/Config.in      |    9
 drivers/bluetooth/Makefile       |   10
 drivers/bluetooth/btuart_cs.c    |  906 +++++++++++++++++++
 drivers/bluetooth/hci_bcsp.c     |  710 +++++++++++++++
 drivers/bluetooth/hci_bcsp.h     |   70 +
 drivers/bluetooth/hci_h4.c       |   85 -
 drivers/bluetooth/hci_h4.h       |    3
 drivers/bluetooth/hci_ldisc.c    |  354 ++++---
 drivers/bluetooth/hci_uart.h     |   39
 drivers/bluetooth/hci_usb.c      |    4
 include/net/bluetooth/hci.h      |    5
 include/net/bluetooth/hci_core.h |    2
 include/net/bluetooth/rfcomm.h   |  346 +++++++
 net/bluetooth/Config.in          |    5
 net/bluetooth/Makefile           |    8
 net/bluetooth/bnep/Config.in     |    9
 net/bluetooth/bnep/Makefile      |    2
 net/bluetooth/bnep/core.c        |  114 +-
 net/bluetooth/bnep/netdev.c      |   24
 net/bluetooth/bnep/sock.c        |    2
 net/bluetooth/hci_core.c         |   20
 net/bluetooth/l2cap.c            |  122 +-
 net/bluetooth/rfcomm/Config.in   |   10
 net/bluetooth/rfcomm/Makefile    |   13
 net/bluetooth/rfcomm/core.c      | 1807 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/rfcomm/crc.c       |   71 +
 net/bluetooth/rfcomm/sock.c      |  840 ++++++++++++++++++
 net/bluetooth/rfcomm/tty.c       |  951 ++++++++++++++++++++
 net/bluetooth/syms.c             |    3
 30 files changed, 6216 insertions(+), 384 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/12/02 1.776)
   BNEP extension headers handling fix.

<maxk@qualcomm.com> (02/12/02 1.775)
   Ordinary users are not allowed to use raw L2CAP sockets.

<marcel@holtmann.org> (02/11/29 1.769.1.1)
   [Bluetooth] Don't use %d notation for non devfs name field of tty_driver

   This patch removes the misplaced %d in the name field of the tty_driver
   structure if devfs is not used.

<maxk@qualcomm.com> (02/11/22 1.771)
   Fix hci_dev_get_list() for big endian machines.
   It has to use sizeof() of the actual structure
   instead of sizeof(__u16).

<maxk@qualcomm.com> (02/11/22 1.770)
   Fix L2CAP client/server PSM clash.

<marcel@holtmann.org[holtmann]> (02/11/18 1.768)
   [Bluetooth] Add BCSP TXCRC option

   This patch adds the config and help entries for the TXCRC option
   of the BCSP driver.

<marcel@holtmann.org> (02/11/18 1.767)
   [Bluetooth] The function l2cap_do_connect() should be static

   This patch replaces l2cap_connect() with l2cap_do_connect() and
   declares it static.

<marcel@holtmann.org> (02/11/12 1.765)
   [Bluetooth] Update help entry for CONFIG_BLUEZ

   This adds the two new protocols RFCOMM and BNEP to the list of
   Bluetooth modules in the help text for CONFIG_BLUEZ.

<marcel@holtmann.org> (02/11/09 1.764)
   [Bluetooth] Fix another operator precedence for modem status

   This patch puts the needed parentheses around the modem status to
   make it work correctly.

<marcel@holtmann.org> (02/11/05 1.763)
   [Bluetooth] Free skbs with kfree_skb() instead of kfree()

   This patch makes sure that the freeing of skbs is done with kfree_skb().

<marcel@holtmann.org> (02/10/27 1.737.9.14)
   [Bluetooth] Fix some bits of the modem status handling

   This fixes the wrong parameter order for the rfcomm_send_msc()
   command in rfcomm_process_tx() and adds an empty RFCOMM_NSC case
   for ignoring NSC control frames.

<maxk@qualcomm.com> (02/10/26 1.760)
   Fix typo in hci_usb_open() (MAX_BULK_TX -> MAX_BULK_RX)

<maxk@qualcomm.com> (02/10/23 1.737.10.3)
   HCI UART fixes
   - Don't do tx wakeup if protocol is not set.

<maxk@qualcomm.com> (02/10/23 1.737.10.2)
   BNEP fixes
   - Don't forget to initialize hw broadcast to make sure that mc filter
     is properly initialized.

<maxk@qualcomm.com> (02/10/23 1.737.10.1)
   RFCOMM TTY fixes
   - Fix operator precedence in modem_status code.
   - Check for signals while waiting for DLC to connect.

<marcel@holtmann.org> (02/10/21 1.737.9.9)
   [Bluetooth] Cosmetic changes to the config files

   This patch makes some cosmetic changes to the config files of the
   Bluetooth subsystem.

<marcel@holtmann.org> (02/10/21 1.737.9.8)
   [Bluetooth] Fix typo in role change event size

   This patch fixes a silly typo in the role change event size.

<marcel@holtmann.org> (02/10/21 1.737.9.7)
   [Bluetooth] Support for suspend/resume interface for HCI devices

   This adds support for suspend/resume interface for use in the HCI
   device drivers.

<marcel@holtmann.org> (02/10/21 1.737.9.6)
   [Bluetooth] Add HCI id for Bluetooth PCI cards

   This is a simple oneline patch which only assigns the next free
   HCI id to Bluetooth devices that are based on PCI.

<marcel@holtmann.org[holtmann]> (02/10/20 1.737.9.5)
   [Bluetooth] Add HCI UART PC Card driver

   This adds the HCI UART PC Card driver for Bluetooth PCMCIA devices
   with an UART interface.

<marcel@holtmann.org> (02/10/20 1.737.9.4)
   [Bluetooth] Config cleanup for BNEP

   This patch cleans up the config files to have a unique CONFIG_BLUEZ
   prefix. Additional two missing help entries are added.

<marcel@holtmann.org[holtmann]> (02/10/20 1.737.9.3)
   [Bluetooth] UART driver update

   This updates the HCI UART driver and adds support for the
   BlueCore Serial Protocol (BCSP).

<marcel@holtmann.org> (02/10/20 1.737.9.2)
   [Bluetooth] Module description cleanup for BNEP

   This patch modifies the module description and make it common with the
   rest of the Bluetooth subsystem.

<marcel@holtmann.org[holtmann]> (02/10/20 1.737.9.1)
   [Bluetooth] Add RFCOMM protocol support

   This adds the RFCOMM protocol to the Bluetooth subsystem.




Max

http://bluez.sf.net
http://vtun.sf.net

