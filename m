Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267780AbTAMPzA>; Mon, 13 Jan 2003 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267788AbTAMPzA>; Mon, 13 Jan 2003 10:55:00 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267780AbTAMPy7>;
	Mon, 13 Jan 2003 10:54:59 -0500
Date: Mon, 13 Jan 2003 09:08:31 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: concerns about sysfs_ops
In-Reply-To: <1042456636.10860.11.camel@hawk.sh.intel.com>
Message-ID: <Pine.LNX.4.33.0301130907340.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Jan 2003, Louis Zhuang wrote:

> Dear Mochel,
> 	I found you removed off/count params in new sysfs_ops functions. That's
> good change for show functions, but for store function, if you don't
> give the len of data, the chained xxx_store function has to assume
> or/and guess how long the data is. This might be a potential issue. So I
> suggest you add 'size_t count' in store function of sysfs_ops.
> 
> include/linux/sysfs.h:  1.21 1.22 louis 03/01/13 18:39:41 (modified, 
> needs delta)
> 
> @@ -18,7 +18,7 @@
>  
>  struct sysfs_ops {
>  	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
> -	ssize_t	(*store)(struct kobject *,struct attribute *,const char *);
> +	ssize_t	(*store)(struct kobject *,struct attribute *,const char *,
> size_t count);
>  };

I agree, and Linus pointed out that obvious flaw in the interface when I
sent it to him on Friday. I'll fixing that, and should up in his tree
later today..

	-pat

