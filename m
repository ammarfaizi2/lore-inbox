Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbREPKDt>; Wed, 16 May 2001 06:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbREPKDj>; Wed, 16 May 2001 06:03:39 -0400
Received: from ns.caldera.de ([212.34.180.1]:20947 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261860AbREPKDb>;
	Wed, 16 May 2001 06:03:31 -0400
Date: Wed, 16 May 2001 12:00:16 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: missing release_region in qlogicfas.c
Message-ID: <20010516120016.A31161@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

qlogicfas was missing a release_region in autoprobing too.

Ciao, Marcus

Index: drivers/scsi/qlogicfas.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/qlogicfas.c,v
retrieving revision 1.13
diff -u -r1.13 qlogicfas.c
--- drivers/scsi/qlogicfas.c	2001/05/03 13:16:22	1.13
+++ drivers/scsi/qlogicfas.c	2001/05/16 09:59:04
@@ -563,6 +563,7 @@
 			if ( ( (inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7 )
 			  && ( (inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7 ) )
 				break;
+			release_region(qbase, 0x10 );
 		}
 		if (qbase == 0x430)
 			return 0;
