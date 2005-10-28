Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVJ1Obz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVJ1Obz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVJ1Obz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:31:55 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:57475 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1030199AbVJ1Oby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:31:54 -0400
Date: Fri, 28 Oct 2005 15:31:44 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: hard hang on private mmap? (Or S-ATA hard-hang?)
Message-ID: <Pine.LNX.4.63.0510281440440.6525@sheen.jakma.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with a machine hard-hanging when I run, e.g, 
'apt-cache search ...'. (Other apt commands hang it too).

The machine is:

AMD Athlon 800MHz machine,
Asus K7M (AMD-751 Irongate + Via VT82C686)
ECC RAM,
2 Sil3112A SATA controllers, 3 Seagate SATA disks.

It had been running for 300 days+ when there was a power outage. 
After the outage, a case fan had died and a hard disk had developed 
bad blocks (it was kicked from RAID array - Linux RAID). The fan was 
replaced. The disk was left in the machine in order to scrub it 
before RMA. The machine unfortunately now hard-hangs consistently.

Memtest86+ was run for over 18 hours (completing 18 passes) without 
any failures reported. So it possibly is not RAM related.

If I run 'strace apt-get search ...' from the console in single-user 
mode the last line it prints out is always the same, something like:

mmap2(NULL, 172032, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = .....

Always that size, 172032 (which occurs only a couple of times afaict 
- it's mmaping space to read either the RPM database or APT package 
lists into i think).

This happens with swap disabled. It happens with the duff disk 
removed from the machine. It happens with any of the following Fedora 
kernels:

kernel-2.6.11-1.35_FC3
kernel-2.6.13-1.1532_FC4
kernel-smp-2.6.13-1.1532_FC4

I havn't tried any others.

The keyboard is unresponsive: caps/num lock LEDs unresponsive. 
Doesn't respond to SysRQ. I tried enabling the NMI watchdog 
(nmi_watchdog=2 for lapic NMI), but it doesn't fire either - NMI 
interrupts seem to come in 1/minute when it is running but even 
waiting 5 minutes+ after the hard-hang it doesn't fire. Machine 
appears to be completely wedged.

The machine otherwise seems to work fine, as long I don't run apt 
(I'm using it now). The questions therefore are:

- It seems very much like a hardware problem, right? Or is there any
   chance sata_sil could be locking up (eg in response to hardware
   errors)?

- What hardware though? (RAM? Disk? Sil3112 controller?) If its apt
   specific (only trigger i've found so far) then it might due to
   one of the remaining two disks also having a problem, a problem
   which causes some weird wedge in either the sil3112 hardware or in
   libata sata_sil.

- Any easyish way to get more information from the kernel on what it
   was doing before the wedge? Or was NMI the only hope?

I'm at a loss as to which hardware to start replacing :( to try fix 
this. Any tips, hints would be appreciated. Usually Linux is pretty 
verbose about broken hardware.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"So, do you...like...stuff?"

 	--Ralph Wiggum
 	  I Love Lisa (Episode 9F13)
