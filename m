Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUECPk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUECPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUECPk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:40:57 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:33522 "EHLO cpmx.saic.com")
	by vger.kernel.org with ESMTP id S263756AbUECPkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:40:32 -0400
Subject: SATA device timeout using libata
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1083598803.5386.48.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 16:40:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently building a system with ~1TB raid5 array using SATA drives.
Currently, I'm using 3 SiL-3112 dual-port SATA controller, each with 2 x
200GB drives on them.

One controller has 2 X WDC WD2000JD-00G drives which seem to work
perfectly, another has 2 X Maxtor 6Y200M0 which also seem to work fine,
however the the third pair of drives are WDC WD2000JD-00F and these seem
to deliver issues.

Basically, when attempting to stress a RAID-5 array while the array is
synchronising, I get the following after an hour or so:   

ata3: DMA timeout, stat 0x1
ATA: abnormal status 0xD0 on port 0xE087B087
scsi2: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 01 92 8d 47 00
00 08 00
Current sdc: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdc, sector 26381639
ATA: abnormal status 0xD0 on port 0xE087B087
ATA: abnormal status 0xD0 on port 0xE087B087
ATA: abnormal status 0xD0 on port 0xE087B087

This is using 2.6.6-rc3-bk4 with the latest update patch from Jeff
Garziks directory for the libata stuff. This is actually much improved
over 2.4.25 using the siimage drive and 2.6.5 stock using both the
siimage driver and libata, which fell over after a few minutes.

The interesting part here is that the hardware checks out fine using the
manufacturers test disk in the same configuration, and having recabled
and moved controllers around, it appears that it always follows these
particular drives. 

Is anybody aware of a firmware update for these beasts, or any known
issues on them? 

Any suggestions gratefully received :)

Cheers,
Eamonn

