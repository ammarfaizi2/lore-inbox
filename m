Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbTABPJV>; Thu, 2 Jan 2003 10:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTABPJV>; Thu, 2 Jan 2003 10:09:21 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:17081 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262023AbTABPJU>; Thu, 2 Jan 2003 10:09:20 -0500
Date: Thu, 02 Jan 2003 07:24:08 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1'
	undeclared (first use in this function)
To: Miles Lane <miles.lane@attbi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-id: <3E145998.6020607@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <1041487926.11532.83.camel@bellybutton.attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
>   gcc -Wp,-MD,drivers/usb/host/.ohci-hcd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ohci_hcd
> -DKBUILD_MODNAME=ohci_hcd   -c -o drivers/usb/host/ohci-hcd.o drivers/usb/host/ohci-hcd.c
> In file included from drivers/usb/host/ohci-hcd.c:137:
> drivers/usb/host/ohci-dbg.c: In function `show_list':
> drivers/usb/host/ohci-dbg.c:358: `data1' undeclared (first use in this function)
> drivers/usb/host/ohci-dbg.c:358: (Each undeclared identifier is reported only once
> drivers/usb/host/ohci-dbg.c:358: for each function it appears in.)
> drivers/usb/host/ohci-dbg.c:358: `data0' undeclared (first use in this function)
> make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1

Looks like Greg's patch to use more dev_*() debug macros changed
some conditional structures too ... so the sysfs debug files are
always compiled in, rather than only with CONFIG_USB_DEBUG which
is what defines them.

Workaround by enabling USB debugging in your configuration.

I'll send some patch around later, likely to just revert that
part of his patch since I actually like having "production"
OHCI modules be less than 12K.  Though maybe those files should
be enabled with some other Kconfig option.  Thoughts?

- Dave




