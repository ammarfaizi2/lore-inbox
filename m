Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRD1VWA>; Sat, 28 Apr 2001 17:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRD1VVu>; Sat, 28 Apr 2001 17:21:50 -0400
Received: from cs.columbia.edu ([128.59.16.20]:38884 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131205AbRD1VVc>;
	Sat, 28 Apr 2001 17:21:32 -0400
Date: Sat, 28 Apr 2001 14:21:29 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.2.19 locks up on SMP
Message-ID: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Over the last week I've tried to upgrade a 4-CPU Xeon box to 2.2.19, but 
the it keeps locking up whenever the disks are stresses a bit, e.g. when 
updatedb is running. I get the following messages on the console:

wait_on_bh, CPU 1:
irq:  1 [1 0]
bh:   1 [1 0]
<[8010af71]>

over and over again, until somebody pushes the reset button.  8010af71 is 
somewhere in the middle of synchronize_bh().

The hardware configuration is: 4 Xeon/500MHz, 1GB RAM, 3 SCSI disks
attached to a symbios controller, 2 eepro100 interfaces. The kernel is
compiled with support for SMP and 2GB of RAM (hence the kernel address
starting with 8 instead of c).  It was compiled from a pristine source
tree, no patches were applied.

I had more problems with 2.2.19 and another SMP box, which was also 
locking up under stress. I'm not sure if it had the same messages on the 
console, since it's headless, but it was running the same 2.2.19 kernel as 
the previous one and was locking up in a very similar fashion. The 
hardware in that box is 2 P-III/750MHz, 512MB RAM, 1 IDE disk on a PIIX 
controller, and an unused aic7xxx SCSI controller with no SCSI devices 
attached to it.

Both boxes are rock-solid when running 2.2.18-SMP.

Any ideas? Has anybody else reported this with 2.2.19?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

