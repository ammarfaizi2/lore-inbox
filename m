Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTD1TKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTD1TKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 15:10:05 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:11392 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261245AbTD1TKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 15:10:03 -0400
Message-Id: <5.1.0.14.2.20030428121700.10a2d158@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 28 Apr 2003 12:22:15 -0700
To: torvalds@transmeta.com
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates and fixes for 2.5.BK
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

Here is the next bunch of Bluetooth updates. 
Please pull from
        bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 drivers/bluetooth/Kconfig        |    9 
 drivers/bluetooth/bluecard_cs.c  |   33 -
 drivers/bluetooth/bt3c_cs.c      |   33 -
 drivers/bluetooth/btuart_cs.c    |   33 -
 drivers/bluetooth/dtl1_cs.c      |   33 -
 drivers/bluetooth/hci_usb.c      |  838 +++++++++++++++++++++++----------------
 drivers/bluetooth/hci_usb.h      |  101 +++-
 include/net/bluetooth/hci_core.h |   18 
 include/net/bluetooth/rfcomm.h   |   10 
 net/bluetooth/af_bluetooth.c     |    1 
 net/bluetooth/hci_conn.c         |    1 
 net/bluetooth/hci_sock.c         |    4 
 net/bluetooth/l2cap.c            |    2 
 net/bluetooth/rfcomm/core.c      |   58 ++
 net/bluetooth/rfcomm/tty.c       |   21 
 15 files changed, 726 insertions(+), 469 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/04/27 1.1196)
   [Bluetooth] Initialize ->owner field of the RFCOMM tty driver. 
   In order to fix all MOD_INC/DECs in the RFCOMM code we need __module_get().

<maxk@qualcomm.com> (03/04/27 1.1195)
   [Bluetooth] Initialize net_proto_family->owner field. This covers only HCI sockets. 
   Other protocols cannot be fixes at this point because current net_proto_family
   code does not support "family owner != socket owner" case.

<maxk@qualcomm.com> (03/04/27 1.1194)
   [Bluetooth] USB drivers cannot call usb_unlink_urb() under spin lock.

<maxk@qualcomm.com> (03/04/27 1.1193)
   [Bluetooth] Fix race condition in RFCOMM session and dcl scheduler. 
   This fixes random RFCOMM freezes reported by some people.

<maxk@qualcomm.com> (03/04/27 1.1192)
   [Bluetooth] Improved RFCOMM TTY TX buffer management. 
   Don't buffer more data than we have credits for.
   
   Patch from David Woodhouse <dwmw2@infradead.org>

<marcel@holtmann.org> (03/04/23 1.1179.5.2)
   [Bluetooth] Correction of the HCI USB driver description
   
   This patch reverts the module description and other comments.

<marcel@holtmann.org> (03/04/23 1.971.23.3)
   [Bluetooth] Fix L2CAP binding to local address
   
   In the function l2cap_connect_ind() we compare the bounded
   address with the address of an incoming connection, but we
   have to compare it with the local address of the HCI device.

<maxk@qualcomm.com> (03/04/06 1.971.22.5)
   [Bluetooth] Update BT PCMCIA drivers to use pcmcia_register_driver().
   Patch from Christoph Hellwig <hch@lst.de>

<marcel@holtmann.org> (03/03/30 1.971.23.2)
   [Bluetooth] Respond correctly to RLS packets
   
   This patch adds the recognition and correct responding to the
   RFCOMM RLS packets to fulfil the requirements of the Bluetooth
   specification.

<maxk@qualcomm.com> (03/03/24 1.971.22.4)
   [Bluetooth] Don't forget to set HCI device owner in USB driver.

<maxk@qualcomm.com> (03/03/24 1.971.22.2)
   [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
   URB and buffer management rewrite.

<marcel@holtmann.org> (03/03/21 1.889.385.4)
   [Bluetooth] Use R1 for default value of pscan_rep_mode
   
   Most devices seem to use R1 for pscan_rep_mode to save power
   consumption, so R1 is preferable for default value, if there
   is no entry in the inquiry cache. Using R1 will improve the
   average of connect time in many cases.

<marcel@holtmann.org> (03/03/20 1.889.385.3)
   [Bluetooth] Add support for the Ultraport Module from IBM
   
   This patch adds the specific vendor and product id's for the
   Bluetooth Ultraport Module from IBM. This is needed, because
   the device itself don't uses the USB Bluetooth class id.

<maxk@qualcomm.com> (03/03/19 1.889.385.2)
   [Bluetooth]
   Kill incoming SCO connection when SCO socket is closed

<maxk@qualcomm.com> (03/03/05 1.889.299.1)
   [Bluetooth]
   Use very short disconnect timeout for SCO connections. They cannot
   be reused and therefor there is no need to keep them around.

Thanks


Max

http://bluez.sf.net
http://vtun.sf.net

