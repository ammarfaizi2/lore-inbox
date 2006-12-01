Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758882AbWLAEW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbWLAEW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 23:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758884AbWLAEW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 23:22:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:4811 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1758882AbWLAEW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 23:22:58 -0500
Subject: Re: [PATCH] UBI: take 2
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dedekind@infradead.org, tglx@linutronix.de, haver@vnet.ibm.com,
       arnez@vnet.ibm.com, llinux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061130170624.94fde80d.akpm@osdl.org>
References: <1164824246.576.65.camel@sauron>
	 <20061130170624.94fde80d.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 22:24:58 -0600
Message-Id: <1164947098.19697.45.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 17:06 -0800, Andrew Morton wrote:
> >
> > The source code is available at the UBI GIT tree:
> > git://git.infradead.org/ubi-2.6.git
> 
> Got that, thanks.  It needs a bit of help:
> 
> --- a/drivers/mtd/ubi/cdev.c~git-ubi-fix
> +++ a/drivers/mtd/ubi/cdev.c
> @@ -1185,7 +1185,7 @@ static ssize_t vol_cdev_direct_write(str
>  			 len, vol_id, lnum, off);
> 
>  		err = ubi_eba_write_leb(ubi, vol_id, lnum, tbuf, off, len,
> -					UBI_DATA_UNKNOWN, &written, 0, NULL);
> +					UBI_DATA_UNKNOWN, &written, NULL);
>  		if (unlikely(err)) {
>  			count -= written;
>  			*offp += written;
> _

Nice catch.  Odd that gcc doesn't throw a warning on my system with it
being like that.

  CC      drivers/mtd/ubi/badeb.o
  CC      drivers/mtd/ubi/upd.o
  CC      drivers/mtd/ubi/sysfs.o
  CC      drivers/mtd/ubi/cdev.o
  CC      drivers/mtd/ubi/uif.o
  CC      drivers/mtd/ubi/vtbl.o
  CC      drivers/mtd/ubi/volmgmt.o
  CC      drivers/mtd/ubi/eba.o

Anyway, we'll get the patch into the tree ASAP.

josh

