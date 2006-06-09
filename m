Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWFIKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWFIKsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFIKsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:48:02 -0400
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:61593 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932347AbWFIKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:48:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xmYdV6G6/upovbe/t2I66wP+kGXSCULhrG7BHyv/ZVjy8KYxcgyY932WjczOQfvZ9mpy8miU1DeugNa3xZ4PwDJrtoDvX7Ik5tmTY1ucMtKnzW2+59Z2HA8op28pI7wN02hLaSEqmIuOqssPr4Gd/QIBOPw3KDb873rx4WogFq8=  ;
Message-ID: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Date: Fri, 9 Jun 2006 12:47:59 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [RFC] ATA host-protected area (HPA) device mapper?
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jeff@garzik.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> libata should -- like drivers/ide -- call the ATA "set max" command to 
> fully address the hard drive, including the special "host-protected 
> area" (HPA).  We should do this because the Linux standard is to export 
> the raw hardware directly, making 100% of the hardware capability 
> available to the user (and, in this case, Linux-based BIOS and recovery 
> tools).
> .....
> Comments?  Questions?  Am I completely insane?  ;-)

  Your hard disk is a lot more powerfull than what you think, only very old
 hard disks only have ATA set max command. Nowadays, you can not only set the
 maximum size of the hard disk by HPA, but you can also protect the change of
 the HPA by password and even freeze the HPA (i.e. unmodifiable without power
 cycle).
  Changing the accessible size of the disk using the HPA is relatively safe
 because the disk is still reporting it complete size, so the BIOS and Linux
 do not have disks changing their size during use.

  You can also read and write the configuration of the hard disk, and so hide
 the fact that your hard disk has the HPA feature, change the real size of
 the hard disk (so hide the end, and none of Linux or the BIOS will know the
 hidden part) independantly of the HPA, make the HPA area appear as a complete
 hard disk by offseting the LBA (for a safety recovery), manage the noise
 level and protect the content of the disk by password.

  All this is documented in the ATA specification, available for free at least
 at http://www.t13.org/. If you want a (GPL only) source code showing how to
 use it, have a look at the Gujin bootloader at http://gujin.org : in the way
 I am using it, the bootloader installs itself into an HPA and keep a copy of
 the current MBR in the HPA so is nearly indestructible, if the MBR is
 overwritten another floppy or CDROM booting with Gujin will propose to restore
 the MBR. You may want to run a DOS floppy, run the gujin provided dbgdisk.exe,
 go to the setup menu and enable IDE probing, go back to the kernel selection,
 and exit the dbgdisk.exe software by ^C. Then, have a look at the "A:\DBG" file
 created to see what your hard disk is reporting.
 Gujin can also install in a partition if there is no unused space after your
 extended partition at the end of the disk to create a HPA.

 Gujin also do the absolutely needed setup of the IDE hard disk which is to freeze
 the password system _and_ the config system of all the IDE hard disks present, so
 that no virus can put a random password and send you an E-mail with the address
 where to send the money to get the password to unlock the hard disk and so access
 again your data. Again, freezing means no more modifiable until next power cycle,
 so IMO it is the job of the bootloader to setup the hard disk, before running
 anything like Linux, a commercial OS, a bootable CDROM...

 Gujin is assuming that your hard disk are accessible by the documented ATA ide
 system, and some (or all?) IDE SATA interface have (volumtary?) broken
 implementation: they are not IDE register compatible.
 If you buy broken hardware, Gujin will not help you and cannot take care of the
 details for you - it is another win{modem,video,sensor} device.

 Etienne.

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
