Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbTGZTgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbTGZTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:36:25 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:45832 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269237AbTGZTgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:36:24 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Date: Sat, 26 Jul 2003 23:51:33 +0400
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307262351.33808.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the problem simply that the device has moved from /dev/md1 to /dev/md/1?
> If so, is this change sufficient?
>
> diff -puN drivers/md/md.c~a drivers/md/md.c
> --- 25/drivers/md/md.c~a        2003-07-26 11:24:58.000000000 -0700
> +++ 25-akpm/drivers/md/md.c     2003-07-26 11:25:15.000000000 -0700
> @@ -3505,7 +3505,7 @@ int __init md_init(void)
>         for (minor=0; minor < MAX_MD_DEVS; ++minor) {
>                 devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
>                                 S_IFBLK|S_IRUSR|S_IWUSR,
> -                               "md/%d", minor);
> +                               "md%d", minor);
>         }

should not such things be done by devfsd in user space? This patch makes it 
even more incompatible with 2.4 ...
