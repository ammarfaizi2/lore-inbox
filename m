Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKIHYM>; Thu, 9 Nov 2000 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKIHYD>; Thu, 9 Nov 2000 02:24:03 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:6666 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129213AbQKIHXt>; Thu, 9 Nov 2000 02:23:49 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Nov 2000 08:23:26 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: kernel: eepro100: wait_for_cmd_done timeout!
CC: linux-eepro100@webserv.gsfc.nasa.gov
Message-ID: <3A0A5EF9.22733.135B0F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing the message periodically:

Nov  8 09:52:59 kgate last message repeated 5 times
Nov  8 11:26:54 kgate kernel: eepro100: wait_for_cmd_done timeout!
Nov  8 11:56:12 kgate kernel: eepro100: wait_for_cmd_done timeout!
Nov  8 14:38:45 kgate kernel: eepro100: wait_for_cmd_done timeout!
Nov  8 14:38:47 kgate last message repeated 3 times
Nov  8 14:56:11 kgate kernel: eepro100: wait_for_cmd_done timeout!
Nov  8 14:57:01 kgate last message repeated 10 times
Nov  8 21:32:15 kgate kernel: eepro100: wait_for_cmd_done timeout!
Nov  8 22:57:46 kgate kernel: eepro100: wait_for_cmd_done timeout!

The source contains:

/* How to wait for the command unit to accept a command.
   Typically this takes 0 ticks. */
static inline void wait_for_cmd_done(long cmd_ioaddr)
{
        int wait = 1000;
        do   ;
        while(inb(cmd_ioaddr) && --wait >= 0);
#ifndef final_version
        if (wait < 0)
                printk(KERN_ALERT "eepro100: wait_for_cmd_done 
timeout!\n");
#endif
}

My machine is a HP Netserver LD Pro with a 200MHz Pentium Pro. I guess 
a fast machine will only allow a very short time for the above loop. 
Shouldn't it be fixed?

The hardware is this:
01:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 02)
        Subsystem: Hewlett-Packard Company Ethernet Pro 10/100TX
        Flags: bus master, medium devsel, latency 66, IRQ 9
        Memory at fe8fe000 (32-bit, prefetchable)
        I/O ports at ece0
        Memory at fea00000 (32-bit, non-prefetchable)


kgate kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
kgate kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by 
Andrey V. Savochkin <saw@saw.sw.com.sg> and others
kgate kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:60:B0:6D:F1:AE, 
IRQ 9.
kgate kernel:   Board assembly 673610-001, Physical connectors present: 
RJ45
kgate kernel:   Primary interface chip i82555 PHY #1.
kgate kernel:   General self-test: passed.
kgate kernel:   Serial sub-system self-test: passed.
kgate kernel:   Internal registers self-test: passed.
kgate kernel:   ROM checksum self-test: passed (0x49caa8d6).
kgate kernel:   Receiver lock-up workaround activated.

The software is Linux-2.2.16 (SuSE 7.0).

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
