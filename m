Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbTFWUTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbTFWUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 16:19:47 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:29657 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266165AbTFWUTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 16:19:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: "Szonyi Calin" <sony@etc.utt.ro>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>
Subject: [PATCH] Re: Jfs problems
Date: Mon, 23 Jun 2003 15:33:49 -0500
User-Agent: KMail/1.4.3
Cc: <linux-kernel@vger.kernel.org>
References: <35119.194.138.39.55.1056364461.squirrel@webmail.etc.utt.ro>
In-Reply-To: <35119.194.138.39.55.1056364461.squirrel@webmail.etc.utt.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306231533.49595.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 June 2003 05:34, Szonyi Calin wrote:
> Hi
>
> Accidentally  I filled up my jfs root partition.
> After that I had some crashes with jfs
> Below is the dmesg and the crash.

I think I found the problem.  The patch below should fix it.  I will try 
to reproduce the problem and verify that this patch works.

> I had to reboot in kernel 2.4 to be able to delete the files.

The funny thing is that the bug exists in 2.4 too.

> Also I found in logs a line with
> _mark_inode_dirty: this cannot happen

I don't know about this.

Thanks,
Shaggy

===== fs/jfs/jfs_dtree.c 1.21 vs edited =====
--- 1.21/fs/jfs/jfs_dtree.c	Thu Mar 13 09:14:08 2003
+++ edited/fs/jfs/jfs_dtree.c	Mon Jun 23 15:21:03 2003
@@ -2908,7 +2908,7 @@
 			d->index = cpu_to_le32(add_index(tid, inode, bn, i));
 			if (dtlck->index >= dtlck->maxcnt)
 				dtlck = (struct dt_lock *) txLinelock(dtlck);
-			lv = dtlck->lv;
+			lv = &dtlck->lv[dtlck->index];
 			lv->offset = stbl[i];
 			lv->length = 1;
 			dtlck->index++;

