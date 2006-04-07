Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWDGUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWDGUal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWDGUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:30:40 -0400
Received: from mx27.mail.ru ([194.67.23.63]:59397 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S964931AbWDGUaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:30:15 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-ide@vger.kernel.org
Subject: HDIO_SCAN_HWIF causes hwif to "forget" PCI parent
Date: Sat, 8 Apr 2006 00:30:06 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604080030.07236.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have notebook with ALi IDE interface:

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)

One of scripts called on Mandriva during suspend/resume calls hdparm -U for 
hdc on suspend and hdparm -R on resume.

Now, hdparm -U (HDIO_UNREGISTER_HWIF) completely wipes out hwif reinitializing 
it. It means, that also hwif->pci_dev is nulled. On hdparm -R 
(HDIO_SCAN_HWIF) it basically calls hwif_register without initializing 
pci_dev which means hdc appears in sysfs in different place:

before

lrwxrwxrwx  1 root root 0 Apr  7 23:53 /sys/block/hdc/device 
- -> ../../devices/pci0000:00/0000:00:04.0/ide1/1.0/

after

lrwxrwxrwx  1 root root 0 Apr  7 23:53 /sys/block/hdc/device 
- -> ../../devices/ide1/1.0/

this slightly confuses udev that receives a new path and regenerates cdrom 
links (OK this is no more kernel problem but how I noticed it in the first 
place :) so what has been cdrom0 before suddenly becomes cdrom1.

Looking at ide.c, I do not see any obvious ways to fix it. I appreciate any 
hint how this can be fixed; alternatively if libpata does not have this issue 
I am ready to test it.

Thank you

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFENsvPR6LMutpd94wRAjFNAJ0VsKOZZOKn6/SIilrblrXuj4eGhgCePEnm
VP+KZQOGbpye9esLG6lSC/k=
=VXbN
-----END PGP SIGNATURE-----
