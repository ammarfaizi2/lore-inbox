Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUDPVtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUDPVqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:46:21 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58783 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263772AbUDPVnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:43:13 -0400
Date: Fri, 16 Apr 2004 22:41:04 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Fix UDF-FS potentially dereferencing null
Message-ID: <20040416214104.GT20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	bfennema@falcon.csc.calpoly.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move size instantiation after null check for 'dir', nearer
to where its first used.

		Dave

--- linux-2.6.5/fs/udf/namei.c~	2004-04-16 22:38:28.000000000 +0100
+++ linux-2.6.5/fs/udf/namei.c	2004-04-16 22:39:25.000000000 +0100
@@ -159,7 +159,7 @@
 	char *nameptr;
 	uint8_t lfi;
 	uint16_t liu;
-	loff_t size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
+	loff_t size;
 	lb_addr bloc, eloc;
 	uint32_t extoffset, elen, offset;
 	struct buffer_head *bh = NULL;
@@ -202,6 +202,8 @@
 		return NULL;
 	}
 
+	size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
+
 	while ( (f_pos < size) )
 	{
 		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &bloc, &extoffset, &eloc, &elen, &offset, &bh);
