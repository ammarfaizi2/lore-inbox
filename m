Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130381AbRCWIIv>; Fri, 23 Mar 2001 03:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRCWIIl>; Fri, 23 Mar 2001 03:08:41 -0500
Received: from MEREDITH.DEMENTIA.ORG ([128.2.120.216]:28683 "EHLO
	meredith.dementia.org") by vger.kernel.org with ESMTP
	id <S130317AbRCWIIe>; Fri, 23 Mar 2001 03:08:34 -0500
Date: Fri, 23 Mar 2001 03:07:46 -0500
From: Derrick J Brashear <shadow@dementia.org>
To: linux-kernel@vger.kernel.org
Subject: athlon+2.2+pdc20267=hang?
Message-ID: <18520000.985334866@skittlebrau.trafford.dementia.org>
X-Mailer: Mulberry/2.0.6b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today I swapped an Athlon (tbird) 850 and an Epox 8KTA3 in for the 
dual Celeron I had, moving all the cards into the new system. One of these 
was a Promise PDC20267 with 4 40gb disks attached. The machine would not 
boot; I assumed it was the i686-smp kernel and installed a Redhat 
7.0-provided i386 kernel. Several hours and a dozen or so boots later, it 
looks like when the bios on the PDC20267 is installed, the system hangs 
while booting at the point where it would probe C/H/S from the devices 
attached to the PDC20267 (they've already been identified by that point)

Short and sweet: The goal is to run 2.2.18+ide.2.2.18.02122001 with the 
PDC20267 installed and all the disks attached; I assume this is possible 
and I'm missing something obvious, since the controller and disks worked in 
the dual Celeron, and I'm hoping someone has an idea what I'm missing.

Long and boring:
-Tried 2.2.18+ide.2.2.18.1209 built for i386, i586, i586tsc, and i686 
uniprocessor, all resulted in a system hang at the time when hd{e,f,g,h} 
would be probed and C/H/S info printed

-Tried 2.2.18+ide.2.2.18.02122001 built for i586, same result.
-Removed PDC20267, above kernel worked
-Attached PDC20267 and removed disks, above kernel worked
-Tried each of the 2 buses in turn, failed as above
-Tried 2.2.17 without ide patch, specifying ide2=0xac00,0xb002 at boot 
time, failed as above

Based on this and noting the PDC20267 didn't install its bios when no 
devices were attached to it, I assume that is the contention.

Device identifies itself thus:
  Bus  0, device   8, function  0:
    Unknown mass storage controller: Promise Technology Unknown device (rev 
2).
      Vendor id=105a. Device id=4d30.
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
      I/O at 0xac00 [0xac01].
      I/O at 0xb000 [0xb001].
      I/O at 0xb400 [0xb401].
      I/O at 0xb800 [0xb801].
      I/O at 0xbc00 [0xbc01].

