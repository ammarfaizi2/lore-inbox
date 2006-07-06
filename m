Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWGFJKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWGFJKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWGFJKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:10:20 -0400
Received: from mx2.mail.ru ([194.67.23.122]:52852 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S965118AbWGFJKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:10:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: CDROMEJECT (or START_STOP(2)) completely disables USB flash stick
Date: Thu, 6 Jul 2006 13:10:04 +0400
User-Agent: KMail/1.9.3
Cc: linux-scsi@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061310.14526.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While working on some HAL issues I hit some not clear - to me at least - 
behavior. I was testing HAL Eject method that under Linux effectively 
calls 'eject /dev/block'. Now for USB stick - at least, that I have, this 
results in "ejecting medium" without apparently any way to get it back (the 
only way is to replug stick).

UEVENT[1152175788.114199] remove@/block/sda/sda1
ACTION=remove
DEVPATH=/block/sda/sda1
SUBSYSTEM=block
SEQNUM=1332
MINOR=1
MAJOR=8
PHYSDEVPATH=/devices/pci0000:00/0000:00:02.0/usb1/1-1/1-1:1.0/host1/target1:0:0/1:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sd

In this state I do see device:

{pts/0}% sudo sdparm -a /dev/sda
    /dev/sda:           128MB             2.00
{pts/0}% cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: 128MB            Rev: 2.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

but any attempt to get partition back results in

{pts/0}% LC_ALL=C sudo blockdev --rereadpt /dev/sda
/dev/sda: No medium found

I tried 'sdparm -C start' without much success as well:

{pts/0}% LC_ALL=C sudo sdparm -v -C start /dev/sda
    /dev/sda:           128MB             2.00
    Start stop unit command: 1b 00 00 00 01 00
{pts/0}% LC_ALL=C sudo blockdev --rereadpt /dev/sda
/dev/sda: No medium found

Well, I just try to understand if this is a expected (and reasonable) 
behaviour or a bug in hardware or possibly software?

Thank you

- -andrey


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFErNN2R6LMutpd94wRAg1DAJ9EITRTZCm/ej5PXzxAK71s7sUCVACgiNFx
KXOuNAwwhPKYcogaK6LgMZM=
=MHVX
-----END PGP SIGNATURE-----
