Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUDRJkS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 05:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbUDRJkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 05:40:18 -0400
Received: from verein.lst.de ([212.34.189.10]:35275 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263336AbUDRJkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 05:40:14 -0400
Date: Sun, 18 Apr 2004 11:40:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@verein.lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lockfs - dm bits
Message-ID: <20040418094007.GA10041@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040417220647.GC2573@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417220647.GC2573@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 12:06:47AM +0200, Christoph Hellwig wrote:
> This patch makes the device mapper use the new freeze_bdev/thaw_bdev
> interface.  Extracted from Chris Mason's patch.

With the DM updates that went into Linus' tree today you'll need this
additional hunk ontop:

--- linux/drivers/md/dm.c~	2004-04-01 13:29:22.000000000 -0500
+++ linux/drivers/md/dm.c	2004-04-01 14:54:57.911207304 -0500
@@ -1014,6 +1014,7 @@ int dm_suspend(struct mapped_device *md)
 
 	/* were we interrupted ? */
 	if (atomic_read(&md->pending)) {
+		__unlock_fs(md);
 		clear_bit(DMF_BLOCK_IO, &md->flags);
 		up_write(&md->lock);
 		return -EINTR;
