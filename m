Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRJDNz4>; Thu, 4 Oct 2001 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRJDNzr>; Thu, 4 Oct 2001 09:55:47 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:4131 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S273577AbRJDNzi>; Thu, 4 Oct 2001 09:55:38 -0400
Message-ID: <DCAE0B077C81BE4CA50FD1E225531AE319A13A@AUSXMBT102VS1.amer.dell.com>
From: Anwar_Payyoorayil@Dell.com
To: linux-kernel@vger.kernel.org
Cc: andrew.bond@compaq.com, jamshed.patel@oracle.com, Robert_Macaulay@Dell.com
Subject: [PATCH] 2.4.10-ac4 panics when starting Oracle
Date: Thu, 4 Oct 2001 08:55:49 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below (against 2.4.10-ac4) fixes it.

Anwar.

--- fs/iobuf.c.orig     Wed Oct  3 16:48:18 2001
+++ fs/iobuf.c  Wed Oct  3 17:01:06 2001
@@ -47,6 +47,7 @@
        iobuf->nr_pages = 0;
        iobuf->locked = 0;
        iobuf->io_count.counter = 0;
+        iobuf->end_io = NULL;
 }
 
 int alloc_kiobuf_bhs_sz(struct kiobuf * kiobuf, int sz)



> From: Robert Macaulay (robert_macaulay@dell.com)

> 2.4.10-ac4 will panic when starting Oracle. Oracle mounts the database, 
> and causes the following panic before it finishes with the opening. The 
> kernel is pure 2.4.10-ac4 with the qla2x00 driver patched in. The box has 
> 8GB of RAM. 

> Code: Bad EIP value. 
> >>EIP; 00023384 Before first symbol <===== 
> Trace; c014f4fc <end_kio_request+3c/60> 
> Trace; c0137946 <bounce_end_io_read+b6/170> 
> Trace; c01b18f4 <scsi_queue_next_request+44/110> 


