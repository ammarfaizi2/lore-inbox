Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBSMrI>; Mon, 19 Feb 2001 07:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbRBSMqr>; Mon, 19 Feb 2001 07:46:47 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:1037 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129071AbRBSMqj>;
	Mon, 19 Feb 2001 07:46:39 -0500
Date: Mon, 19 Feb 2001 13:45:57 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Flusing caches on shutdown
To: linux-kernel@vger.kernel.org
Message-id: <3A911585.E0A8006E@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(( CC me the replies, as I'm not subscribed to LKML ))

Hi!

It is a good idea IMO to flush the write cache of storage devices
at shutdown and other critical moments.
I browsed through linux-2.4.1 and see no use of the SYNCHRONIZE CACHE
SCSI command ( curiously it is defined in several other files
besides include/scsi/scsi.h , grep returns :
drivers/scsi/pci2000.h:#define SCSIOP_SYNCHRONIZE_CACHE 0x35
drivers/scsi/psi_dale.h:#define SCSIOP_SYNCHRONIZE_CACHE        0x35
drivers/scsi/psi240i.h:#define SCSIOP_SYNCHRONIZE_CACHE 0x35
)

I couldn't find evidence to the use of the equivalent ATA command either
( FLUSH CACHE , command code E7h ).
Also add ATAPI to the list. ( and all other interfaces. I checked just SCSI
and ATA )

Loosing data at powerdown due to write caches have been reported,
so this is no a theoretical problems. Also the journaled filesystems
are safe only in theory if the journal is not stored on non-volatile
memory, which is not guarantied in the current kernel.

What is the official word on this issue ?
I think this is important to the "enterprise" guys, at the least.

Sincerely,
david

PS: CC me , as I'm not subscribed to LKML
-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
