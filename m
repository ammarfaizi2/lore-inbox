Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264928AbSJPEmu>; Wed, 16 Oct 2002 00:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264929AbSJPEmu>; Wed, 16 Oct 2002 00:42:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:48626 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264928AbSJPEmt>;
	Wed, 16 Oct 2002 00:42:49 -0400
Message-ID: <3DACEFA6.4BFACC13@digeo.com>
Date: Tue, 15 Oct 2002 21:48:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <3DACEDE0.7FB25F02@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 04:48:39.0265 (UTC) FILETIME=[4B729D10:01C274CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's a fix for CONFIG_MD:


--- 2.5.43/fs/partitions/check.c~md-fix	Tue Oct 15 21:45:51 2002
+++ 2.5.43-akpm/fs/partitions/check.c	Tue Oct 15 21:47:07 2002
@@ -522,9 +522,8 @@ int rescan_partitions(struct gendisk *di
 			continue;
 		add_partition(disk, p, from, size);
 #if CONFIG_BLK_DEV_MD
-		if (!state->parts[j].flags)
-			continue;
-		md_autodetect_dev(bdev->bd_dev+p);
+		if (state->parts[p].flags)
+			md_autodetect_dev(bdev->bd_dev+p);
 #endif
 	}
 	kfree(state);

.
