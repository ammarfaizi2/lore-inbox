Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031676AbWLABGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031676AbWLABGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031677AbWLABGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:06:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031676AbWLABGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:06:46 -0500
Date: Thu, 30 Nov 2006 17:06:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: dedekind@infradead.org
Cc: tglx@linutronix.de, haver@vnet.ibm.com,
       Josh Boyer <jwboyer@linux.vnet.ibm.com>, arnez@vnet.ibm.com,
       llinux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UBI: take 2
Message-Id: <20061130170624.94fde80d.akpm@osdl.org>
In-Reply-To: <1164824246.576.65.camel@sauron>
References: <1164824246.576.65.camel@sauron>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 20:17:26 +0200
Artem Bityutskiy <dedekind@infradead.org> wrote:

> This is take 2 of the previous mail with David's comments in mind.
> 
> Hello Andrew,
> 
> we have announced UBI several months ago in the MTD mailing list. It was
> successfully used in our setup and we've got positive feedback.
> 
> In short, it is kind of LVM layer but for flash (MTD) devices which
> hides flash devices complexities like bad eraseblocks (on NANDs) and
> wear. The documentation is available at the MTD web site:
> http://www.linux-mtd.infradead.org/doc/ubi.html
> http://www.linux-mtd.infradead.org/faq/ubi.html
> 
> The source code is available at the UBI GIT tree:
> git://git.infradead.org/ubi-2.6.git

Got that, thanks.  It needs a bit of help:

--- a/drivers/mtd/ubi/cdev.c~git-ubi-fix
+++ a/drivers/mtd/ubi/cdev.c
@@ -1185,7 +1185,7 @@ static ssize_t vol_cdev_direct_write(str
 			 len, vol_id, lnum, off);
 
 		err = ubi_eba_write_leb(ubi, vol_id, lnum, tbuf, off, len,
-					UBI_DATA_UNKNOWN, &written, 0, NULL);
+					UBI_DATA_UNKNOWN, &written, NULL);
 		if (unlikely(err)) {
 			count -= written;
 			*offp += written;
_

