Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266634AbUAWXUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUAWXUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:20:24 -0500
Received: from main.gmane.org ([80.91.224.249]:7349 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266634AbUAWXUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:20:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Axel Boldt <axelboldt@yahoo.com>
Subject: PROBLEM: APM resume after suspend broken, 2.6.2-rc1
Date: Fri, 23 Jan 2004 23:40:59 +0100
Message-ID: <4011A2FB.60307@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: sfr@canb.auug.org.au
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux 2.6.2-rc1 with APM support compiled in, on a Dell
Inspiron 5000 laptop. Under Windows, APM suspend/resume works fine,
but under Linux the machine doesn't resume properly.

 > apm -v
APM BIOS 1.2 (kernel driver 1.16ac)
On-line, battery status high: 100% (3:20:00)
 > apm -V
apm version 3.2.1

apmd is running and standby mode (apm -S) works flawlessly.

Suspending the machine ro RAM (apm -s) first gives the following 
messages in syslog's kern.log:

hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend

Then the screen blanks and the hard drive stops spinning.
Upon resume, I always get the messages

MCE: The hardware reports a non fatal, correctable incident occurred on 
CPU 0.
Bank 1: e200000000000175

then the screen comes back and I can type text into the
virtual console. Most of the time, as soon as I issue a command that
uses the hard drive (e.g. ls), the shell will hang. I can switch to
another virtual console, but again, any command that accesses the drive 
hangs.
Ctrl-Alt-Delete or shutdown -s fail to reboot the machine. Syncing and
unmounting with SysRq don't work, but rebooting with SysRq-B works.
The SysRq-P call trace contains the functions cpu_idle and
start_kernel.

SOMETIMES, the machine will resume properly, giving the messages below:

MCE: The hardware reports a non fatal, correctable incident occurred on 
CPU 0.
Bank 1: e200000000000175
PCI: Found IRQ 5 for device 0000:00:08.0
PCI: Sharing IRQ 5 with 0000:00:07.2
drivers/usb/host/uhci-hcd.c: 1060: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: 1060: host controller halted. very bad
spurious 8259A interrupt: IRQ7.
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume

(The spurious 8259A interrupt doesn't always show up.)

There's a combined NIC/modem card in the PCMCIA slot, hda is the IDE
hard drive, hdc is the dvd drive. Everything uses PCI.

Linux 2.6.1 shows the exact same behavior.

The contents of dmesg, .config used for kernel compilation, and 
/proc/pci can be found at http://math-www.uni-paderborn.de/~axel/apm_bug.txt

Thanks,
   Axel

