Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWDHRhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWDHRhq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWDHRhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:37:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29569 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965033AbWDHRhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:37:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4437F493.9000803@s5r6.in-berlin.de>
Date: Sat, 08 Apr 2006 19:36:19 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-user@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Data about Apple iPod, Mac, Powerbook, iBook needed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.842) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a number of Apple iPods have buggy firmware which report a wrong disk 
size when plugged in. This may lead to I/O errors, making the iPod 
inaccessible under Linux. I have been told this happens especially if 
the kernel is configured for EFI partition support.

The USB storage driver already contains a workaround for several iPod 
models. We need to add the same to the FireWire storage driver (sbp2). 
Alas we cannot use the same model IDs like usb-storage to detect whether 
a disk is actually an iPod. In particular, sbp2 must be able to 
distinguish between iPods and Apple Macs or Powerbooks or iBooks which 
are attached to a Linux box in "target disk mode".

Therefore I need help from people who have a FireWire iPod and a Linux 
box with FireWire port:

1. Please plug it in via FireWire and report the output of
    $ cat /sys/bus/ieee1394/devices/000a27*-0/model_id
    and of
    $ dmesg | grep "hdwr sectors"
2. If it is an USB/FireWire combo iPod, please also plug it in
    via USB and report the output of
    $ dmesg | grep "hdwr sectors"
I would also like to know the model of iPod (i.e. generation of iPod) 
and the version of the Linux kernel.

I also need help from people who have an Apple Mac or Powerbook or iBook 
and a Linux box with FireWire port:

A. On the Linux box, unload the sbp2 driver:
    # modprobe -r sbp2
    Reload it with the following parameter:
    # modprobe sbp2 force_inquiry_hack=1
    Also make sure that ohci1394 is loaded. (Check with lsmod. Some
    rare host adapters need pcilynx instead oh ohci1394.)
B. Reboot the Apple and hold the "t" key. This boots the Mac into
    "target disk mode", i.e. lets it expose its built-in HDD as a
    FireWire disk. The "t" key can be released when a big FireWire
    symbol is shown on the screen.
C. Connect the Mac and the Linux box via FireWire. The sbp2 driver
    should now log in into the Mac, which will be shown in the kernel
    log as well as in /proc/scsi/scsi. Please report the output of
    $ dmesg | grep firmware_revision
D. The Mac can be unplugged and normally rebooted after this.

Thanks in advance to everyone who takes the time to collect these data.
-- 
Stefan Richter
-=====-=-==- -=-- -=---
http://arcgraph.de/sr/
