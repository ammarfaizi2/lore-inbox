Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJJLtF>; Thu, 10 Oct 2002 07:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbSJJLtF>; Thu, 10 Oct 2002 07:49:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53952 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262003AbSJJLtE>; Thu, 10 Oct 2002 07:49:04 -0400
Date: Thu, 10 Oct 2002 13:54:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Greg KH <greg@kroah.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
In-Reply-To: <20021008231832.GE11337@kroah.com>
Message-ID: <Pine.NEB.4.44.0210101348510.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Greg KH wrote:

>...
> -#define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
> -#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
> +#define ALOG(fmt,args...) printk(fmt, ##args)
> +#define LOG(fmt,args...) ALOG(KERN_INFO __FILE__ ":%s(%d):" fmt, __FUNCTION__, __LINE__, ##args)
>...
> -		printk(KERN_ERR __FUNCTION__ ": usb_submit_urb ret %d\n", i);
> +		printk(KERN_ERR "%s: usb_submit_urb ret %d\n", __FUNCTION__,  i);
>...

Note that due to a bug in gcc this doesn't compile with 2.95. There's an
extra space needed to fix the compilation with gcc 2.95:

  __FUNCTION__, -> __FUNCTION__ ,
  __LINE__,     -> __LINE__ ,


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



