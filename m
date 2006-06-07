Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWFGRgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWFGRgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWFGRgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:36:38 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:20180 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932364AbWFGRgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:36:37 -0400
Date: Wed, 7 Jun 2006 11:36:42 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Adrian's Trivial Patches" <trivial@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use unlikely() for current_kernel_time() loop
Message-ID: <20060607173642.GA6378@schatzie.adilger.int>
Mail-Followup-To: Adrian's Trivial Patches <trivial@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I just noticed this minor optimization.  current_kernel_time() is called
from current_fs_time() so it is used fairly often but it doesn't use
unlikely(read_seqretry(&xtime_lock, seq)) as other users of xtime_lock do.
Also removes extra whitespace on the empty line above.

Signed-off-by: Andreas Dilger <adilger@clusterfs.com>


--- ./kernel/time.c.orig	2006-05-08 15:40:43.000000000 -0600
+++ ./kernel/time.c	2006-06-07 11:24:49.000000000 -0600
@@ -424,9 +424,9 @@ inline struct timespec current_kernel_time
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		
+
 		now = xtime;
-	} while (read_seqretry(&xtime_lock, seq));
+	} while (unlikely(read_seqretry(&xtime_lock, seq)));
 
 	return now; 
 }

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

