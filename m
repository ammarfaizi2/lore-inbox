Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSGKXcK>; Thu, 11 Jul 2002 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSGKXcK>; Thu, 11 Jul 2002 19:32:10 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:33009 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313060AbSGKXcJ>; Thu, 11 Jul 2002 19:32:09 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 11 Jul 2002 17:32:26 -0600
To: Thunder from the hill <thunder@ngforever.de>
Cc: Dawson Engler <engler@csl.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020711233226.GC8738@clusterfs.com>
Mail-Followup-To: Thunder from the hill <thunder@ngforever.de>,
	Dawson Engler <engler@csl.Stanford.EDU>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mc@cs.Stanford.EDU
References: <200207112135.OAA03801@csl.Stanford.EDU> <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2002  17:14 -0600, Thunder from the hill wrote:
> --- fs/hpfs/dir.c	19 Jun 2002 02:11:50 -0000	1.1.1.1
> +++ fs/hpfs/dir.c	11 Jul 2002 22:12:53 -0000
> @@ -211,7 +211,9 @@ struct dentry *hpfs_lookup(struct inode 
>  
>  	lock_kernel();
>  	if ((err = hpfs_chk_name((char *)name, &len))) {
> -		if (err == -ENAMETOOLONG) return ERR_PTR(-ENAMETOOLONG);
> +		if (err == -ENAMETOOLONG) {
> +			return ERR_PTR(-ENAMETOOLONG);
> +		}
>  		goto end_add;
>  	}

So, how does adding braces and a linefeed fix the locking problem here?
;-)

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

