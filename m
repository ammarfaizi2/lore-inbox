Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263718AbTCUScl>; Fri, 21 Mar 2003 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbTCUSb2>; Fri, 21 Mar 2003 13:31:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63875
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263713AbTCUSal>; Fri, 21 Mar 2003 13:30:41 -0500
Date: Fri, 21 Mar 2003 19:45:56 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211945.h2LJjuSR025953@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix leak in cpqfc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/scsi/cpqfcTSinit.c linux-2.5.65-ac2/drivers/scsi/cpqfcTSinit.c
--- linux-2.5.65/drivers/scsi/cpqfcTSinit.c	2003-03-06 17:04:31.000000000 +0000
+++ linux-2.5.65-ac2/drivers/scsi/cpqfcTSinit.c	2003-03-14 00:43:25.000000000 +0000
@@ -686,7 +686,7 @@
 	if( (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) &&
 	     vendor_cmd->len )
         if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
-		return( -EFAULT);
+		result = -EFAULT;
 
         if( buf) 
 	  kfree( buf);
