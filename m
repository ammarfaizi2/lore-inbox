Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSGKXjj>; Thu, 11 Jul 2002 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSGKXjj>; Thu, 11 Jul 2002 19:39:39 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:11517 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317860AbSGKXjh>; Thu, 11 Jul 2002 19:39:37 -0400
Date: Thu, 11 Jul 2002 16:41:17 -0700
From: Chris Wright <chris@wirex.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Dawson Engler <engler@csl.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020711164117.A21285@figure1.int.wirex.com>
Mail-Followup-To: Thunder from the hill <thunder@ngforever.de>,
	Dawson Engler <engler@csl.Stanford.EDU>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mc@cs.Stanford.EDU
References: <200207112135.OAA03801@csl.Stanford.EDU> <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Thu, Jul 11, 2002 at 05:14:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thunder from the hill (thunder@ngforever.de) wrote:
>  
> Index: fs/hpfs/dir.c
> ===================================================================
> RCS file: /var/cvs/thunder-2.5/fs/hpfs/dir.c,v
> retrieving revision 1.1.1.1
> diff -p -u -r1.1.1.1 dir.c
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

This does not fix the problem.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
