Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbTCMSoQ>; Thu, 13 Mar 2003 13:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbTCMSoQ>; Thu, 13 Mar 2003 13:44:16 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:33956 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262495AbTCMSoN>;
	Thu, 13 Mar 2003 13:44:13 -0500
Date: Thu, 13 Mar 2003 21:54:11 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [2.5] memleak in drivers/scsi/cpqfcTSinit.c::cpqfcTS_ioctl
Message-ID: <20030313185411.GA2436@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There seem to be a memleak on error exit path if copy_to_user() fails.
   See the patch below.

Bye,
    Oleg

===== drivers/scsi/cpqfcTSinit.c 1.32 vs edited =====
--- 1.32/drivers/scsi/cpqfcTSinit.c	Tue Feb 25 21:47:18 2003
+++ edited/drivers/scsi/cpqfcTSinit.c	Thu Mar 13 21:50:33 2003
@@ -686,7 +686,7 @@
 	if( (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) &&
 	     vendor_cmd->len )
         if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
-		return( -EFAULT);
+		result = -EFAULT;
 
         if( buf) 
 	  kfree( buf);
