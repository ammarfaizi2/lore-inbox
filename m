Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272478AbTHOXS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272485AbTHOXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:18:29 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:40967 "EHLO
	mail3.cybertrails.com") by vger.kernel.org with ESMTP
	id S272478AbTHOXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:18:26 -0400
Date: Fri, 15 Aug 2003 16:18:19 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Missing cardbus label in /proc/interrupts
Message-Id: <20030815161819.4ff4ad0a.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen in 2.6.0-test3's /proc/interrupts:

           CPU0       
  0:  179268180          XT-PIC  timer
  1:      36175          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:       1248          XT-PIC  ide2
  5:     820479          XT-PIC  ESS Maestro 2
  8:          1          XT-PIC  rtc
 11:    3548209          XT-PIC  uhci-hcd, , , eth0
 14:     518106          XT-PIC  ide0
 15:     714841          XT-PIC  ide1
NMI:          0 
ERR:      18176

The cardbus devices aren't listed.  I'm using the network card in one and
the CF card is readable in the other.  This is probably a trivial bug.

[root@violet 16:08:54 root]# lspci -v
  ...
00:04.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0085
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001
 
00:04.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0085
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        16-bit legacy interface ports at 0001
  ...

I noticed this after several card insertions, so I rebooted the system,
but this seems to be constant.

	-Paul

