Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUAHNxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUAHNxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:53:18 -0500
Received: from f20.mail.ru ([194.67.57.52]:5638 "EHLO f20.mail.ru")
	by vger.kernel.org with ESMTP id S264477AbUAHNxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:53:12 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 08 Jan 2004 16:53:11 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, how does devfs stack up to the above problems and constraints:
>   Problems:
>     1) devfs only shows the dev entries for the devices in the system.

Is this a problem? Where exactly this problem lies?

>     2) devfs does not handle the need for dynamic major/minor numbers

Neither does udev. Both take whatever driver gives them.

>     3) devfs does not provide a way to name devices in a persistent
>        fashion.

I am not sure what exactly you mean here.

>     4) devfs does provide a deamon that userspace programs can hook > into
>        to listen to see what devices are being created or removed.
>   Constraints:
>     1) devfs forces the devfs naming policy into the kernel.  If you
>        don't like this naming scheme, tough.

kernel imposes naming scheme for exporting devices in sysfs. It is
possible to get rid of devfs_name in kernel and use those names
that must exist anyway to support udev as well. devfs has
devfsd that can call whatever naming agent you like.

>     2) devfs does not follow the LSB device naming standard.

it is user-space (devfsd) issue, not kernel space (devfs)

>     3) devfs is small, and embedded devices use it.  However it is
>        implemented in non-pagable memory.

Same for sysfs. Other Unices have pageable kernel memory. If Linux
had it any memory based filesystem could benefit from it. I did not
look at backing store for sysfs patches but it is likely that same
idea could be used for devfs.

> Oh yeah, and there are the insolvable race conditions with the devfs
> implementation in the kernel, but I'm not going to talk about them > right

I do not argue that current devfs implementation is ugly and racy. I
just beg you to point at what makes those races "unsolvable".

> now, sorry.  See the linux-kernel archives if you care about them (and
> if you use devfs, you should care...)

I do care. Searching archives for devfs mostly brings "everyone knows
this is crap". That is why I kindly ask you to show real evidence that
the problems it has are unsolvable.

> So devfs is 2 for 7, ignoring the kernel races.

Hmm ... I really see only one - devfs names that are historically
used. Assuming that

- devfs just exports kernel names (that must exist anyway)
- sysfs provides consistent cdev view as it does for bdev

devfsd simply can take kernel name and call whatever program you like
to implement naming policy including udev. With added benefit of
removable devices support :)

regards

-andrey
