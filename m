Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUD1Tey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUD1Tey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUD1TeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:34:16 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:57609 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264946AbUD1Qqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:46:42 -0400
Date: Wed, 28 Apr 2004 10:59:10 -0500
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss patch for 2.6.6
Message-ID: <20040428155910.GE8163@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the linux/include/cciss_ioctl.h file. When support for the cciss big ioctl was added the stucture in the header was put in the wrong place. If an application includes the file it will fail to compile.
Please consider this for inclusion in 2.6.6.

Thanks,
mikem
-------------------------------------------------------------------------------

diff -burpN lx266-rc2-p001/include/linux/cciss_ioctl.h lx266-rc2/include/linux/cciss_ioctl.h
--- lx266-rc2-p001/include/linux/cciss_ioctl.h	2004-04-03 21:36:57.000000000 -0600
+++ lx266-rc2/include/linux/cciss_ioctl.h	2004-04-27 13:58:51.000000000 -0500
@@ -35,17 +35,6 @@ typedef __u32 DriverVer_type;
 
 #define MAX_KMALLOC_SIZE 128000
 
-typedef struct _BIG_IOCTL_Command_struct {
-  LUNAddr_struct	   LUN_info;
-  RequestBlock_struct      Request;
-  ErrorInfo_struct  	   error_info; 
-  DWORD			   malloc_size; /* < MAX_KMALLOC_SIZE in cciss.c */
-  DWORD			   buf_size;    /* size in bytes of the buf */
-  				        /* < malloc_size * MAXSGENTRIES */
-  BYTE			   *buf;
-} BIG_IOCTL_Command_struct;
-
-
 #ifndef CCISS_CMD_H
 // This defines are duplicated in cciss_cmd.h in the driver directory 
 
@@ -181,6 +170,16 @@ typedef struct _IOCTL_Command_struct {
   BYTE			   *buf;
 } IOCTL_Command_struct;
 
+typedef struct _BIG_IOCTL_Command_struct {
+  LUNAddr_struct	   LUN_info;
+  RequestBlock_struct      Request;
+  ErrorInfo_struct  	   error_info; 
+  DWORD			   malloc_size; /* < MAX_KMALLOC_SIZE in cciss.c */
+  DWORD			   buf_size;    /* size in bytes of the buf */
+  				        /* < malloc_size * MAXSGENTRIES */
+  BYTE			   *buf;
+} BIG_IOCTL_Command_struct;
+
 typedef struct _LogvolInfo_struct{
 	__u32	LunID;
 	int	num_opens;  /* number of opens on the logical volume */
