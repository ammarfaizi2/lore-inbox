Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBOPoB>; Thu, 15 Feb 2001 10:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRBOPnl>; Thu, 15 Feb 2001 10:43:41 -0500
Received: from gaudi.zrz.TU-Berlin.DE ([130.149.2.123]:43012 "EHLO
	gaudi.zrz.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S129436AbRBOPnj>; Thu, 15 Feb 2001 10:43:39 -0500
Message-Id: <200102151543.QAA13174@gaudi.zrz.TU-Berlin.DE>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Bug in FAT reading
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Feb 2001 16:43:37 +0100
From: Herbert Pophal <opha4000@gaudi.zrz.TU-Berlin.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel People,

Recently I experienced a dos formatted floppy which, after mounting it
vfat and issuing the df command produced the kernel messages below.
The original part is several hundreds line long. The message stream
persisted after a shutdown. If one waits long enough, it will stop.
I consider this behavior a bug. It appeared in 2.2.14-5.0 (RH6.2), 2.2.16,
2.2.18 and 2.4.1 kernels (all from kernel.org). The mount, unmount and ls
commands worked fine.

[ ... deleted repeated lines, during normal system operation
Feb 13 15:47:37 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:37 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:37 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:37 gaudi kernel: bread in fat_access failed 
Feb 13 15:47:38 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:38 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:38 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:38 gaudi kernel: bread in fat_access failed 
Feb 13 15:47:38 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:39 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:39 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:39 gaudi kernel: bread in fat_access failed

... and now we issue a shutdown ...
 
Feb 13 15:47:39 gaudi PAM_pwdb[685]: (xdm) session closed for user hp
Feb 13 15:47:39 gaudi gnome-name-server[1177]: input condition is: 0x10, 
exiting
Feb 13 15:47:39 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:39 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:39 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:39 gaudi kernel: bread in fat_access failed 
Feb 13 15:47:40 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:40 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:40 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:40 gaudi kernel: bread in fat_access failed 
Feb 13 15:47:41 gaudi rc: Stopping keytable succeeded
Feb 13 15:47:41 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:41 gaudi Font Server[627]: terminating 
Feb 13 15:47:41 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:41 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:41 gaudi kernel: bread in fat_access failed 
Feb 13 15:47:42 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:42 gaudi kernel: floppy0: sector not found: track 0, head 0, 
sector 5, size 2
Feb 13 15:47:42 gaudi kernel: end_request: I/O error, dev 02:00 (floppy), 
sector 4
Feb 13 15:47:42 gaudi kernel: bread in fat_access failed 
... ] deleted repeated lines, during and after shutdown


The mdir output is:

plain_io: Input/output error
Error reading fat number 0

and proceeds with the normally expected dir listing.
The messages file contains then just two of the above blocks and
not this almost never ending junk.

I think if the fourth or so read attempt on the FAT is unsuccesfull the
kernel should proceed to the alternate FAT, as the mtools obviously do.

With best regards,
Herbert

pophal@zrz.tu-berlin.de



