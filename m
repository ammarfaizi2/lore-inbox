Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135613AbRD1Tbq>; Sat, 28 Apr 2001 15:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135614AbRD1Tbi>; Sat, 28 Apr 2001 15:31:38 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:24985 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135613AbRD1TbW>; Sat, 28 Apr 2001 15:31:22 -0400
Date: Sat, 28 Apr 2001 12:31:16 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH(??): linux-2.4.4/drivers/scsi/pci2220i.c referred to undefined routine scsi_set_pci_info
Message-ID: <20010428123116.A1389@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.4 changes one line in drivers/scsi/pci2220i.c that
used to call scsi_set_pci_device to call the undefined routine
scsi_set_pci_info.  That is the only change to pci2220i.c in linux-2.4.4.
I don't know what the intention of this change was.  Perhaps a renaming
of scsi_set_pci_device is in the works, or perhaps somebody accidentally
deleted a line in an editor and decided to try typing it in from memory.
Anyhow, if reversing that change is the correct course of action, here
is a patch to that effect.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci2220i.diff"

--- linux-2.4.4/drivers/scsi/pci2220i.c	Fri Apr 27 13:59:19 2001
+++ linux/drivers/scsi/pci2220i.c	Sat Apr 28 01:16:37 2001
@@ -2657,7 +2676,7 @@
 		for ( z = 0;  z < BIGD_MAXDRIVES;  z++ )
 			DiskMirror[z].status = inb_p (padapter->regScratchPad + BIGD_RAID_0_STATUS + z);		
 
-		scsi_set_pci_info(pshost, pcidev);
+		scsi_set_pci_device(pshost, pcidev);
 		pshost->max_id = padapter->numberOfDrives;
 		padapter->failRegister = inb_p (padapter->regScratchPad + BIGD_ALARM_IMAGE);
 		for ( z = 0;  z < padapter->numberOfDrives;  z++ )

--PNTmBPCT7hxwcZjr--
