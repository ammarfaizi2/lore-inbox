Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263695AbUJ3LU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUJ3LU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263694AbUJ3LU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:20:58 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:4804 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S263695AbUJ3LUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:20:50 -0400
Date: Sat, 30 Oct 2004 14:20:48 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.9-ac5 - more stupid FAT filesystems
Message-ID: <20041030112048.GA7501@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1099060831.13098.33.camel@localhost.localdomain> <20041030090308.GA6060@m.safari.iki.fi> <20041030110414.GA3130@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030110414.GA3130@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 01:04:15PM +0200, Vojtech Pavlik wrote:
...
> > I guess Canon IXUS 400 is overstupid or something.
> 
> No, the patch from me (included in -ac) is completely bogus. The correct
> patch is attached.

OK :)  I reverted the ac5 FAT patch and applied this one,
now it mounts nicely.  Thanks.

Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/sdb1     vfat    245M   27M  218M  11% /mnt/usb

> diff -urN linux-2.6.8/fs/fat/inode.c linux-2.6.8-fat/fs/fat/inode.c
> --- linux-2.6.8/fs/fat/inode.c	2004-09-30 15:27:58.343661051 +0200
> +++ linux-2.6.8-fat/fs/fat/inode.c	2004-09-30 15:33:32.820915377 +0200
> @@ -1003,6 +1003,8 @@
>  		/* all is as it should be */
>  	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
>  		/* bad, reported on pc9800 */
> +	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xff) == first) {
> +		/* bad, reported on Nokia phone with USB storage */
>  	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {
>  		/* bad, reported with a MO disk on win95/me */
>  	} else if (first == 0) {

-- 
