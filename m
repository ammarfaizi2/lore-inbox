Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbRLPWkH>; Sun, 16 Dec 2001 17:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbRLPWj6>; Sun, 16 Dec 2001 17:39:58 -0500
Received: from mout0.freenet.de ([194.97.50.131]:49643 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S284899AbRLPWjk>;
	Sun, 16 Dec 2001 17:39:40 -0500
Message-ID: <3C1D2313.3020105@athlon.maya.org>
Date: Sun, 16 Dec 2001 23:41:23 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.417rc1] various hotplugging problems
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


I'm running kernel 2.4.17rc1 and I have some strange problems with 
hotplugging and module xircom_tulip_cb (Xircom Cardbus ethernet 
10/100+Modem 56 (CBEM56G-100) with Thinkpad T21 laptop).

If I put in my card, the networkdriver always starts with
100 MB/halfduplex (autonegotiation).

The linkpartner says:
Setting half-duplex based on auto-negotiated partner ability 0000.

Next, I forced both sides to do 100Mb full-duplex. As a result,
I got on the laptop the following errormessage:
kernel: eth0: Link forced to 100Mbit full-duplex
kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0xfffe0000
but the connect is working with a lot of errors on TX carrier side.

eth0      Link encap:Ethernet  HWaddr 00:10:A4:A5:7B:F8
           inet addr:192.168.2.4  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:71404 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:36955 dropped:0 overruns:0 carrier:36955
           collisions:0 txqueuelen:100
           RX bytes:103113288 (98.3 Mb)  TX bytes:0 (0.0 b)
           Interrupt:11 Base address:0x4000


Otherwise, I didn't get any error on the device of the linkpartner.

If I'm running kernel 2.4.16 with pcmcia_cs package (no hotplugging),
all is working fine - with using autonegotiation on both sides.

eth0      Link encap:Ethernet  HWaddr 00:10:A4:A5:7B:F8
           inet addr:192.168.2.4  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:83080 errors:1 dropped:0 overruns:0 frame:0
           TX packets:47330 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:103882334 (99.0 Mb)  TX bytes:3124000 (2.9 Mb)
           Interrupt:11 Base address:0x200

(the one error on RX-side is from startup of the device).


There is one more problem with the hotplugging-function of kernel 2.4.17rc1:
in /lib/modules/2.4.17-rc1/modules.pcimap, the module serial_cs is 
missing - so the serial port of the Xircom-card can't be loaded 
(pcimodules can't show it).
You can insert a line, beginning with serial_cs and the following data 
are the same as in the xircom_tulip_cb - line. These datas are surely 
not correct - but the serial device of the Xircom-card is now configured 
automatically.



Unfortunately, this wasn't the last problem:
if you do a apm -s with kernel 2.4.17rc1, it is working fine unless the 
hotplugging hasn't been started.
If hotplugging has been started once, the laptop "wakes up" and hangs 
after apm -s (apm -s doesn't come back again). You can't even ping the 
laptop. I have to do a hw-reset. I tested those kernel options:
-> Allow interrupts during APM BIOS calls
-> Ignore USER SUSPEND

The result was always the same.

The HW-suspend-mode with Fn-F4 isn't working, too.

If I do the same with kernel 2.4.16 and pcmcia_cs-package, the 
hw-suspend is working fine as long as the cardmgr wasn't stopped or 
restarted.
apm -s doesn't behave other as with kernel 2.4.17 and hotplugging.



Could you please fix these bugs or did I do some configuration errors?
If you want, I can do some tests for you.


Thanks for any hint,
regards,
Andreas Hartmann

