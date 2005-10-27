Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVJ0JrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVJ0JrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVJ0JrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 05:47:06 -0400
Received: from beret.waw.pdi.net ([213.241.71.70]:47622 "EHLO beret.srv.pl")
	by vger.kernel.org with ESMTP id S932174AbVJ0JrF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 05:47:05 -0400
Subject: Re: dumb muliport serial cards not supported in 2.6.13.4 ???
From: Jarek <jarek@macro-system.com.pl>
To: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051027080839.GA3235@flint.arm.linux.org.uk>
References: <1130397258.13942.14.camel@jarek.macro>
	 <20051027080839.GA3235@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-2
Organization: Macro System
Date: Thu, 27 Oct 2005 11:46:31 +0200
Message-Id: <1130406391.13942.24.camel@jarek.macro>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 27-10-2005, czw o godzinie 09:08 +0100, Russell King napisa³(a):

> Please send the kernel messages from this kernel so we can see what's
> going on.  (this would be useful whatever.)

>From dmesg:

Serial: 8250/16550 driver $Revision: 1.90 $ 16 ports, IRQ sharing
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A


$cat /proc/tty/driver/serial:

serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:47 rx:0 RTS|DTR
1: uart:16550A port:000002F8 irq:3 tx:0 rx:0 CTS|DSR
2: uart:16550A port:00000240 irq:5 tx:2828 rx:2826 fe:81
3: uart:16550A port:00000248 irq:5 tx:0 rx:0 RTS|CTS|DTR|DSR
4: uart:unknown port:00000000 irq:0
5: uart:unknown port:00000000 irq:0
6: uart:unknown port:00000000 irq:0
7: uart:unknown port:00000000 irq:0
8: uart:unknown port:00000000 irq:0
9: uart:unknown port:00000000 irq:0
10: uart:unknown port:00000000 irq:0
11: uart:unknown port:00000000 irq:0
12: uart:unknown port:00000000 irq:0
13: uart:unknown port:00000000 irq:0
14: uart:unknown port:00000000 irq:0
15: uart:unknown port:00000000 irq:0


setserial /dev/ttyS4 port 0x250 irq 5 uart 16550A ^fourport
Cannot set serial info: Invalid argument

(ports 2-9 are from PCM3643)

$grep CONFIG_SERIAL .config
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FOURPORT is not set
# CONFIG_SERIAL_8250_ACCENT is not set
# CONFIG_SERIAL_8250_BOCA is not set
# CONFIG_SERIAL_8250_HUB6 is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set

best regards
Jarek

