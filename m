Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTAHFYR>; Wed, 8 Jan 2003 00:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267781AbTAHFYR>; Wed, 8 Jan 2003 00:24:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44041 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267778AbTAHFYQ>;
	Wed, 8 Jan 2003 00:24:16 -0500
Date: Tue, 7 Jan 2003 21:32:40 -0800
From: Greg KH <greg@kroah.com>
To: Simon Scheiwiller <simon@hornweb.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject.h makes lilo compile break
Message-ID: <20030108053240.GB32422@kroah.com>
References: <005f01c2b3f6$b66ba5b0$0400a8c0@gwaihir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005f01c2b3f6$b66ba5b0$0400a8c0@gwaihir>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 02:39:31PM +0100, Simon Scheiwiller wrote:
> Hello
> 
> When I'm compiling lilo on a machine with kernel 2.5.54, I get the following
> error:
> 
> 
> gcc -c -O2 -Wall -g `( if [ -r $ROOT/etc/lilo.defines ]; then cat
> $ROOT/etc/lilo.defines; else
> echo -DBDATA -DBUILTIN -DDSECS=3 -DIGNORECASE -DLBA32 -DLVM -DEVMS -DM386 -D
> ONE_SHOT -DPASS160 -DREISERFS -DREWRITE_TABLE -DSOLO_CHAIN -DVARSETUP -DVERS
> ION -DUNIFY; fi ) | sed 's/-D/-DLFC_/g'` `[ -r /usr/include/asm/boot.h ] &&
> echo -DHAS_BOOT_H` `cat mylilo.h` lilo.c
> In file included from /usr/include/linux/kobject.h:10,
>                  from /usr/include/linux/device.h:28,
>                  from /usr/include/linux/genhd.h:15,
>                  from common.h:20,
>                  from lilo.c:25:
> /usr/include/linux/list.h:323:2: warning: #warning "don't include kernel
> headers in userspace"

Um, why not heed this warning?  :)

And yes, it looks like Pat got a change in to prevent kobject.h from
being included if __KERNEL__ is not set, but this is not the proper fix.
See the archives for the many discussions about not including kernel
header files in userspace programs.

thanks,

greg k-h
