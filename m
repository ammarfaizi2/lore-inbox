Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTI2NvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTI2NvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:51:15 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:43881 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S263380AbTI2NvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:51:13 -0400
From: Thomas Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: BugReport (test6): USB (ACPI), SWSUSP, E100
Date: Mon, 29 Sep 2003 15:51:00 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291551.00446.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I sent a similar report for 2.6.0test5 already (see: 
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-09/3017.html).
Back than I was told to wait for the next kernel (test6) and check again. So 
here are the results with test6:

 
- USB - still dead
This notebook has some IRQ routing problems and requires ACPI to get it right. 
When using older 2.4 Kernels I always had to apply the ACPI patches to get 
USB working. With 2.6-test3 the IRQ routing / ACPI stuff worked out of the 
box. With test5 and test6 USB is not working.
The following of dmesg seems to be interesting (full dmesg at the end of the 
mail):

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
irq 9: nobody cared!
Call Trace:
 [<c010ae0a>] __report_bad_irq+0x2a/0x90
 [...]
 [<c01072a9>] kernel_thread_helper+0x5/0xc

handlers:
[<c0204f3f>] (acpi_irq+0x0/0x16)
Disabling IRQ #9


- SWSUSP 
In contrast du test5 there now is a /proc/acpi/sleep file again. But an 

echo 4 > /proc/acpi/sleep shows no effect at all. SWSUSP is enabled in the 
kernel (full .config at the end of the mail).

echo 3 > /proc/acpi/sleep produces the following output and then the prompt 
returns again:
Stopping tasks: ==================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, khubd not stopped
 done


- The e100 driver seems to be broken 
The NIC is detected correctly and ifconfig shows eth0 as usually. But for some 
reason not a single Byte seems to go over the NIC. I can ping the machine 
itself but I'm not able to send anything to any outside machine. This again 
works perfectly with test3 but shows the same problems with test5 and test6
Please note: I compiled test6 with the same .config as test3 and I didn't 
change any init scripts before bootuing test6. I've no idea but might this 
problem be related to the broken ACPI?


full dmesg: http://www.wnk.at/tmp/test6/dmesg.txt 
.config used building the kernel: http://www.wnk.at/tmp/test6/config.txt 
 
Since I'm not subscribed to LKM please CC me on replys. 
If you need more information please drop me a line.
 
Thanks,
-- 
Tom Winkler
e-mail: tom@qwws.net
