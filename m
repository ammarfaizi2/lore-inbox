Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265716AbUEZQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbUEZQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbUEZQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:58:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62681 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265716AbUEZQ6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:58:43 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2/5: dm.c: free cloned bio on error path
Date: Wed, 26 May 2004 11:58:27 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200405261152.33233.kevcorry@us.ibm.com>
In-Reply-To: <200405261152.33233.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261158.27432.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In __map_bio(), if the target returns an error while mapping the I/O, the
cloned bio needs to be freed.

--- diff/drivers/md/dm.c	2004-05-09 21:33:10.000000000 -0500
+++ source/drivers/md/dm.c	2004-05-25 10:13:41.000000000 -0500
@@ -369,6 +369,7 @@
 		struct dm_io *io = tio->io;
 		free_tio(tio->io->md, tio);
 		dec_pending(io, -EIO);
+		bio_put(clone);
 	}
 }
 
