Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSJJAxc>; Wed, 9 Oct 2002 20:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSJJAxc>; Wed, 9 Oct 2002 20:53:32 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:61905 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262730AbSJJAxb> convert rfc822-to-8bit; Wed, 9 Oct 2002 20:53:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19: network related kernel panic (was: Blinking Keyboard LED after crash?)
Date: Thu, 10 Oct 2002 02:58:41 +0200
X-Mailer: KMail [version 1.4]
References: <200210080200.03756.jan-hinnerk_reichert@hamburg.de> <20021009174557.GF941@riesen-pc.gr05.synopsys.com>
In-Reply-To: <20021009174557.GF941@riesen-pc.gr05.synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210100258.41608.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first thanks for all replies.

I have just had another identical kernel crash with kernel compiled with 
gcc-2.95.3 as it comes with SuSE 7.3

This time I got an error on console (I switched with Alt-F10 before the 
crash).

The error was an "divide error" in kfree. This was called via some functions 
from rtl8139_start_xmit (8139too.c).
Other functions involved are from
- qdisc (I use CBQ, SFQ)
- ip forward
- netfilter
- 802.1d Ethernet Bridging

The package that triggers this error is most likely coming from an DSL-modem 
over (kernel based PPPoE, pppd 2.4.1), in that case CBQ is not involved (only 
SFQ)

System:
 CPU: AMD K5PR166
 Chipset: Intel HX

My network configuration:
 eth1: RTL 8139 <-> DSL-Modem
 br0: (802.1d Ethernet Bridge)
   eth0: RTL-8029 (PCI NE2000) <-> three computers over Coax
   eth2: RTL-8139 <-> Single other computer

Kernel:
 No modules. 
 No experimental options except for PPPoE
 Memory mapped I/O for network

Has anyone experienced similar difficulties?
Has anyone a clue what it could be?
Is a hardware failure likely?
Should I post more information (complete call-trace, kernel-config, 
netfilter-rules)?

For now I have disabled CBQ and SFQ to narrow the error, but it could be weeks 
until the next crash (or perhaps it crashes before I can send this mail)

Any ideas, pointers, patches appreciated
 Jan-Hinnerk

