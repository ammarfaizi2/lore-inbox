Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUAGLOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUAGLOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:14:47 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1543 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265499AbUAGLOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:14:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Jens Axboe <axboe@suse.de>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Wed, 7 Jan 2004 14:14:44 +0300
User-Agent: KMail/1.5.3
Cc: Olaf Hering <olh@suse.de>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <200401071400.46286.arvidjaar@mail.ru> <20040107110516.GC3483@suse.de>
In-Reply-To: <20040107110516.GC3483@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071414.44390.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 14:05, Jens Axboe wrote:
> On Wed, Jan 07 2004, Andrey Borzenkov wrote:
> > On Wednesday 07 January 2004 12:50, Jens Axboe wrote:
> > > > > So yeah, poll...
> > > >
> > > > Poll how? "kmediachangethread"? Or polling in userland? The latter
> > > > would (probably) lead to endless IO errors. Not very good.
> > >
> > > No need to put it in the kernel, user space fits the bil nicely.
> >
> > unfortunately opening device in userland effectively locks tray making
> > media change impossible. at least given current ->open semantic.
> >
> > even periodic access is quite annoying for users (tray closing while
> > user attempts to insert CD)
>
> cdrom layer handles this with O_NONBLOCK basically meaning a 'not for
> data' open.
>
> > we may agree that O_NDELAY does not affect locked state; currently
> > this is not consistent across drivers (e.g. cdrom does not lock tray
> > while sd does)
>
> cdrom has no special O_NDELAY checks.

ok I meant O_NONBLOCK, sorry. they are synonyms anyway

{pts/0}% grep NONBLO *
fcntl.h:#define O_NONBLOCK        04000
fcntl.h:#define O_NDELAY        O_NONBLOCK

