Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263247AbTCYS3Y>; Tue, 25 Mar 2003 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbTCYS2Q>; Tue, 25 Mar 2003 13:28:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33967 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263201AbTCYS1v>;
	Tue, 25 Mar 2003 13:27:51 -0500
Date: Tue, 25 Mar 2003 19:20:43 +0100
From: Jens Axboe <axboe@suse.de>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
Message-ID: <20030325182043.GH30908@suse.de>
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25 2003, James Simmons wrote:
> 
> As usually I have a patch avalaible at 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
> 
> The patch has updates for the ATI Rage 128, Control, and Platnium 
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside 
> fbcon. There still are issues with syncing which cause the cursor on some 
> systems to become corrupt sometimes. 

-       data = kmalloc(size, GFP_KERNEL);
-       mask = kmalloc(size, GFP_KERNEL);
+       data = kmalloc(size, GFP_ATOMIC);
+       mask = kmalloc(size, GFP_ATOMIC);

        if (cursor->set & FB_CUR_SETSIZE) {
                memset(data, 0xff, size);


irk, you replaced GFP_KERNEL with GFP_ATOMIC, and even unconditionally
memset the return without even bothering to check if it succeeded or
not.

-- 
Jens Axboe

