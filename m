Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVGBOOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVGBOOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVGBOOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:14:12 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:6061 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261169AbVGBOOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:14:03 -0400
Message-ID: <42C6A12A.8030009@free.fr>
Date: Sat, 02 Jul 2005 16:14:02 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ide-cd and bad sectors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use 2.6.12 vanilla kernel.

Since some time when a disk has bad sector because it is damaged or 
overburned, the Linux kernel seem too hang for this device :
the process reading is unkillable (even with SIGKILL).
the kernel seem to try to read the next sectors, but always failed.

The only way to stop the kernel trying to read the disc is to reboot or 
don't lock the drive and eject it, with the button on the device.

When hard-ejecting it, there are something strange in the log : the 
kernel failed for 508 sector (is there a so big cache for disk request ? 
If this is the case that explain why the kernel seem too hang as it need 
1-2s per bad sector).
Also at the end of the log [1] you could see that the 2 last message 
report error for the first sectors that produce the error. Is that 
normal : I thought this sector already produced an "media error (bad 
sector)" and should be skipped ?


Also I was wondering if all the sector that ide-cd failed to read are 
bad sector, or if ide-cd failed to put the drive in a consistent state 
for reading the next sector after corrupted one.

IIRC on 2.4 kernel there wasn't such problem, I even managed to recover 
some damaged disk...

thanks

Matthieu


[1]
Jul  2 15:10:13 localhost kernel: hdc: media error (bad sector): 
status=0x51 { D
riveReady SeekComplete Error }
Jul  2 15:10:13 localhost kernel: hdc: media error (bad sector): 
error=0x30 { La
stFailedSense=0x03 }
Jul  2 15:10:13 localhost kernel: ide: failed opcode was: unknown
Jul  2 15:10:13 localhost kernel: end_request: I/O error, dev hdc, 
sector 119095
12
Jul  2 15:10:13 localhost kernel: printk: 105 messages suppressed.
Jul  2 15:10:13 localhost kernel: Buffer I/O error on device hdc, 
logical block
2977378
Jul  2 15:10:17 localhost kernel: hdc: media error (bad sector): 
status=0x51 { D
riveReady SeekComplete Error }
Jul  2 15:10:17 localhost kernel: hdc: media error (bad sector): 
error=0x30 { La
stFailedSense=0x03 }
Jul  2 15:10:17 localhost kernel: ide: failed opcode was: unknown
Jul  2 15:10:17 localhost kernel: end_request: I/O error, dev hdc, 
sector 119095
16
[...]
Jul  2 15:12:03 localhost kernel: hdc: tray open
Jul  2 15:12:03 localhost kernel: end_request: I/O error, dev hdc, 
sector 119100
16
Jul  2 15:12:03 localhost kernel: hdc: tray open
Jul  2 15:12:03 localhost kernel: end_request: I/O error, dev hdc, 
sector 119100
20
Jul  2 15:12:03 localhost kernel: hdc: tray open
Jul  2 15:12:03 localhost kernel: end_request: I/O error, dev hdc, 
sector 119095
12
Jul  2 15:12:03 localhost kernel: hdc: tray open
Jul  2 15:12:03 localhost kernel: end_request: I/O error, dev hdc, 
sector 119095
16
