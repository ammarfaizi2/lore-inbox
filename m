Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVBVKDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVBVKDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 05:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVBVKDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 05:03:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:22739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262253AbVBVKD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 05:03:27 -0500
Date: Tue, 22 Feb 2005 02:03:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: jes@trained-monkey.org (Jes Sorensen)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-Id: <20050222020309.4289504c.akpm@osdl.org>
In-Reply-To: <16923.193.128608.607599@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jes@trained-monkey.org (Jes Sorensen) wrote:
>
> Hi,
> 
> This patch introduces ia64 specific read/write handlers for /dev/mem
> access which is needed to avoid uncached pages to be accessed through
> the cached kernel window which can lead to random corruption. It also
> introduces a new page-flag PG_uncached which will be used to mark the
> uncached pages. I assume this may be useful to other architectures as
> well where the CPU may use speculative reads which conflict with
> uncached access. In addition I moved do_write_mem to be under
> ARCH_HAS_DEV_MEM as it's only ever used if that is defined.
> 
> The patch is needed for the new ia64 special memory driver (mspec -
> former fetchop).
> 
> Patch is relative to 2.6.11-rc3-mm2 and relies on the ARCH_HAS_DEV_MEM
> flag which isn't in Linus' nor Tony's trees yet.

Is it possible to avoid consuming a page flag?

If this is an ia64-only (or 64-bit-only) thing I guess we could use bit 32.

> +		if (page->flags & PG_uncached)

dude.  That ain't gonna work ;)
