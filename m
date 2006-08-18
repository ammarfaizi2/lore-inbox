Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWHRArP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWHRArP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHRArP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:47:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8419 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932137AbWHRArP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:47:15 -0400
Subject: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 20:47:55 -0400
Message-Id: <1155862076.24907.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a weird serial bug.  My host is a Via EPIA M-6000 running
2.6.17 connected to a PPC Yosemite board running 2.6.13. 

In all cases the serial console works great.  But, with the default
setting of IRQ 4, Kermit file transfers via the serial interface simply
time out.  However if I use polling mode (setserial /dev/ttyS0 irq 0 on
the host), file transfers work.

When set to IRQ 4, the interrupt count does increase.

# cat /proc/tty/driver/serial 
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:267 rx:667 DSR|CD
1: uart:16550A port:000002F8 irq:3 tx:0 rx:0
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3

# setserial /dev/ttyS0 
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4

# cat /proc/interrupts 
           CPU0       
  0:  175715279          XT-PIC  timer
  1:     137763          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:        326          XT-PIC  serial
[...]

Any ideas?  I'm guessing it might be a quirk of the VIA chipset?

Lee



