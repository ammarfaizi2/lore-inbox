Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTJVQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTJVQgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 12:36:25 -0400
Received: from rebo.lancs.ac.uk ([148.88.16.230]:25062 "EHLO rebo.lancs.ac.uk")
	by vger.kernel.org with ESMTP id S263480AbTJVQgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 12:36:22 -0400
Message-ID: <3F96B203.4060808@lancaster.ac.uk>
Date: Wed, 22 Oct 2003 17:36:19 +0100
From: Alex Finch <A.Finch@lancaster.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Single P4, many IDE PCI cards == trouble??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  For what it's worth, here is my experience. Hope it helps you, and 
anyone else searching for solutions to the problems I have encountered...


  Our New Server
  ==============

(+ Lessons learnt along the way)
   ++++++++++++++++++++++++++++++

Motherboard: Asus P4S8X-X

CPU:         Intel Pentium 4 2400MHz

Memory:     2 x 512Mb PC2700
  +was supposed to be 3x512Mb but the motherboard can't handle 3xPC2700
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Network:     3Com  3c905C-TX/TX-M [Tornado]

             Do NOT use the onboard LAN - performance is diabolical!
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


Additional controller cards:

	   2xPromise Ultra133 Tx2 PCI-IDE cards
	   1xPromise Ultra66      PCI-IDE card

   Do note use 3 identical Promise IDE cards, either system will not
   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  boot or there will be i/o errors!
  ++++++++++++++++++++++++++++

Disks
=====
  (In addition to system disk)

  10 x Maxtor 6Y060L0 60Gb
           attached to onboard ide and Promise Ultra133 cards
  4  x Maxtor 4A250J0 240Gb disk
           attached to Promise Ultra66 cards


Software:

  RedHat 9
  kernel  2.4.20

  Boot parameters modified as follows:

Edit  /boot/grub/menu.lst
and append
  ide2=noautotune ide3=noautotune ide4=noutotune ide5=noautotune
ide6=noautotune ide7=noautotune
to the line
  kernel /boot/vmlinuz-2.4.20-8 ro root=LABEL=/

  this avoids errors of the type:
  ++++++++++++++++++++++++++++

  hdh: dma_intr: bad DMA status (dma_stat=75)

  when accessing the disks on the Promise cards
					
					
  Thereafter formatted disks/created raid arrays/started raid/made 
filesystem no problem.   Four 240Gb disks formatted as one big disk via 
raid0!
  (/dev/md8 Size=989GB)			
					
Tape drive: Spectra Logic 2000 (a.k.a. TreeFrog) attached via
              Adaptec AIC-7892A SCSI card
             Use mtx version 1.2.17rel to drive the robot, more recent
            versions cause problems (author informed).
					
			

  Alex Finch, Research Fellow, Physics Department, Lancaster University.

  NB ( I am not subscribed to the list so contact me directly for more
information)

