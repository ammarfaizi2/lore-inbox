Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWGJMlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWGJMlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWGJMlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:41:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:47671 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965005AbWGJMlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:41:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A96Y1NbZdok6F0i6bVpbD2lYB3i7oialIv+Ktmm2GT5xo/ygbd8qrLPgjg/1kZKsi5k1UqsjDTkCz1v+bCZqHZDSKYvK+Z4IbRqZGHmuFfbU+/5dfL3Z+Mbt9tGOL6Be+PGF6Fefvbr0VjwFEhPaiILky2De+Ac4vlk0rA5Htyg=
Message-ID: <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
Date: Mon, 10 Jul 2006 08:41:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1152524657.27368.108.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 00:11 -0400, ysgrifennodd Jon Smirl:
> > Fix various places in the tty code to make it match the current naming system.
> >         pty_slave_driver->driver_name = "pty_slave";
>
>
> NAK to just about all of this. Its gratuitous breaking of existing apps,
> it achieves nothing and some of it like the pty stuff is just plain
> incorrect anyway.

The whole naming scheme encoded into the tty code is incompatible with
udev. Udev allows renames and this code isn't aware of them.

I thought the idea behind udev was to remove all of this naming code
from the kernel and handle it in user space. So if I want legacy
device names I would add a section to /etc/udev to create them. Udev
is already capable of doing this.

> If you want to add sysfs interfaces to the tty code great, but please
> leave the existing, relied up, functional and effectively user space ABI
> tty files alone.

So far I haven't identified anything that is really needed that isn't
already available in sysfs.

It does seem that we are missing a user space library call for
converting a device number into a device name using the udev database.

On 7/9/06, Albert Cahalan <acahalan@gmail.com> wrote:
> BSD just uses devname(3) in libc, which asks the kernel via
> the kern.devname sysctl. So, /proc/sys/kern/devname for us.
> This is essentially what /proc/tty/drivers is today, except
> that FreeBSD standardized on a fully functional devfs.
>
> Solaris uses _ttyname_dev(dev_t,buf,bufsize), also in libc.
> This is horribly slow, involving a recursive search of
> directories listed in the /etc/ttysrch file. The interface
> is nice though. You get: ttyname, ttyname_r, _ttyname_dev.


-- 
Jon Smirl
jonsmirl@gmail.com
