Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTLGVuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTLGVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:50:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:1760 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264557AbTLGVt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:49:59 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: aio on ramfs
Date: Sun, 7 Dec 2003 15:50:02 -0600
User-Agent: KMail/1.5
Cc: suparna@in.ibm.com, linux-aio@kvack.org
References: <20031207083432.GP19856@holomorphy.com>
In-Reply-To: <20031207083432.GP19856@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312071550.03009.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 02:34, William Lee Irwin III wrote:

> -- wli
>
> diff -prauN linux-2.6.0-test11/fs/ramfs/inode.c
> ramfs-2.6.0-test11-1/fs/ramfs/inode.c ---
> linux-2.6.0-test11/fs/ramfs/inode.c	2003-11-26 12:43:32.000000000 -0800 +++
> ramfs-2.6.0-test11-1/fs/ramfs/inode.c	2003-12-07 00:26:29.000000000 -0800
> @@ -31,6 +31,7 @@
>  #include <linux/string.h>
>  #include <linux/smp_lock.h>
>  #include <linux/backing-dev.h>
> +#include <linux/writeback.h>
>
>  #include <asm/uaccess.h>
>
> @@ -140,10 +141,28 @@ static int ramfs_symlink(struct inode *
>  	return error;
>  }

Can I suggest a comment right here, "writepage/writepages/set_page_dirty stubs 
needed for aio"?

> +static int ramfs_writepage(struct page *page, struct writeback_control
> *wbc) +{
> +	return 0;
> +}
> +
> +static int ramfs_writepages(struct address_space *mapping, struct
> writeback_control *wbc) +{
> +	return 0;
> +}
> +
> +static int ramfs_set_page_dirty(struct page *page)
> +{
> +	return 0;
> +}

Rob
