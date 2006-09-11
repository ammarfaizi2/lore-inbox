Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWIKWxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWIKWxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIKWxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:53:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932292AbWIKWxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:53:21 -0400
Date: Mon, 11 Sep 2006 15:53:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.18-rc6-mm1 'uio_read' redefined, breaks allyesconfig on
 i386
Message-Id: <20060911155311.270a8fbb.akpm@osdl.org>
In-Reply-To: <20060911224520.GJ9335@shell0.pdx.osdl.net>
References: <20060911224520.GJ9335@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 15:45:20 -0700
Judith Lebzelter <judith@osdl.org> wrote:

> Hello, 
> 
> I noticed in the 'allyesconfig' build for i386 is not working for 2.6.18-rc6-mm1.
> The function 'uio_read' in gregkh-driver-uio.patch has the same name as a 
> function in fs/xfs/support/move.c.  Here is the error message:
> 
>   LD      drivers/w1/built-in.o
>   LD      drivers/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x6eb597): In function `uio_read':
> drivers/uio/uio_dev.c:59: multiple definition of `uio_read'
> fs/built-in.o(.text+0x2f4ee8):fs/xfs/support/move.c:26: first defined here
> i686-unknown-linux-gnu-ld: Warning: size of symbol `uio_read' changed from 123 in fs/built-in.o to 397 in drivers/built-in.o
> make: [.tmp_vmlinux1] Error 1 (ignored)
>   KSYM    .tmp_kallsyms1.S
> i686-unknown-linux-gnu-nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: [.tmp_kallsyms1.S] Error 1 (ignored)
> 

Thanks.   I'd suggest that XFS is being poorly behaved here.  "uio_read" isn't
an appropriately named symbol for a filesystem to be exposing.
