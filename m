Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbUKQHNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUKQHNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUKQHNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:13:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:54165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262223AbUKQHNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:13:08 -0500
Date: Tue, 16 Nov 2004 23:12:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, geert@linux-m68k.org, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-Id: <20041116231248.5f61e489.akpm@osdl.org>
In-Reply-To: <20041116084341.GA24484@infradead.org>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	<20041101142245.GA28253@infradead.org>
	<20041116084341.GA24484@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > There's tons of leaks in the hplcance probing code, and it doesn't release
>  > he memory region on removal either.
>  > 
>  > Untested patch to fix those issues below:
> 
>  ping.

The fix needs a fix:


diff -puN drivers/net/hplance.c~hp300-lance-leak-fixes-fix drivers/net/hplance.c
--- 25/drivers/net/hplance.c~hp300-lance-leak-fixes-fix	2004-11-16 23:11:46.546476832 -0800
+++ 25-akpm/drivers/net/hplance.c	2004-11-16 23:12:00.027427416 -0800
@@ -96,7 +96,7 @@ static int __devinit hplance_init_one(st
 	hplance_init(dev, d);
 	err = register_netdev(dev);
 	if (err)
-		goto out_free_netdev;
+		goto out_release_mem_region;
 
 	dio_set_drvdata(d, dev);
 	return 0;
_

