Return-Path: <linux-kernel-owner+w=401wt.eu-S932985AbWL0PuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbWL0PuF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWL0PuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:50:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35546 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978AbWL0PuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:50:03 -0500
Date: Wed, 27 Dec 2006 16:47:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [patch] block: remove BKL dependency from drivers/block/loop.c
Message-ID: <20061227154713.GA4036@elte.hu>
References: <20061227115207.GA20721@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227115207.GA20721@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0003]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Subject: [patch] block: remove BKL dependency from drivers/block/loop.c
> From: Ingo Molnar <mingo@elte.hu>
> 
> the block loopback device is protected by lo->lo_ctl_mutex and it does 
> not need to hold the BKL anywhere. Convert its ioctl to unlocked_ioctl 
> and remove the BKL acquire/release from its compat_ioctl.

hm, i must have messed up this bit:

> +static long lo_ioctl(struct file * file, unsigned int cmd, unsigned long arg)
>  {
> +	struct inode *inode = file->f_path.dentry->d_inode;
>  	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;

because it now crashes there ... so forget this patch for now.

	Ingo
