Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTKSNp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTKSNp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:45:28 -0500
Received: from ftp-xb.sasken.com ([164.164.56.3]:49556 "EHLO
	sandesha.sasken.com") by vger.kernel.org with ESMTP id S264056AbTKSNp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:45:26 -0500
Date: Wed, 19 Nov 2003 19:21:18 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: Switching packets from netif_rx()
Message-ID: <Pine.LNX.4.33.0311191905580.2480-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi

I am implementing a soft switch that can switch packets received on an
interface over certain outgoing interfaces.

The setup is -

	+-----------+		+------------+		+------+
	| Streamer  |-----------|   Switch   |----------| Host |
	+-----------+		+------------+		+------+

The switching functionality is implemented in function netif_rx(). Based
on the list of outgoing interfaces, I am doing the following things.

* Cloning the packets.
* Obtaining outgoing device from outgoing interface index.
* Calling dev_queue_xmit() to send the packet on outgoing device.


I am having the following is PROBLEM with this:
			     ~~~~~~~
When streamer sends a continuous flow of packets to switch, the switch is
able to send upto 3500 (approx. - this varies each time) to the host and
afterwards, the switch is hanging.

I tried sending bunches of 100 packets each with 1 second time gap between
bunches, the switch is functioning without interruptions.

- Is there any problem in the way I am implementing the switch? The
  "bridge" code seems to be doing the same things.
- Or, is there is some limit on the incoming flow rate the kernel will be
  able to handle?

I would be very grateful if someone can help me with this.

Regards
Madhavi.

Madhavi Suram
Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

************************************************************************

SASKEN BUSINESS DISCLAIMER



This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
