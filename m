Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTFHC22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 22:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFHC22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 22:28:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:52645 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264198AbTFHC20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 22:28:26 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: linux-kernel@vger.kernel.org
Subject: Linksys WRT54G and the GPL
Date: Sat, 7 Jun 2003 22:41:23 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306072241.23725.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Sorry for the very lengthly posting, but I want to be as precise as possible 
in describing this problem.

Awhile ago, I mentioned that the Linksys WRT54G wireless access point used 
several GPL projects in its firmware, but did not seem to have any of the 
source available, or acknowledge the use of the GPLed software.  Four weeks 
ago, I spoke with an employee at Linksys who confirmed that the system did 
use Linux, and also mentioned that he would work with his management to 
ensure that the source was released.  Unfortunately, my e-mails to this 
individual over the past three weeks have gone unanswered.  Of course, I also 
tried contacting Linksys through their common public e-mail accounts 
(pr@linksys.com, mailroom@linksys.com) to no avail.

However, it is hard for me to know if my contact in the company has just gone 
on a three week vacation (and not set an auto-responder), or has been asked 
to not answer anymore mail on this subject.  Also, I should note that I don't 
own this product, so I can't determine if the source is shipped with it.  
However, I have gone through all the available information on the Linksys 
website, and can find no reference to the GPL, Linux (as it relates to this 
product), or the firmware source code.  Also, the firmware binary (see below) 
is freely available from their website.  There is no link from the download 
page to the source, or any mention of Linux or the GPL.  Finally, it would be 
strange if the source was included in the physical package, as my contact at 
Linksys was initially unaware Linux was used in this product.



The following steps can be used to determine the exact nature of the possible 
GPL violation.

1. Go to the following URL:
    http://www.linksys.com/download/firmware.asp?fwid=178

2. Download the "firmware upgrade files":     
ftp://ftp.linksys.com/pub/network/WRT54G_1.02.1_US_code.bin
    (MD5SUM: b54475a81bc18462d3754f96c9c7cc0f)

3. While it is downloading, confirm that there is nothing on the webpage to 
indicate that this binary contains GPLed software.

4. Once the download is complete, copy the contents of the file from offset 
0xC0020 onward into a new file.
    dd if=WRT54G_1.02.1_US_code.bin of=test.dump skip=24577c bs=32c

5. Notice that this file is an image of a CramFS filesystem.
    Mount it.

6. Explore the filesystem.  You will notice that the system appears to be 
based on Linux 2.4.5.
   Incidentally, there is at least one other GPLed project in the firmware: 
the BusyBox userland component: (http://www.busybox.net/)

7. The Linux kernel (I think) is mixed up with a bunch of other stuff in:
    bin/boot.bin



You might want to know why I am interested in getting the code for the kernel 
used in this device.

There's been some discussion here about Linux's lack of wireless support for a 
few of the newer 802.11b and (nearly?) all 802.11g chips.  Incidentally, 
Linux has excellent support for at least one manufacturer's wireless family.  
The following Broadcom chips all appear to be supported under Linux -- if you 
happen to be running Linux on a MIPS processor in a Linksys router:

Broadcom BCM4301 Wireless 802.11b Controller
Broadcom BCM4307 Wireless 802.11b Controller
Broadcom BCM4309 Wireless 802.11a Controller
Broadcom BCM4309 Wireless 802.11b Controller
Broadcom BCM4309 Wireless 802.11 Multiband Controller
Broadcom BCM4310 Wireless 802.11b Controller
Broadcom BCM4306 Wireless 802.11b/g Controller
Broadcom BCM4306 Wireless 802.11a Controller
Broadcom BCM4306 Wireless 802.11 Multiband Controller

This list was produced by running strings on:
lib/modules/2.4.5/kernel/drivers/net/wl/wl.o

I am trying to determine exactly how tightly coupled these drivers are to the 
kernel.

As an aside, I know that some wireless companies have been hesitant of 
releasing open source drivers because they are worried their radios might be 
pushed out of spec.  However, if the drivers are already written, would there 
be any technical reason why they could not simply be recompiled for Intel 
hardware, and released as binary-only modules?



Finally, I know that traditionally, Linux has allowed binary-only modules.  
However, I was always under the impression that this required that the final 
customer be allowed to remove them at will.  That is to say, you couldn't 
choose to implement a portion of the kernel critical to the system's 
operation in a module, and then not release that module under the GPL.  In 
this particular case, I would argue that the wireless drivers are critical to 
this device's operation (after all, it is a wireless access point).  In 
addition, the final user in this case really can't just "rmmod" the wireless 
driver.

The Broadcom driver, kernel, and really everything else in the firmware, are 
(IMHO anyways) being used to form a discrete package -- the WRT54Gs firmware.  
Does/should this have any implication on whether the Broadcom wireless module 
must be covered by the GPL?



I would be very interested in knowing if I am mistaken in any of my claims or 
conclusions, and if not, how I should proceed in getting this issue resolved.


-- Andrew Miklas


