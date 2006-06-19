Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWFSSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWFSSxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFSSxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:53:17 -0400
Received: from mx1.mail.ru ([194.67.23.121]:23351 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S964812AbWFSSwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:52:50 -0400
Date: Mon, 19 Jun 2006 22:58:16 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619185816.GA26513@rain.homenetwork>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk> <20060619131750.GA14770@rain.homenetwork> <20060619182833.GJ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619182833.GJ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:28:33PM +0100, Al Viro wrote:
> On Mon, Jun 19, 2006 at 05:17:50PM +0400, Evgeniy Dushistov wrote:
> > In case of 1k fragments, msync of two pages
> > cause 8 calls of ufs's get_block_t with create == 1,
> > they will be consequent because of synchronization.
> 
> _What_ synchronization?
> Now, which lock would, in your opinion, provide serialization between these
> two calls?  They apply to different pages, so page locks do not help.
>  
you can look at fs/ufs/inode.c: ufs_getfrag_block.
It is ufs's get_block_t,
if create == 1 it uses "[un]lock_kernel". 

> To simplify the analysis, have one of those do msync() and another - write().
> One triggers writeback, leading to ufs_writepage().  Another leads to call
> of ufs_prepare_write().  Note that the latter call is process-synchronous,
> so no implicit serialization could apply.
skiped

I'll think about this.

-- 
/Evgeniy

