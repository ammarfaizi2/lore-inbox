Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTILQyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTILQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:54:44 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:40932 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S261764AbTILQyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:54:40 -0400
Message-Id: <5.1.0.14.2.20030912095050.06e091e0@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Sep 2003 09:54:29 -0700
To: davem@redhat.com
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates and fixes for 2.5
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, 

We've got a bunch of Bluetooth updates for you to pull at
       bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 CREDITS                           |    3 -
 MAINTAINERS                       |   52 ++++++++++++++++-
 drivers/bluetooth/hci_usb.c       |    3 -
 include/net/bluetooth/bluetooth.h |    2 
 include/net/bluetooth/hci.h       |    2 
 include/net/bluetooth/l2cap.h     |    2 
 net/bluetooth/af_bluetooth.c      |   22 +++----
 net/bluetooth/bnep/bnep.h         |    4 -
 net/bluetooth/bnep/core.c         |   36 +++++-------
 net/bluetooth/bnep/netdev.c       |    7 --
 net/bluetooth/hci_core.c          |    9 ++-
 net/bluetooth/hci_event.c         |   13 ++++
 net/bluetooth/hci_sock.c          |    2 
 net/bluetooth/l2cap.c             |   74 ++++++++++++++++--------
 net/bluetooth/rfcomm/core.c       |  102 +++++++++++++++++++++++++++++-----
 net/bluetooth/rfcomm/sock.c       |   75 +++++++++++++------------
 net/bluetooth/rfcomm/tty.c        |  113 ++++++++++++++++++--------------------
 net/bluetooth/sco.c               |   21 +++++--
 net/bluetooth/syms.c              |    2 
 19 files changed, 359 insertions(+), 185 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/09/11 1.1153.66.2)
   [Bluetooth] Convert BNEP protocol to dynamic allocation of network devices.
   This will allow fixing races with rmmod and sysfs access.
   
   Patch from Stephen Hemminger <shemminger@osdl.org>

<maxk@qualcomm.com> (03/08/20 1.1153.33.2)
   [Bluetooth] L2CAP qualification spec mandates sending additional config request 
   if we receive config response with unacceptable parameters error code. 
   So we now send dummy request to keep tester happy.

<marcel@holtmann.org> (03/07/22 1.1046.306.9)
   [Bluetooth] Add support for FCon and FCoff flow control commands
   
   This patch adds flow control support using FCon and FCoff commands
   to fulfil the requirements of the Bluetooth specification.

<marcel@holtmann.org> (03/07/18 1.1046.306.8)
   [Bluetooth] Add tiocmget() and tiocmset() routines to RFCOMM TTY
   
   This patch adds the routines tiocmget() and tiocmset() to the
   RFCOMM TTY layer for setting and retrieving the modem status.

<marcel@holtmann.org> (03/07/14 1.1046.306.7)
   [Bluetooth] Update the maintainer entries for the Bluetooth subsystem
   
   This patch puts a little bit more detailed information about the
   maintainers of the Bluetooth subsystem into the MAINTAINERS file.

<marcel@holtmann.org> (03/07/14 1.1046.306.6)
   [Bluetooth] Handle command complete event for inquiry cancel
   
   The command complete event of the inquiry cancel command must
   clear the HCI_INQUIRY flag and finish the HCI request.

<marcel@holtmann.org> (03/07/03 1.1046.306.5)
   [Bluetooth] Support for inquiry with unlimited responses
   
   This patch handles the special case if the number of responses
   is set to zero, which means unlimited responses.

<marcel@holtmann.org> (03/06/27 1.1046.306.4)
   [Bluetooth] Make READ_TRANSMIT_POWER_LEVEL available for normal users
   
   This makes the HCI command READ_TRANSMIT_POWER_LEVEL available for
   normal users.

<marcel@holtmann.org> (03/06/19 1.1046.306.3)
   [Bluetooth] Quirk for devices with no ISOC endpoints
   
   This patch checks the existence of ISOC endpoints before it
   starts the URB for them.

<maxk@qualcomm.com> (03/06/16 1.1046.306.2)
   [Bluetooth] Add support for SO_LINGER to L2CAP, RFCOMM and SCO sockets.
   This is required to pass qualification testing.

<maxk@qualcomm.com> (03/06/11 1.1046.271.3)
   [Bluetooth] Fix RFCOMM C/R and Direction bits handling.
   MCC C/R bit does not depend on connection state.
   Direction bit must be set for DLCs located on the initiator.

<maxk@qualcomm.com> (03/06/11 1.1046.270.1)
   Bluetooth: RFCOMM must send MSC when DLC was opened by SABM 

<marcel@holtmann.org> (03/05/29 1.1046.53.4)
   [Bluetooth] Handle bit rate in remote port negotiation
   
   This patch adds handling of the bit rate to rfcomm_recv_rpn().

<marcel@holtmann.org> (03/05/29 1.1046.53.3)
   [Bluetooth] Set EA bit for V.24 signals parameter
   
   This patch always sets the EA bit along with the V.24 signals
   value in rfcomm_send_msc().

<marcel@holtmann.org> (03/05/28 1.1046.53.2)
   [Bluetooth] Send correct RPN response for accepted values
   
   This patch fixes another bug in rfcomm_recv_rpn(), which do
   not respond with the correct values for accepted settings.


Max

http://bluez.sf.net
http://vacum.sf.net
http://vtun.sf.net

