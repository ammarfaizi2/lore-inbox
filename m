Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTEIITc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEIITc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:19:32 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:1548 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262362AbTEIITb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:19:31 -0400
Date: Fri, 9 May 2003 09:32:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Norbert Wolff <norbert_wolff@t-online.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bogus Warning in ppp_generic.c
Message-ID: <20030509093208.A12934@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Norbert Wolff <norbert_wolff@t-online.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030509102401.3534d179.norbert_wolff@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030509102401.3534d179.norbert_wolff@t-online.de>; from norbert_wolff@t-online.de on Fri, May 09, 2003 at 10:24:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 10:24:01AM +0200, Norbert Wolff wrote:
>  	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
>  	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
> +
> +#ifdef CONFIG_DEVFS_FS
>  	if (!err) {
>  		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
>  				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
>  	}
> +#endif
>  
>  	if (!err)
>  		printk(KERN_ERR "failed to register PPP device (%d)\n", err);

Wrong fix :)  the error check is just reveresed, devfs_mk_cdev also returns
0 if CONFIG_DEVFS_FS is set and it succeded.

Btw, almost any occurance of #ifdef CONFIG_DEVFS_FS is a bug.

