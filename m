Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLGSr1>; Thu, 7 Dec 2000 13:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLGSrR>; Thu, 7 Dec 2000 13:47:17 -0500
Received: from cip.physik.uni-wuerzburg.de ([132.187.42.13]:15623 "EHLO
	wpax13.physik.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id <S129392AbQLGSrG>; Thu, 7 Dec 2000 13:47:06 -0500
Date: Thu, 7 Dec 2000 19:09:13 +0100 (MET)
From: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
cc: drew@colorado.edu
Subject: bug in scsi.c
Message-ID: <Pine.GHP.4.21.0012071809140.18350-100000@wpax13.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have found a problem in scsi.c which in present in the 2.2 and 2.4
series. the scsi error handler thread is created with:

kernel_thread((int (*)(void *)) scsi_error_handler,
                                (void *) shpnt, 0);

This will lead to problems, when you have to umount the filesystem on
which the scsi-hostapter module is located.
To solve to problem I would propose to change this to:

kernel_thread((int (*)(void *)) scsi_error_handler,
                      (void *) shpnt, CLONE_FILES);
 

Bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
