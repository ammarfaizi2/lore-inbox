Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVH2FC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVH2FC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 01:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVH2FC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 01:02:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11992 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750820AbVH2FC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 01:02:26 -0400
Date: Mon, 29 Aug 2005 14:53:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050829045359.GA1784@frodo>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824092838.GB28272@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> ...
> Patch attached is against 2.6.13-rc6-mm2. Still a good idea to apply the
> relayfs read update from the previous mail [*] as well.

Hi Jens,

There's a minor config botch in there, I get this:

scripts/kconfig/conf -s arch/i386/Kconfig
drivers/block/Kconfig:466:warning: 'select' used by config symbol 'BLK_DEV_IO_TRACE' refer to undefined symbol 'RELAYFS'

The patch below seems to resolve it.

cheers.

-- 
Nathan


Index: relayfs-2.6.x-xfs/drivers/block/Kconfig
===================================================================
--- relayfs-2.6.x-xfs.orig/drivers/block/Kconfig
+++ relayfs-2.6.x-xfs/drivers/block/Kconfig
@@ -463,7 +463,7 @@
 
 config BLK_DEV_IO_TRACE
 	bool "Support for tracing block io actions"
-	select RELAYFS
+	select RELAYFS_FS
 	help
 	  Say Y here, if you want to be able to trace the block layer actions
 	  on a given queue.
