Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130820AbQK3TYv>; Thu, 30 Nov 2000 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130861AbQK3TYD>; Thu, 30 Nov 2000 14:24:03 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:1292 "EHLO
        Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
        id <S131034AbQK3TLt>; Thu, 30 Nov 2000 14:11:49 -0500
Message-ID: <3A269F47.17336A69@Hell.WH8.TU-Dresden.De>
Date: Thu, 30 Nov 2000 19:41:11 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001117172336.B27444@saw.sw.com.sg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:

> I've updated eepro100 driver for 2.4 kernel branch.
> So far, the most annoying initialization problem (expressing itself in "card
> reports no resources" messages) hasn't been fixed.

Hi Andrey,

I've been using an older EEPro100/B card until now and it's been working without any
problems ever since the transmitter bugs were fixed. The boot output looked like this:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:41:F4:DE, IRQ 9.
  Board assembly 667280-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.       

Intel webpage says: 667280-xxx is a model EEPro100/B but I dunno which chipset.


Today I've installed a new model with Wake-on-LAN support and got caught by
above mentioned

eth0: card reports no RX buffers.
eth0: card reports no resources.

messages as well. Strangely those messages only ever happen during bootup and
*every* time. Shutting eth0 down and bringing it back up fixes the problem.

What puzzles me a bit is that the newer card (721383-xxx) is an 82559 chip,
according to the Intel site, but the boot output doesn't say so:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:02:B3:1F:BA:5D, IRQ 9.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).  

If you have any patches or tests that would help to find and fix this init
bug, I'd offer to test them out, since I can reliably reproduce the problem.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
