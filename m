Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUB0Rbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUB0Rbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:31:33 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:53936 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263062AbUB0Rb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:31:29 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Feb 2004 17:31:27 -0000
MIME-Version: 1.0
Subject: 2.6.3 - 8139too timeout debug info
Message-ID: <403F7EEF.4124.2432E62F@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, I am starting a fresh thread here, as I have subscribed to 
the lkml now so I can reply in a timely manner, and also the other 
thread was broke as I was replying 'off-list' - sorry about that.

OK, to recap.  With 2.6.3 I get timeouts with 8139too under network 
load (any load).  I have never had any problems with these _same_ two 
cards under any other kernel version over the last 3 years.

If I use the 8139too.c from 2.6.2, and build 2.6.3 with it, all works 
fine (I am running this version right now).

Here is the debuggered output (using #define RTL8139_NDEBUG 1):

#> /var/log/messages

Feb 27 17:12:27 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 27 17:12:39 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 27 17:12:42 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 27 17:12:43 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 27 17:12:51 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 27 17:12:51 Linux233 kernel: nfs: server 486Linux OK

Feb 27 17:12:51 Linux233 kernel: nfs: server 486Linux OK
Feb 27 17:13:03 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 27 17:13:03 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 27 17:13:03 Linux233 kernel: nfs: server 486Linux OK

#> dmesg

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 1314  dirty entry 1310.
eth0:  Tx descriptor 0 is 00002000.
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000. (queue head)
eth0:  Tx descriptor 3 is 00002000.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 1392  dirty entry 1388.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
nfs: server 486Linux not responding, still trying
nfs: server 486Linux not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 363  dirty entry 359.
eth0:  Tx descriptor 0 is 00002000.
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000. (queue head)
nfs: server 486Linux OK
nfs: server 486Linux OK
nfs: server 486Linux not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 3441  dirty entry 3437.
eth0:  Tx descriptor 0 is 00002000.
eth0:  Tx descriptor 1 is 00002000. (queue head)
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
nfs: server 486Linux OK

#> lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo 
VP1/VPX] (rev 23)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 27)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W 
[Millennium II]

Built with:

# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139_RXBUF_IDX=2

Any more info required?

TIA,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle
And this'll help things turn out for the best."

