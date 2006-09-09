Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWIIPfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWIIPfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIIPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:35:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8619 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932271AbWIIPfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:35:31 -0400
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2006-09-09-17-18-13+trackit+sam@rfc1149.net>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
	 <1157815525.6877.43.camel@localhost.localdomain>
	 <2006-09-09-17-18-13+trackit+sam@rfc1149.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:58:42 +0100
Message-Id: <1157817522.6877.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 17:18 +0200, ysgrifennodd Samuel Tardieu:
> On  9/09, Alan Cox wrote:
> 
> | No kernel level locking anywhere in the driver. Yet you could have two
> | people accessing it at once.
> 
> The device can be open only by one client at a time, this is checked in
> open(), as was done in most other watchdog drivers.

This is insufficient. Many watchdog drivers are broken here but that's
no excuse to continue the problem because people will copy the errror
(as I suspect you did)

	fd = open("/dev/watchdog", O_RDWR);
	switch(fork())
	{

.. one open, two users, two processes, two CPUs


> | > +	default:
> | > +		return -ENOIOCTLCMD;
> | 
> | Should be -ENOTTY
> 
> We have 44 instances of ENOIOCTLCMD in other watchdog drivers
> and zero instances of ENOTTY. Should we change all the instances, adopt
> what has been done or just change the new ones?

-ENOIOCTLCMD should never be returned to userspace. An unknown ioctl
returns -ENOTTY. -ENOIOCTLCMD is an internal magic value used with
helper layers to tell the helper layer "I don't handle this, use your
own handler"



