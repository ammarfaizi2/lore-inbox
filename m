Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310604AbSCLMOv>; Tue, 12 Mar 2002 07:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310728AbSCLMOm>; Tue, 12 Mar 2002 07:14:42 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:24274 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S310656AbSCLMOa>; Tue, 12 Mar 2002 07:14:30 -0500
Message-Id: <5.1.0.14.2.20020312114329.0273b810@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 12 Mar 2002 12:18:53 +0000
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: BIO broke non-DMA cdrom all 2.5.x kernels from BIO start till
  2.5.6 affected!
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201150744420.767-100000@dd.tc.fluke.com>
In-Reply-To: <20020115101951.A31257@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

I went on a holiday for two weeks and had a 2.5.x bitkeeper tree with me on 
my laptop. I discovered my cdrom doesn't work. "ls" works fine but doing 
"cp -r /mnt/cdrom/* /tmp/" gives masses of underruns so I can't use my 
cdrom at all.

Using the beauty of bitkeeper I started cloning/undoing using a binary 
search pattern to determine _which_ kernel patch broke my cdrom.

I suspected the taskfile IDE patches so I centered around that at first but 
in the end I found that the very first introduction of the BIO patches 
broke it and it has never worked since.

2.2.16-3: works
2.4.x for various x (even ones after the 2.5.0 split): work
2.5.0 and 2.5.1-pre1: work
2.5.1-pre2 and later break up to and including 2.5.6 (and I tried a _lot_ 
of them!, full list available on request...)

(2.5.5-pre1 didn't even boot hanging in partition discovery on the very 
first attempt to read from disk as verified by a few printk()s, but 2.5.6 
boots ok so that has been fixed.)

For the laptop: it is an old Pentium 200MMX, with an Opti IDE controller 
(laptop is Viper chipset, I am compiling in Opti IDE support in the kernel, 
otherwise kernel doesn't boot). hda is a 6GB hd and hdb is the cdrom. 
Enabling DMA on either device kills the system instantly (lost interrupt 
and good bye, no recovery possible or perhaps I never waited long enough) 
so no dma enabled, but multi mode is enabled (I set it to 8 sectors with 
hdparm). Unmask IRQ is disabled as that also causes problems (those started 
when the taskfile patches went in but I just disabled it at that point and 
didn't think about it anymore after that and I haven't tried to enable it).

Also I _sometimes_ see the "timer added twice" error from IDE during boot 
(e.g. in 2.5.4-pre1 for example, happens at random points during boot 
process, does not always occur, never occurs more than once) but once the 
system is up and I have set multi mode to 8 sectors I never see the error 
again even if I am doing heavy bitkeeper and concurrent kernel compile 
activities. (Laptop only has 48MB RAM so it swaps/has to reload data from 
disk a lot.)

I think you may or may not have had a patch for someone with a related/the 
same problem some time ago (I can't find the mail any more I am thinking 
about so I may be dreaming...). If there is a patch could you mail me the 
patch/or even better a url for it? If not, what details would you like to 
see about my laptop? - I would be very happy to try any patches/ideas you 
have...  Should it become necessary I could provide ssh access to the 
laptop. (It is on a 10mbit lan and I could leave it on&connected around the 
clock.)

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

