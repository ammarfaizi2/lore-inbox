Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTELVOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTELVOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:14:21 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:955 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S262731AbTELVOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:14:14 -0400
Message-Id: <5.1.0.14.2.20030512142208.01bfe4b8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 May 2003 14:26:54 -0700
To: torvalds@transmeta.com
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth fixes for 2.5.bk
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

I've got a bunch of Bluetooth fixes for you to pull
       bk://linux-bt.bkbits.net/bt-2.5

Mostly module related stuff, plus several small fixes to pass Bluetooth
qualification tests.

This will update the following files:

 drivers/bluetooth/hci_ldisc.c  |    1 
 drivers/bluetooth/hci_usb.c    |    6 ++--
 include/net/bluetooth/l2cap.h  |    8 +++--
 include/net/bluetooth/rfcomm.h |   10 +++++--
 net/bluetooth/af_bluetooth.c   |   13 +++++----
 net/bluetooth/bnep/core.c      |   11 +++++--
 net/bluetooth/bnep/sock.c      |    7 ----
 net/bluetooth/l2cap.c          |   53 ++++++++++++++++++++++---------------
 net/bluetooth/rfcomm/core.c    |   58 ++++++++++++++++++++++++-----------------
 net/bluetooth/rfcomm/sock.c    |    6 +---
 net/bluetooth/rfcomm/tty.c     |    9 ++++--
 net/bluetooth/sco.c            |   10 +------
 12 files changed, 111 insertions(+), 81 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/05/09 1.1081.2.5)
   [Bluetooth] RFCOMM must wait for MSC exchange to complete before sending data.

<maxk@qualcomm.com> (03/05/09 1.1081.2.3)
   [Bluetooth] Detect and log error condition when first L2CAP fragment is too long.

<maxk@qualcomm.com> (03/05/09 1.1081.2.2)
   [Bluetooth] L2CAP config req/rsp fixes. 
   We have to set continuation flag in config rsp if it was set in req.

<marcel@holtmann.org> (03/05/09 1.1042.45.5)
   [Bluetooth] Handle priority bits in parameter negotiation
   
   The PN response have to return the same value for the priority
   bits as in the request. The priority value is now also stored
   in the rfcomm_dlc structure and the default value is 7.

<marcel@holtmann.org> (03/05/09 1.1042.45.4)
   [Bluetooth] Send the correct values in RPN response
   
   This patch fixes a bug in rfcomm_recv_rpn(), which do not set
   the correct values for xon_char, xoff_char and flow_ctrl.

<maxk@qualcomm.com> (03/05/08 1.1078.1.5)
   [Bluetooth] Add required infrastructure for socket module refcounting.
   Initialize ->owner fields in Bluetooth protocols and drivers.

<marcel@holtmann.org> (03/05/01 1.1042.45.3)
   [Bluetooth] Compile fix for URB_ZERO_PACKET
   
   This patch fixes the compile problem with URB_ZERO_PACKET.

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

