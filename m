Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWDTGmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWDTGmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDTGmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:42:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5203 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751127AbWDTGmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:42:39 -0400
Date: Thu, 20 Apr 2006 08:42:50 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: dax@gurulabs.com, billion.wu@areca.com.tw, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Caputo <ccaputo@alt.net>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-ID: <20060420064249.GO614@suse.de>
References: <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de> <001401c6641d$586bd950$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c6641d$586bd950$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, erich wrote:
> Dear Jens Axboe,
> 
> I  do "fsck -fy /dev/sda1" on driver MAX_XFER_SECTORS 512.
> The file system was not clean.
> I attach mesg.txt for you refer to.
> 
> =====================================
> == boot with driver MAX_XFER_SECTORS 4096
> =====================================
> #mkfs.ext2 /dev/sda1
> #reboot
> =====================================
> == boot with driver MAX_XFER_SECTORS 512
> =====================================
> #fsck -fy /dev/sda1
> /dev/sda1:clean,.............
> #reboot
> =====================================
> == boot with driver MAX_XFER_SECTORS 4096
> =====================================
> #mount /dev/sda1 /mnt/sda1
> #cp /root/aa /mnt/sda1
> #reboot
> =====================================
> == boot with driver MAX_XFER_SECTORS 512
> =====================================
> #fsck -fy /dev/sda1
> /dev/sda1: no clean,........and dump message such as the attach file 
> mesg.txt.

So the conclusion is that your driver and/or hardware corrupts data when
you set MAX_XFER_SECTORS too high. I can't help you anymore with this,
you should be in the best position to debug the driver and/or hardware
:-)

It could be that the higher setting just exposes another transfer
setting bug, like maximum number of segments or segment size, etc.

-- 
Jens Axboe

