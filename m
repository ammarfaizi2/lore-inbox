Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270207AbRH1Du1>; Mon, 27 Aug 2001 23:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270221AbRH1DuR>; Mon, 27 Aug 2001 23:50:17 -0400
Received: from web14203.mail.yahoo.com ([216.136.172.145]:58125 "HELO
	web14203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270207AbRH1DuK>; Mon, 27 Aug 2001 23:50:10 -0400
Message-ID: <20010828035026.3091.qmail@web14203.mail.yahoo.com>
Date: Mon, 27 Aug 2001 20:50:26 -0700 (PDT)
From: java programmer <javadesigner@yahoo.com>
Subject: Intel e100 Ethernet card support in core Kernel
To: linux-kernel@vger.kernel.org
Cc: javadesigner@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

There is built in support for intel cards in the
core kernel. My question is, whether using this
kernel support is the best way to drive intel cards.

I have a dual port intel pro/100 adapter and am
experiencing a complete lockup (not even pingable)
after a certain amount of time. I am on kernel 2.4.7,
downloaded from kernel.org and compiled. I have 
libc-2.2.3.so in /lib

Here's the relevant section from dmesg (shown for 
eth0 only):

----------
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable
driver, ver 1.6.13
Copyright (c) 2001 Intel Corporation

eth0: Compaq Fast Ethernet Server Adapter
Using specified speed/duplex mode of 0.
Using specified ucode value of 1.
Using specified CPU saver interrupt delay value of
1536.
Using specified CPU saver bundle max value of 10.
Mem:0xc6cf0000  IRQ:11  Speed:100 Mbps  Dx:Full
Hardware receive checksums disabled
----------------

And here is the module load line from
/etc/rc.d/rc.modules

/sbin/modprobe e100 ucode=1,1 IntDelay=0x600,0x600
BundleMax=10,6 e100_speed_duplex=0,0

The above is my current configuration that leads to
the lockup. Please note, this is the absolute latest
and well tested driver - for this card - straight from
intel.

Now here's the thing: initially I had a 2.4.5 kernel,
with a stock, built in driver for this card that gave
me the following dmesg:

-----
eth0: OEM i82557/i82558 10/100 Ethernet,
:50:8B:E3:AA:B4, IRQ 11.
Receiver lock-up bug exists -- enabling work-around.
Board assembly 009542-003, Physical connectors
present: RJ45
Primary interface chip i82555 PHY #1.
General self-test: passed.
Serial sub-system self-test: passed.
Internal registers self-test: passed.
ROM checksum self-test: passed (0x24c9f043).
Receiver lock-up workaround activated.
------

I took the above driver out, in favor of the newer
intel driver, but note, the newer intel driver gives
me no message about the "lock up bug", that this other
older driver gives me (see first line in dmesg output
above).

So does anyone know what's going on and whether the
newer intel drivers are in fact more broken than the
older ones that came with the kernel ? I haven't tried
the older ones enough to know whether the lock up
would exist with them  too or not, any driver writers
care to shed some light on this ?

Best regards,

javadesigner@yahoo.com

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
