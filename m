Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTEMIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 04:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbTEMIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 04:50:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39565 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263286AbTEMIuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 04:50:25 -0400
Date: Tue, 13 May 2003 02:04:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexh@ihatent.com,
       jsimmons@infradead.org
Subject: Re: 2.5.69-mm4
Message-Id: <20030513020414.5ca41817.akpm@digeo.com>
In-Reply-To: <20030513085525.GA7730@hh.idb.hist.no>
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513085525.GA7730@hh.idb.hist.no>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 09:03:06.0034 (UTC) FILETIME=[777C7120:01C3192E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> > : undefined reference to `active_load_balance'
> 
>  I got this one too

I don't think so.  Please do a `make clean' and try again.

>, as well as:
>  drivers/built-in.o(.text+0x7d534): In function `fb_prepare_logo':
>  : undefined reference to `find_logo'

Is that thing _still_ there?

Does this fix?

diff -puN drivers/video/fbmem.c~fbmem-linkage-fix drivers/video/fbmem.c
--- 25/drivers/video/fbmem.c~fbmem-linkage-fix	2003-05-13 02:03:38.000000000 -0700
+++ 25-akpm/drivers/video/fbmem.c	2003-05-13 02:03:42.000000000 -0700
@@ -655,7 +655,7 @@ int fb_prepare_logo(struct fb_info *info
 	}
 
 	/* Return if no suitable logo was found */
-	fb_logo.logo = find_logo(info->var.bits_per_pixel);
+	fb_logo.logo = fb_find_logo(info->var.bits_per_pixel);
 	
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;

_

