Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUEUIJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUEUIJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265459AbUEUIJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:09:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10375 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265144AbUEUIJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:09:48 -0400
Date: Fri, 21 May 2004 10:11:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ramfs lfs limit
Message-ID: <20040521081128.GA4834@elte.hu>
References: <20040521073702.GM3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521073702.GM3044@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> Hi Andrew,
> 
> this fixes the 2G limit on ramfs
> 
> --- sles/fs/ramfs/inode.c.~1~	2003-10-31 05:54:29.000000000 +0100
> +++ sles/fs/ramfs/inode.c	2004-05-21 07:55:07.394369104 +0200
> @@ -181,6 +181,7 @@ static int ramfs_fill_super(struct super
>  	struct inode * inode;
>  	struct dentry * root;
>  
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_blocksize = PAGE_CACHE_SIZE;
>  	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
>  	sb->s_magic = RAMFS_MAGIC;

yep - fixed this for RHEL3 half a year ago but forgot about it. It works
well, people are using multi-GB ramfs instances without problems.

	Ingo
