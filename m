Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDDVWB (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDDVWB (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:22:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbTDDVWA (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:22:00 -0500
Date: Fri, 4 Apr 2003 13:33:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Hua Zhong" <hzhong@cisco.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: Compile warning in 2.5.66-bk latest
Message-Id: <20030404133320.4a6a2a8c.shemminger@osdl.org>
In-Reply-To: <CDEDIMAGFBEBKHDJPCLDMEKMDGAA.hzhong@cisco.com>
References: <1049408232.22772.1.camel@dell_ss3.pdx.osdl.net>
	<CDEDIMAGFBEBKHDJPCLDMEKMDGAA.hzhong@cisco.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003 19:00:14 -0800
"Hua Zhong" <hzhong@cisco.com> wrote:

> Hi Andrew:
> 
> It's probably another change set in the file (J_EXPECT_JH).
> 
> I don't have gcc 3.2 installed so I could not verify, but maybe the
> following patch could fix it.
> 

This compiles and runs fine for me.


> Maybe a better fix is to define all J_EXPECTxxx as sth like:
> 
> #define J_EXPECT(expr, why, params...)		__journal_expect(expr, why, ##
> params)
> 
> as why is always needed.
> 
> diff -urN linux-2.5/include/linux/jbd.h linux-2.5-new/include/linux/jbd.h
> --- linux-2.5/include/linux/jbd.h	Thu Apr  3 11:29:43 2003
> +++ linux-2.5-new/include/linux/jbd.h	Thu Apr  3 21:48:25 2003
> @@ -275,7 +275,7 @@
>  	do {								     \
>  		if (!(expr)) {						     \
>  			printk(KERN_ERR "EXT3-fs unexpected failure: %s;\n", # expr); \
> -			printk(KERN_ERR ## why);			     \
> +			printk(KERN_ERR why);			     \
>  		}							     \
>  	} while (0)
>  #define J_EXPECT(expr, why...)		__journal_expect(expr, ## why)
> 
> > -----Original Message-----
> > From: Stephen Hemminger [mailto:shemminger@osdl.org]
> > Sent: Thursday, April 03, 2003 2:17 PM
> > To: Hua Zhong
> > Cc: Linux Kernel Mailing List
> > Subject: Compile warning in 2.5.66-bk latest
> >
> >
> > Using gcc 3.2 with latest 2.5.66-bk
> >
> > gcc -Wp,-MD,drivers/block/.elevator.o.d -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4
> > -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> > -DKBUILD_BASENAME=elevator -DKBUILD_MODNAME=elevator -c -o
> > drivers/block/.tmp_elevator.o drivers/block/elevator.c
> > fs/jbd/transaction.c:670:53: warning: pasting "KERN_ERR" and
> > ""Possible IO failure.\n"" does not give a valid preprocessing token
> >
> >
> >
