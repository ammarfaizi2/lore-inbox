Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423726AbWJZXCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423726AbWJZXCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423718AbWJZXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:02:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423697AbWJZXCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:02:52 -0400
Date: Thu, 26 Oct 2006 16:02:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: iss_storagedev@hp.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
Message-Id: <20061026160245.26f86ce2.akpm@osdl.org>
In-Reply-To: <20061023214608.f09074e9.randy.dunlap@oracle.com>
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 21:46:08 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> --- linux-2619-rc3-pv.orig/drivers/block/cciss.c
> +++ linux-2619-rc3-pv/drivers/block/cciss.c
> @@ -1992,8 +1992,8 @@ cciss_read_capacity(int ctlr, int logvol
>  		*block_size = BLOCK_SIZE;
>  	}
>  	if (*total_size != (__u32) 0)

Why is cciss_read_capacity casting *total_size to u32?

It is a sector_t.  If it happens to have the value 0xnnnnnnnn00000000 then
this expression will incorrectly evaluate to `false'.

