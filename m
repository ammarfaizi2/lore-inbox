Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTH1P7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTH1P7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:59:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:51945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264088AbTH1P73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:59:29 -0400
Date: Thu, 28 Aug 2003 09:02:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm2
Message-Id: <20030828090240.2cccf4d9.akpm@osdl.org>
In-Reply-To: <1062075227.422.2.camel@lorien>
References: <20030826221053.25aaa78f.akpm@osdl.org>
	<1062075227.422.2.camel@lorien>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:
>
> when using the hdparm program, thus:
> 
>  # hdparm /dev/hda
> 
>  I'm getting this:
> 
>  Oops: 0000 [#1]

This should fix it.

--- 25/include/linux/genhd.h~large-dev_t-12-fix	2003-08-27 10:36:32.000000000 -0700
+++ 25-akpm/include/linux/genhd.h	2003-08-27 10:36:32.000000000 -0700
@@ -197,7 +197,7 @@ extern void rand_initialize_disk(struct 
 
 static inline sector_t get_start_sect(struct block_device *bdev)
 {
-	return bdev->bd_part->start_sect;
+	return bdev->bd_contains == bdev ? 0 : bdev->bd_part->start_sect;
 }
 static inline sector_t get_capacity(struct gendisk *disk)
 {

_

