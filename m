Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVHSXp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHSXp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbVHSXp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:45:28 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:7691 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbVHSXp1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:45:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVT4Gnz3hJw4K7xMh1yCAuC+NOxWOvzloIG8KHwDZfo8xyHqpr56Kathj7c6Y9Ms+0TM9k1aIOA16+pc8T+If3hFn6qomqnWxeVzUa6vtyLPyFVHv631U1ry2pIExPCx4Dte2qJkSwfGhF6B2tkoLxPSZ9C/tWrMHK9+mHjaci8=
Message-ID: <29495f1d05081916457009220c@mail.gmail.com>
Date: Fri, 19 Aug 2005 16:45:24 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] drivers/cdrom/sbpcd.c: fix the compilation
Cc: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <20050819233631.GB3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <20050819233631.GB3615@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.13-rc5-mm1:
> >...
> > +drivers-cdrom-fix-up-schedule_timeout-usage.patch
> >...
> 
> I sell copies of gcc at reasonable prices...
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/cdrom/sbpcd.o
> ...
> drivers/cdrom/sbpcd.c:830: warning: implicit declaration of function 'schedule_interruptible_timeout'
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `sbp_sleep':sbpcd.c:
> (.text+0x7c4592): undefined reference to `schedule_interruptible_timeout'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc6-mm1-full/drivers/cdrom/sbpcd.c.old 2005-08-19 20:43:18.000000000 +0200
> +++ linux-2.6.13-rc6-mm1-full/drivers/cdrom/sbpcd.c     2005-08-19 20:44:46.000000000 +0200
> @@ -827,7 +827,7 @@
>  static void sbp_sleep(u_int time)
>  {
>         sti();
> -       schedule_interruptible_timeout(time);
> +       schedule_timeout_interruptible(time);

::sigh:: Thanks, Adrian!

-Nish
