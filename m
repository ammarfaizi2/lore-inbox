Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270738AbTG0LG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTG0LG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:06:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53891
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270738AbTG0LGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:06:24 -0400
Subject: Re: 2.6.0-test1 devfs question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniele Venzano <webvenza@libero.it>, wodecki@gmx.de, rgooch@atnf.csiro.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726112553.2356cce0.akpm@osdl.org>
References: <20030725110830.GA666@gmx.de>
	 <20030726111221.GD9574@renditai.milesteg.arr>
	 <20030726112553.2356cce0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059304634.12758.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 12:17:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 19:25, Andrew Morton wrote:
> Is the problem simply that the device has moved from /dev/md1 to /dev/md/1?
> If so, is this change sufficient?

The problem seems to be "user selected devfs"

> diff -puN drivers/md/md.c~a drivers/md/md.c
> --- 25/drivers/md/md.c~a	2003-07-26 11:24:58.000000000 -0700
> +++ 25-akpm/drivers/md/md.c	2003-07-26 11:25:15.000000000 -0700
> @@ -3505,7 +3505,7 @@ int __init md_init(void)
>  	for (minor=0; minor < MAX_MD_DEVS; ++minor) {
>  		devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
>  				S_IFBLK|S_IRUSR|S_IWUSR,
> -				"md/%d", minor);
> +				"md%d", minor);


But 2.4 is the same as 2.5 ...

   devfs_handle = devfs_mk_dir (NULL, "md", NULL);
        /* we don't use devfs_register_series because we want to fill
md_hd_str
        for (minor=0; minor < MAX_MD_DEVS; ++minor) {
                char devname[128];
                sprintf (devname, "%u", minor);


