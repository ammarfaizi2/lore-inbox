Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTA2LTC>; Wed, 29 Jan 2003 06:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTA2LTC>; Wed, 29 Jan 2003 06:19:02 -0500
Received: from port94.vestas.dk ([195.41.59.94]:13318 "EHLO
	cotas2.cotas.vestas.dom") by vger.kernel.org with ESMTP
	id <S265843AbTA2LTA>; Wed, 29 Jan 2003 06:19:00 -0500
Subject: Large IP packets over ArcNet (netif_wake_queue propagation)
From: Esben Nielsen <esn@vestas.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Jan 2003 12:28:16 +0100
Message-Id: <1043839696.21327.166.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsis:
 I am writing test-software for our ArcNet-driver for vxWorks. I use a
Linux machine running 2.4.18 as test-bench. I am trying to test our
rfc1201 (IP over ArcNet) implementation by ping'ing with large packets.
This fails:
Linux simply doesn't send all the IP-fragments.

I then went into the driver and increased the queue-length
from
  dev->tx_queue_len = 40;
to
  dev->tx_queue_len = 60;
and then it worked.

It seems to me the IP-layer is not notified when the device queue is
emptied by the device and thus doesn't send out the missing fragments.
I tried to look into the net core code to find out: Indeed I could not
find any notification to the higher level protocols.
In vxWorks I am used to waking the higher-level protocols directly
(there is no generic device-specific queue). Thus IP stack can continue
with the next IP-fragment right away. Apparently the Linux IP-stack
can't as it is not notified that the device is ready to send again.

I am really understanding this correctly???

Also, I want to run a raw packet protocol along with IP. That protocol
works best with a small queue - maximum 10 packets!

Esben Nielsen
Vestas Wind Systems


