Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUKHV1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUKHV1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUKHV1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:27:37 -0500
Received: from users.linvision.com ([62.58.92.114]:40841 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261240AbUKHV12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:27:28 -0500
Date: Mon, 8 Nov 2004 22:27:11 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't divide by 0 when trying to mount ext3
Message-ID: <20041108212711.GA16365@bitwizard.nl>
References: <20041108195934.GA29981@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108195934.GA29981@apps.cwi.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 08:59:35PM +0100, Andries Brouwer wrote:
> Not surprisingly, the ext3 code crashes in the same way
> the ext2 code does when dividing by zero.


> +	if (sb->s_magic != EXT3_SUPER_MAGIC)
> +		goto cantfind_ext3;
[...]
> +	if (EXT3_INODE_SIZE(sb) == 0)
> +		goto cantfind_ext3;
[...] 
> +	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
> +		goto cantfind_ext3;

[...]
> +cantfind_ext3:
> +	if (!silent)
> +		printk(KERN_ERR "VFS: Can't find ext3 filesystem on dev %s.\n",
> +		       sb->s_id);
> +	goto failed_mount;

There are now three cases that end up with the same message and
same error from userspace viewpoint. There are many cases where 
debugging a problem is helped when it's possible to find out exactly
which test determined that the filesystem could not be mounted. 

How about: 

	[ ... ]	{
	errstr = "no magic";
	goto cantfind_ext3;
	}

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
