Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTIWUOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTIWUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:14:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:56711 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbTIWUOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:14:21 -0400
Date: Tue, 23 Sep 2003 13:14:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, dhowells@redhat.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923131414.E20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/fs/afs/cell.c]
> START -->
>   58:	cell = kmalloc(sizeof(afs_cell_t) + strlen(name) + 1,GFP_KERNEL);
>   59:	if (!cell) {
<snip>
>  126: error:
>  127:	up_write(&afs_cells_sem);
>  128:	kfree(afs_cell_root);
> END -->

Yes, this looks like a bug/typo.  Patch below.  David, this look ok?

thanks,
-chris

===== fs/afs/cell.c 1.2 vs edited =====
--- 1.2/fs/afs/cell.c	Tue Sep  9 03:21:38 2003
+++ edited/fs/afs/cell.c	Tue Sep 23 11:57:26 2003
@@ -145,7 +145,7 @@
 	printk("kAFS: bad VL server IP address: '%s'\n",vllist);
  error:
 	up_write(&afs_cells_sem);
-	kfree(afs_cell_root);
+	kfree(cell);
 	return ret;
 } /* end afs_cell_create() */
 
