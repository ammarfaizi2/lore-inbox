Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUFVGpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUFVGpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 02:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUFVGp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 02:45:28 -0400
Received: from guardian.hermes.si ([193.77.5.150]:29703 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S261159AbUFVGpP
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 02:45:15 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC06FA@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'Riley@Williams.Name'" <Riley@Williams.Name>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>
Cc: "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: EDD code causes long boot delay
Date: Tue, 22 Jun 2004 08:45:00 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I first posted this under the title "Grub 1 troubleshooting, linux boot
delayed problem" to the LKML
( see http://lkml.org/lkml/2004/6/11/29 ), but since the discovered that
this is a kernel problem,
the CONFIG_EDD code, to be more exact. Here I repeat the simptoms :

I use the commands ( in the grub shell that boots from my HD ):
root (hd0,0)
kernel /vmlinuz-2.6.xxx ro root=dev/hda2
initrd /initrd-2.xxx
boot

After entering the "boot" command, the screen is cleared and then nothing
happens for 93 seconds.
After that linux boot normally ( beginning with the message "Uncompressing
linux..." and so on ).
If I trim the kernel command line to only "kernel /vmlinuz-2.6.xxx ro" ,
then the delay is 10 seconds.

If I change the operating mode of the IDE adapter in BIOS to RAID, then the
delay is infinite ( I waited 8 hours and it still did not print
"Uncompressing
linx ...." ). Note that with this option, there is no real difference, since
the
disks are not mirrored or striped or anything. GRUB can read everything just
fine.

I tested all kernels ( vanilla Linus release from kernel.org ) from 2.6.0 to
2.6.7
and saw that the problem appeared in 2.6.3. Then I found out that that the
cause
is the CONFIG_EDD option, if I turn it off, then linux-2.6.7 boot without
the mentioned
delay.

So, is there some bug in the EDD code ? A BIOS bug ? Any other comment ?

My hardware is a Gigabyte GA-7 VAXP Ultra motherboard ( see 
http://www.giga-byte.com/MotherBoard/Products/Products_GA-7VAXP%20Ultra.htm
)
BIOS version is F6.
Disks : 
 - Quantum lct20 20 GB
 - IBM Deskstar 120GXP 60 GB
Both on the Promise PDC 20276 on-board controller, each on its own
channel(cable).

Regards,
David Balazic
----------------------------------------------------------------------------
-----------
http://noepatents.org/           Innovation, not litigation !
---
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------








