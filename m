Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKQX5L>; Sun, 17 Nov 2002 18:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSKQX5G>; Sun, 17 Nov 2002 18:57:06 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29102 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261206AbSKQX5C>; Sun, 17 Nov 2002 18:57:02 -0500
Date: Sun, 17 Nov 2002 19:05:05 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Failure to reread partition tables on non-busy devices
Message-ID: <20021118000505.GM3280@redhat.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (almost certainly wrong BTW) makes it work.  Obviously, 
somewhere there should be a call to invalidate_bdev(); that doesn't exist.  
I'm not sure A) where that call should be and B) what checks there should 
be to avoid calling invalidate_bdev() on a device that is busy.

fs/partitions/check.c:  1.85 1.86 dledford 02/11/17 17:22:37 (modified, 
needs delta)

@@ -453,8 +453,8 @@ int rescan_partitions()
 	struct parsed_partitions *state;
 	int p, res;
 
-	if (!bdev->bd_invalidated)
-		return 0;
+	//if (!bdev->bd_invalidated)
+	//	return 0;
 	if (bdev->bd_part_count)
 		return -EBUSY;
 	res = invalidate_device(dev, 1);

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
