Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVCAT0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVCAT0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVCAT0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:26:11 -0500
Received: from 83-70-37-232.b-ras1.prp.dublin.eircom.net ([83.70.37.232]:19328
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262027AbVCAT0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:26:07 -0500
Date: Tue, 1 Mar 2005 19:27:27 +0000 (GMT)
From: Telemaque Ndizihiwe <telendiz@eircom.net>
X-X-Sender: telendiz@localhost.localdomain
To: axboe@suse.de, Ingo.Wilken@informatik.uni-oldenburg.de
cc: marcelo.tosatti@cyclades.com, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Removes unnecessary if statement from /drivers/block/z2ram.c
Message-ID: <Pine.LNX.4.62.0503011907001.5142@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This Patch removes unnecessary if statement from a function that has no 
implementation (in kernel 2.6.x and 2.4.x); the function returns 0 with 
or without the if statement:

 	static int z2_release(struct inode *inode, struct file *filp)
 	{
 		if(current_device==-1)
 			return 0;

 		return 0;
 	}


Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.10/drivers/block/z2ram.c.orig	2005-02-23 18:02:51.011967584 +0000
+++ linux-2.6.10/drivers/block/z2ram.c	2005-02-23 18:05:31.617551824 +0000
@@ -304,9 +304,6 @@ err_out:
  static int
  z2_release( struct inode *inode, struct file *filp )
  {
-    if ( current_device == -1 )
-	return 0; 
-
      /*
       * FIXME: unmap memory
       */
