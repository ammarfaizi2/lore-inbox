Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTDRQHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTDRQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:07:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13841 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263165AbTDRQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:06:42 -0400
Date: Fri, 18 Apr 2003 09:19:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs (1/7) - fix compilation
In-Reply-To: <20030418181246.A363@lst.de>
Message-ID: <Pine.LNX.4.44.0304180918010.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003, Christoph Hellwig wrote:
> @@ -1456,8 +1455,8 @@
>      dev_t devnum = 0, dev = MKDEV(major, minor);
>      struct devfs_entry *de;
>  
> -    if (flags)
> -	printk(KERN_ERR "%s called with flags != 0, please fix!\n");
> +    /* we don't accept any flags anymore.  prototype will change soon. */
> +    BUG_ON(flags);

PLEASE don't use BUG_ON() except for conditions that you really cannot 
continue from. It's damn impolite (and it makes debugging impossible) to 
kill the kernel startup if somebody has a unconverted driver or similar.

		Linus

