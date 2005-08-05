Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVHEJuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVHEJuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVHEJue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:50:34 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:60577 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262940AbVHEJuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:50:03 -0400
Message-ID: <2014.192.168.201.6.1123235400.squirrel@www.masroudeau.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C341EB82@scl-exch2k3.phoenix.com>
References: <0EF82802ABAA22479BC1CE8E2F60E8C341EB82@scl-exch2k3.phoenix.com>
Date: Fri, 5 Aug 2005 10:50:00 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: RE: IDE disk and HPA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  Note that this HPA is a good place to store a bootloader too, in fact
>> I like to think of it as the big floppy drive of the PC which no more
>> have any floppy drive: create a FAT filesystem of 64 Mbytes there and
>> copy all the floppy you used to have there. Your bootloader, if it
>> is good enough, will be able to run software from this area.
>
> If your bootloader if the first thing to run in the system, you can
> use & protect portion of your hardrive for yourself - just make sure you
> lock with set max with password when passing control to 'normal'
> OS/loader.
>
> Aleks.

  When my bootloader is installed in an HPA protected partition
 containning a filesystem (instead of a real primary or extended
 partition), it is by default not only protecting the HPA by
 password but also freeze it.
 To run a trusted application which needs an unprotected IDE disk,
 you need to have the application in the KGZ kernel form
 (elf -> objdump -> gzip with the right IDE comment), see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112134577732513
 And also uncheck the "ignore kernel IDE options" box in setup.

  The problem is that you cannot really modify the disk size by
 the IDE configuration command because BIOS react badly to disks
 which change their number of LBA after boot, so the bootloader
 cannot be really transparent. Moreover, if the bootloader is
 completely hidden, people try to install multiple times the
 bootloader when they just want to upgrade it - and it does not
 work as intended.
  The bootloader can still be configured to set the disk size
 to the one declared in the MBR if needed and if the IDE disk
 is currently able to modify its own number of LBA. Same for HPA,
 if it finds the HPA frozzen - maybe because it has chainloaded
 itself - it will not try to modify the HPA.
  Note that the frozzen state I am speaking of here have nothing
 to do with the "IDE security freeze" command needed before running
 any OS to protect against disk2brick/blankdisk viruses.

  Etienne.

