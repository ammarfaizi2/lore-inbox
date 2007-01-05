Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbXAEXNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXAEXNS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbXAEXNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:13:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:59849 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbXAEXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:13:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SJ9NyUJDzKzfp1fjZHR7tU53XqaY1majoZ+QtZLtEWW2eT4ZcaRP0Y2rXFFSK32E2AcRJCpWnahGaMJ8oL6x0I1J34Upo46o7/go9SECxU+7MZH7vPRsQlLtwdakGcfgqsSDgc5KUI78u39V9gv9LqaGJOILbH4UWCFLlkeYpu0=
Message-ID: <cd32a0620701051513i41e19d13k53d08d123980a717@mail.gmail.com>
Date: Sat, 6 Jan 2007 09:43:14 +1030
From: "Tom Lanyon" <tomlanyon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: runaway loop modprobe binfmt-0000
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm encountering a rather annoying error on one of our AMD Opteron
boxes. I recompiled the working 2.6.17 kernel to add some extra SCSI
support and booted to find something similar to:

usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
device-mapper: multipath emc: version 0.0.3 loaded
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 324k freed
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000

... and then a hung kernel.

I figured I'd enabled/disabled something I shouldn't have and went
through the kernel config many times, recompiling with different
options (including ELF and misc emulation support), but to no avail.

As time ticked closer to 5pm on a Friday my interest decreased and so
I tried upgrading to 2.6.18 and then 2.6.19, with a tonne of different
configurations. Still nothing. The best I could achieve was on a fresh
2.6.19.1 I managed to pass the modprobe and load some input drivers,
but then it hung directly after that.

...
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
input: AT Translated Set 2 keyboard as /class/input/input0
input: PS/2 Generic Mouse as /class/input/input1


Any advice on debugging this would be appreciated. How can I discover
what is trying to load binfmt-0000 and why is it looping?

Regards

-- 
Tom Lanyon
