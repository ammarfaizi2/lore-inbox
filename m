Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUAHOGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUAHOGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:06:15 -0500
Received: from f7.mail.ru ([194.67.57.37]:33297 "EHLO f7.mail.ru")
	by vger.kernel.org with ESMTP id S264473AbUAHOGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:06:14 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>
Cc: =?koi8-r?Q?=22?=Linus Torvalds=?koi8-r?Q?=22=20?= 
	<torvalds@osdl.org>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 08 Jan 2004 17:06:12 +0300
In-Reply-To: <20040107195032.GB823@kroah.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Aeanc-000OLT-00.arvidjaar-mail-ru@f7.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > NOTE! We do have an alternative: if we were to just make block device 
> > nodes support "readdir" and "lookup", you could just do
> > 
> > 	open("/dev/sda/1" ...)
> > 
> > and it magically works right. I've wanted to do this for a long time, but 
> > every time I suggest allowing it, people scream.
> 
> Hm, that would be nice.  I don't remember seeing it being proposed
> before, what are the main complaints people have with this?
>

this has been in Linux long enough and was called "devfs". Apparently
somebody decided this was evil and removed it. I too am interested
what exatcly was wrong with this design (not implementation)?

Unfortunately the problem is worse than just that.

The main reason to use udev is to have persistent names for devices.
Currently my USB may be sda1 and next time I stick it in may be sdb1;
so I'd like to call it /dev/usb0 and use it.

But in this case we do not have even this possibility of revalidating
media on access to /dev/sda/1 because not only do not we have
/dev/usb0 as yet - we do not even know what it possibly points at.

Assuming - oh, horror - that we do use devfs, we have LOOKUP event,
so we can call naming agent for /dev/usb0 - and we can tell it that
usb0 refers to SCSI device on first port of my USB hub (you usually
plug it in the same slot do not you?) It can find out that there
is already block device for it and simply initiate rescan of
partition. Magically making sda/1 appear and linking usb0 to it.

Without some kind of LOOKUP event apparently the only possibility
is polling :(

regards

-andrey
