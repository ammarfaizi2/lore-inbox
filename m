Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWAPVaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWAPVaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAPVaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:30:30 -0500
Received: from xenotime.net ([66.160.160.81]:20165 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751233AbWAPVa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:30:29 -0500
Date: Mon, 16 Jan 2006 13:30:22 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: drivers/block/ps2esdi.c
In-Reply-To: <43CC0F74.9090409@linuxwireless.org>
Message-ID: <Pine.LNX.4.58.0601161329000.24990@shark.he.net>
References: <43CC0F74.9090409@linuxwireless.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Alejandro Bonilla Beeche wrote:

> It looks like the Linux-2.6 tree is still broken...
>
> Just FYI
>
>
>   CC      drivers/block/loop.o
>   CC      drivers/block/ps2esdi.o
> In file included from drivers/block/ps2esdi.c:42:
> include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please
> move your driver to the new sysfs api"
> drivers/block/ps2esdi.c: In function 'ps2esdi_getgeo':
> drivers/block/ps2esdi.c:1064: error: dereferencing pointer to incomplete
> type
> drivers/block/ps2esdi.c:1065: error: dereferencing pointer to incomplete
> type
> drivers/block/ps2esdi.c:1066: error: dereferencing pointer to incomplete
> type
> make[3]: *** [drivers/block/ps2esdi.o] Error 1
> make[2]: *** [drivers/block] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/root/linux-2.6'
> make: *** [debian/stamp-build-kernel] Error 2
> debian:~/linux-2.6#

As Adrian (IIRC) pointed out last time this was posted (last week),
this is what you can get when you enable "BROKEN".  IOW, see
  drivers/block/Kconfig:

config BLK_DEV_PS2
	tristate "PS/2 ESDI hard disk support"
	depends on MCA && MCA_LEGACY && BROKEN
                                        ^^^^^^

so please send patches to fix it (the driver) if you care about it.

-- 
~Randy
