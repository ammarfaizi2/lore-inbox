Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUAGLFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAGLFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:05:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37801 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266185AbUAGLFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:05:22 -0500
Date: Wed, 7 Jan 2004 12:05:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Olaf Hering <olh@suse.de>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107110516.GC3483@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de> <200401071400.46286.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401071400.46286.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Andrey Borzenkov wrote:
> On Wednesday 07 January 2004 12:50, Jens Axboe wrote:
> > > > So yeah, poll...
> > >
> > > Poll how? "kmediachangethread"? Or polling in userland? The latter would
> > > (probably) lead to endless IO errors. Not very good.
> >
> > No need to put it in the kernel, user space fits the bil nicely.
> 
> unfortunately opening device in userland effectively locks tray making
> media change impossible. at least given current ->open semantic.
> 
> even periodic access is quite annoying for users (tray closing while
> user attempts to insert CD)

cdrom layer handles this with O_NONBLOCK basically meaning a 'not for
data' open.

> we may agree that O_NDELAY does not affect locked state; currently
> this is not consistent across drivers (e.g. cdrom does not lock tray
> while sd does)

cdrom has no special O_NDELAY checks.

-- 
Jens Axboe

