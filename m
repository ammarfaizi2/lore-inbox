Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHYL3E>; Sat, 25 Aug 2001 07:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbRHYL2y>; Sat, 25 Aug 2001 07:28:54 -0400
Received: from pop09-acc.tin.it ([212.216.176.72]:6558 "EHLO fep19-svc.tin.it")
	by vger.kernel.org with ESMTP id <S268861AbRHYL2q>;
	Sat, 25 Aug 2001 07:28:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: linux-kernel@vger.kernel.org
Subject: devfs support for the USB scanner driver
Date: Sat, 25 Aug 2001 13:28:57 +0200
X-Mailer: KMail [version 1.2]
Cc: dnelson@jump.net
MIME-Version: 1.0
Message-Id: <01082513285700.00695@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is my first message here and I am a little bit intimidated: 
I'm not new to software hacking but the Linux kernel is a different 
matter. Please be nice. :-)

I switched to devfs yesterday and I had to patch the USB scanner driver 
because it didn't support devfs. *Then* I looked around and I discovered 
that this patch has already been done twice: one comes from Pavel Roskin 
(see http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.1/0079.html)
and another is in the 2.4.8-ac6 kernel. Note however that the latter is 
incorrect because it supports only one scanner: devfs_register() is given 
the name "scanner" instead of "scanner%d" (with %d = minor).

This patch is trivial and definitely useful so I would argue that it 
should go into the official kernel soon.

Two questions/requests for comments:
1. Where should one call devfs_unregister()? Pavel's patch calls it in 
close_scanner() and disconnect_scanner(), but I believe you only need to 
do it in disconnect_scanner() where the scn_usb_data structure is kfree'd.

2. Which default permissions should apply to the device files? The printer 
driver used 660 and that's OK because only the printer daemon will usually 
talk to the device, but I think 666 is preferable for the scanner because 
in general it will be used by users (no pun intended). The patch in 
2.4.8-ac6 uses 660, the other patch uses 664.

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
