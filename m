Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTH3WRY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 18:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTH3WRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 18:17:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:56539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262168AbTH3WRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 18:17:23 -0400
Date: Sat, 30 Aug 2003 15:21:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, kraxel@bytesex.org
Subject: Re: [PATCH] Use after free in drivers/media/video/videodev.c
Message-Id: <20030830152102.2c899371.akpm@osdl.org>
In-Reply-To: <20030830195529.GA15036@dreamland.darkstar.lan>
References: <20030830195529.GA15036@dreamland.darkstar.lan>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos <kronos@kronoz.cjb.net> wrote:
>
> --- 2.6.0.orig/drivers/media/video/videodev.c	Tue Aug 12 17:02:29 2003
>  +++ 2.6.0/drivers/media/video/videodev.c	Sat Aug 30 21:13:29 2003
>  @@ -349,9 +349,9 @@
>   	if(video_device[vfd->minor]!=vfd)
>   		panic("videodev: bad unregister");
>   
>  -	class_device_unregister(&vfd->class_dev);
>   	devfs_remove(vfd->devfs_name);
>   	video_device[vfd->minor]=NULL;
>  +	class_device_unregister(&vfd->class_dev);
>   	up(&videodev_lock);
>   }

Yes.  I already have this fix (from gregkh) queued up.

There are around 150 bugfixes in -mm at present.  It is worth
checking there first...
