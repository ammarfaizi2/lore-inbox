Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTD3Xze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTD3Xze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:55:34 -0400
Received: from [12.47.58.20] ([12.47.58.20]:18040 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262568AbTD3Xzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:55:32 -0400
Date: Wed, 30 Apr 2003 17:04:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm3
Message-Id: <20030430170446.6fe9b804.akpm@digeo.com>
In-Reply-To: <200304301957.58729.tomlins@cam.org>
References: <20030429235959.3064d579.akpm@digeo.com>
	<200304301957.58729.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 00:07:49.0180 (UTC) FILETIME=[B3646FC0:01C30F75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On April 30, 2003 02:59 am, Andrew Morton wrote:
> > Bits and pieces.  Nothing major, apart from the dynamic request allocation
> > patch.  This arbitrarily increases the maximum requests/queue to 1024, and
> > could well make large (and usually bad) changes to various benchmarks.
> > However some will be helped.
> 
> Here is something a little broken.  Suspect it might be in 68-bk too:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.68-mm3; fi
> WARNING: /lib/modules/2.5.68-mm3/kernel/sound/oss/cs46xx.ko needs unknown symbol cs4x_ClearPageReserved
> 

Yes, thanks.  It's a case of search-n-replace-n-dont-test.


diff -puN sound/oss/cs46xx.c~cs46xx-PageReserved-fix sound/oss/cs46xx.c
--- 25/sound/oss/cs46xx.c~cs46xx-PageReserved-fix	Wed Apr 30 17:03:41 2003
+++ 25-akpm/sound/oss/cs46xx.c	Wed Apr 30 17:03:48 2003
@@ -1247,7 +1247,7 @@ static void dealloc_dmabuf(struct cs_sta
 		mapend = virt_to_page(dmabuf->rawbuf + 
 				(PAGE_SIZE << dmabuf->buforder) - 1);
 		for (map = virt_to_page(dmabuf->rawbuf); map <= mapend; map++)
-			cs4x_ClearPageReserved(map);
+			ClearPageReserved(map);
 		free_dmabuf(state->card, dmabuf);
 	}
 
@@ -1256,7 +1256,7 @@ static void dealloc_dmabuf(struct cs_sta
 		mapend = virt_to_page(dmabuf->tmpbuff +
 				(PAGE_SIZE << dmabuf->buforder_tmpbuff) - 1);
 		for (map = virt_to_page(dmabuf->tmpbuff); map <= mapend; map++)
-			cs4x_ClearPageReserved(map);
+			ClearPageReserved(map);
 		free_dmabuf2(state->card, dmabuf);
 	}
 

_

