Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270557AbTGSXUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270561AbTGSXUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 19:20:48 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:35506
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S270557AbTGSXUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 19:20:47 -0400
Subject: Re: [PATCH] Port SquashFS to 2.6
From: David Dillow <dave@thedillows.org>
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org,
       Phillip Lougher <phillip@lougher.demon.co.uk>
In-Reply-To: <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net>
References: <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058657738.4233.4.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jul 2003 19:35:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-19 at 18:59, junkio@cox.net wrote:

> +static int squashfs_symlink_readpage(struct file *file, struct page *page)
> +{
> +	struct inode *inode = page->mapping->host;
> +	struct squashfs_inode_info *sqi = SQUASH_I(inode);
> +	int index = page->index << PAGE_CACHE_SHIFT, length = 0, bytes;
> +	int block = sqi->start_block;
> +	int offset = sqi->offset;
> +
> +	TRACE("Entered squashfs_symlink_readpage, page index %d, start block %x, offset %x\n",
> +		page->index, sqi->start_block, sqi->offset);
> +
> +	while(length < index) {
> +		char buffer[PAGE_CACHE_SIZE];
 
Hmm, isn't that 4K allocated on the stack? Ouch.
