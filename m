Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUIHOrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUIHOrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269111AbUIHOoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:44:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:58781 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269148AbUIHOi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:38:58 -0400
Date: Wed, 8 Sep 2004 16:38:52 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040908143852.GA27411@wotan.suse.de>
References: <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de> <20040908142808.GA11795@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908142808.GA11795@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:28:08PM +0300, Michael S. Tsirkin wrote:
> --- linux-2.6.8.1/include/linux/fs.h	2004-09-07 19:33:43.000000000 +0300
> +++ linux-2.6.8.1-new/include/linux/fs.h	2004-09-08 07:18:20.000000000 +0300
> @@ -879,6 +879,8 @@ struct file_operations {
>  	int (*readdir) (struct file *, void *, filldir_t);
>  	unsigned int (*poll) (struct file *, struct poll_table_struct *);
>  	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
> +	int (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
> +	int (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);

Define these as long, not int.  No need to waste 32 perfectly good bits on 
64bit platforms.

The main thing missing is documentation. You need clear comments what
the locking rules are and what compat is good for.

And you should change the code style to follow Documentation/CodingStyle

Other than that it looks ok to me.

-Andi
