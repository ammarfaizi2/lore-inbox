Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTKQNdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKQNdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:33:00 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:32266 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S263496AbTKQNc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:32:58 -0500
Message-ID: <3FB8CE08.6070001@dcrdev.demon.co.uk>
Date: Mon, 17 Nov 2003 13:32:56 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard lock on 2.6-test9 (More Info)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both SMP kernels (2.4 and 2.6) appear to have the same interrupt map 
(cat /proc/interrupts):

Kernel 2.4:

           CPU0       CPU1
  0:      10942       8009    IO-APIC-edge  timer
  1:        199        208    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:       2275       1615    IO-APIC-edge  PS/2 Mouse
 14:         57         56    IO-APIC-edge  ide0
 16:        118          0   IO-APIC-level  usb-uhci, eth0
 17:       5267       3420   IO-APIC-level  ohci1394, Intel ICH4, nvidia
 18:          0          0   IO-APIC-level  usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 23:          0          0   IO-APIC-level  ehci_hcd
 24:       9083       3661   IO-APIC-level  ioc0
 25:         42          0   IO-APIC-level  ioc1
NMI:          0          0
LOC:      18878      18807
ERR:          0
MIS:          0

Kernel 2.6:

           CPU0       CPU1
  0:      75737      51102    IO-APIC-edge  timer
  1:        152        278    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:         61          0    IO-APIC-edge  i8042
 14:         22          1    IO-APIC-edge  ide0
 16:         92          0   IO-APIC-level  eth0
 17:          3          0   IO-APIC-level  ohci1394, Intel 82801DB-ICH4
 23:          0          0   IO-APIC-level  ehci_hcd
 24:       2635        715   IO-APIC-level  ioc0
 25:         42          0   IO-APIC-level  ioc1
NMI:          0          0
LOC:     126582     126581
ERR:          0
MIS:          0

When I boot X under kernel 2.6, I see the additional nvidia interrupt 
path as per the 2.4 output (which was taken whilst I was running X).

But, within seconds of this additional interrupt assignment appearing, 
2.6 dies a horrible death whilst 2.4 just keeps on rolling.

Cheers,

Dan.


