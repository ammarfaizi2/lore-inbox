Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTBTUH0>; Thu, 20 Feb 2003 15:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBTUH0>; Thu, 20 Feb 2003 15:07:26 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:43408 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262806AbTBTUHU>; Thu, 20 Feb 2003 15:07:20 -0500
Message-Id: <5.1.0.14.2.20030220121107.0cfd42e0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 12:17:18 -0800
To: Linus Torvalds <torvalds@transmeta.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates for 2.5.62
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

Here is the next round of Bluetooth updates.

Please pull from
        bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 arch/sparc64/kernel/ioctl32.c    |   37 +
 drivers/bluetooth/Kconfig        |   56 +-
 drivers/bluetooth/Makefile       |    1 
 drivers/bluetooth/bluecard_cs.c  |    7 
 drivers/bluetooth/bt3c_cs.c      |    7 
 drivers/bluetooth/btuart_cs.c    |  915 ++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/dtl1_cs.c      |    7 
 drivers/bluetooth/hci_h4.c       |    1 
 drivers/bluetooth/hci_ldisc.c    |   14 
 drivers/bluetooth/hci_uart.h     |    2 
 drivers/bluetooth/hci_usb.c      |   11 
 drivers/bluetooth/hci_vhci.c     |    5 
 include/net/bluetooth/hci.h      |   50 +-
 include/net/bluetooth/hci_core.h |   29 +
 include/net/bluetooth/l2cap.h    |    2 
 net/bluetooth/Kconfig            |   14 
 net/bluetooth/af_bluetooth.c     |    4 
 net/bluetooth/bnep/Kconfig       |    4 
 net/bluetooth/bnep/bnep.h        |   30 -
 net/bluetooth/bnep/core.c        |   72 +--
 net/bluetooth/bnep/sock.c        |   24 -
 net/bluetooth/hci_conn.c         |    5 
 net/bluetooth/hci_core.c         |   71 ---
 net/bluetooth/hci_proc.c         |    6 
 net/bluetooth/hci_sock.c         |   58 +-
 net/bluetooth/l2cap.c            |  138 +++--
 net/bluetooth/rfcomm/Kconfig     |    2 
 net/bluetooth/rfcomm/core.c      |   53 +-
 net/bluetooth/rfcomm/sock.c      |   20 
 net/bluetooth/rfcomm/tty.c       |   31 -
 net/bluetooth/sco.c              |   15 
 net/bluetooth/syms.c             |    2 
 32 files changed, 1330 insertions(+), 363 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/02/19 1.994)
   [Bluetooth] 
   Cleanup and fix __init and __exit functions.
   /proc/bluetooth initialization fixes.

<marcel@holtmann.org> (03/02/09 1.879.85.4)
   [Bluetooth] Get rid of hci_send_raw()
   
   This patch removes the function hci_send_raw() and puts all its
   logic directly into hci_sock_sendmsg().

<marcel@holtmann.org> (03/01/22 1.879.85.3)
   [Bluetooth] Disable HCI flow control for vendor commands
   
   This patch disables the use of HCI flow control for vendor
   commands. All vendor commands will be queued to hdev->raw_q
   instead of hdev->cmd_q.

<marcel@holtmann.org> (03/01/17 1.879.85.2)
   [Bluetooth] Remove wrong check for size value in rfcomm_wmalloc()
   
   This patch removes the wrong and not need check for the size value
   in the function rfcomm_wmalloc(). The check is not needed because
   it will be always called with a minimum value of RFCOMM_SKB_RESERVE.

<maxk@qualcomm.com> (02/12/26 1.838.106.4)
   Kill old BNEP ioctls.

<maxk@qualcomm.com> (02/12/26 1.838.106.3)
   arch/sparc64/ioctl32.c 
   Put Bluetooth ioctls at the end, right before the translation table.

<maxk@qualcomm.com> (02/12/17 1.838.56.2)
   Convert Bluetooth HCI devices to new module refcounting.

<marcel@holtmann.org> (02/12/17 1.838.55.4)
   [Bluetooth] Replace info message about SCO MTU with BT_DBG
   
   This patch replaces one BT_INFO with BT_DBG. With this change the
   use of getsockopt() don't pollute the kernel log with the info about
   the SCO MTU if debugging is disabled.

<marcel@holtmann.org> (02/12/17 1.838.55.3)
   [Bluetooth] Make READ_VOICE_SETTING available for normal users
   
   This makes the HCI command READ_VOICE_SETTING available for normal
   users.

<marcel@holtmann.org> (02/12/15 1.838.22.3)
   [Bluetooth] Add some COMPATIBLE_IOCTL for SPARC64
   
   This patch adds the needed COMPATIBLE_IOCTL for SPARC64 to let
   the HCIUART, RFCOMM and BNEP part of the Bluetooth subsystem
   work correctly on this architecture.

<marcel@holtmann.org> (02/12/11 1.838.22.2)
   [Bluetooth] Convert dlci and channel variables to u8
   
   This patch converts all left over dlci and channel variables of
   the RFCOMM code from int to u8.

<maxk@qualcomm.com> (02/12/06 1.831.17.1)
   Remove duplicated include in HCI H4 driver.

<maxk@qualcomm.com> (02/12/02 1.797.221.2)
   BNEP extension headers handling fix.

<maxk@qualcomm.com> (02/12/02 1.797.221.1)
   Ordinary users are not allowed to use raw L2CAP sockets.

<marcel@holtmann.org> (02/11/30 1.797.195.4)
   [Bluetooth] Another cleanup of the Kconfig files
   
   This patch makes some left over corrections to the Kconfig files.

<marcel@holtmann.org> (02/11/29 1.797.195.3)
   [Bluetooth] Don't use %d notation for non devfs name field of tty_driver
   
   This patch removes the misplaced %d in the name field of the tty_driver
   structure if devfs is not used.

<maxk@qualcomm.com> (02/11/22 1.797.136.2)
   Fix hci_get_dev_list() for big endian machines.
   It has to use sizeof() of the actual structure instead of
   sizeof(__u16).

<maxk@qualcomm.com> (02/11/22 1.797.136.1)
   Fix L2CAP client/server PSM clash.

<maxk@qualcomm.com> (02/11/17 1.797.15.2)
   l2cap_do_connect() should be static.

<marcel@holtmann.org> (02/11/13 1.797.13.5)
   [Bluetooth] Remove EXPORT_NO_SYMBOLS
   
   This patch removes one more EXPORT_NO_SYMBOLS which was left over
   after adding a 2.4.x driver.

<marcel@holtmann.org> (02/11/13 1.797.13.4)
   [Bluetooth] Add the needed call of init_timer()
   
   This patch adds the missing init_timer() call for the PCMCIA
   release function.

<marcel@holtmann.org> (02/11/13 1.797.13.3)
   [Bluetooth] Fix return with a value, in function returning void
   
   This patch removes the return value from functions which are only
   returning void.

<marcel@holtmann.org[holtmann]> (02/11/13 1.797.13.2)
   [Bluetooth] Add HCI UART PC Card driver
   
   This adds the HCI UART PC Card driver for Bluetooth PCMCIA devices
   with an UART interface.

<marcel@holtmann.org> (02/11/09 1.786.1.81)
   [Bluetooth] Fix another operator precedence for modem status
   
   This patch puts the needed parentheses around the modem status to
   make it work correctly.

<marcel@holtmann.org> (02/11/06 1.786.1.80)
   [Bluetooth] Add HCI id for Bluetooth PCI cards
   
   This is a simple oneline patch which only assigns the next free
   HCI id to Bluetooth devices that are based on PCI.

<marcel@holtmann.org> (02/11/05 1.786.1.79)
   [Bluetooth] Free skbs with kfree_skb() instead of kfree()
   
   This patch makes sure that the freeing of skbs is done with kfree_skb().

<maxk@qualcomm.com> (02/11/01 1.786.164.2)
   Bluetooth Kconfigs. Cleanup things missed by automatic converter.

<maxk@qualcomm.com> (02/11/01 1.786.164.1)
   Add BCSP TXCRC option to drivers/bluetooth/Kconfig

<marcel@holtmann.org> (02/10/27 1.786.78.5)
   [Bluetooth] Fix some bits of the modem status handling
   
   This fixes the wrong parameter order for the rfcomm_send_msc()
   command in rfcomm_process_tx() and adds an empty RFCOMM_NSC case
   for ignoring NSC control frames.

<marcel@holtmann.org[holtmann]> (02/10/27 1.786.78.4)
   [Bluetooth] Check for signals while waiting for DLC
   
   This fixes a bug in rfcomm_tty_open() which can end up in an endless
   loop using up all CPU time, because signal_pending() is always true.

<marcel@holtmann.org[holtmann]> (02/10/27 1.786.78.3)
   [Bluetooth] Fix operator precedence for modem status
   
   This patch puts the needed parentheses around the modem status to
   make it work correctly.

<marcel@holtmann.org[holtmann]> (02/10/27 1.786.78.2)
   [Bluetooth] Don't do wakeup if protocol is not set
   
   This patch checks whether protocol is set or not, before it will try
   to wake us up.




Max

http://bluez.sf.net
http://vtun.sf.net

