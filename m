Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTJGVYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJGVYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:24:51 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:21904 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S262932AbTJGVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:24:48 -0400
Subject: Re: devfs and udev
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031007205244.GA2978@kroah.com>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
	 <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com>
	 <200310072347.41749.insecure@mail.od.ua>  <20031007205244.GA2978@kroah.com>
Content-Type: text/plain
Message-Id: <1065561443.840.76.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 07 Oct 2003 17:17:23 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A6zK3-0006Rr-HC*E2AuDV6kgos*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-07 at 16:52, Greg KH wrote:
> On Tue, Oct 07, 2003 at 11:47:41PM +0300, insecure wrote:
> > It seems that we have a bit of misunderstanding here.
> > 
> > I just don't want to go back to /dev being actually placed on
> > real, on-disk fs.
> > 
> > I won't mind if naming scheme will change as long
> > as device names start with '/dev/' and appear
> > there (semi-)automagically. That's what I call devfs.
> > If udev can do this, I am all for that.
> 
> udev can do this.  Is there some documentation that you read that has
> suggested otherwise?

Lets see if I can make this clear, devfs is a virtual file system.  If I
mount my root drive without mounting devfs, the /dev directory is
empty.  udev is not like this, it is like the normal /dev that can be
built with mknod, special files in a real filesystem.  But udev is told
by the kernel what files to make and remove.  So it is still a dynamic
filesystem, just in userland with kernel notifications rather than a
filesystem that is entirely in kernel space.

devfsd could use a "/dev-state" (or similar) directory to preserve the
state of any changes made to the virtual filesystem using normal
userland tools are mirrored in that directory.

I am also a huge devfs fan.  I was building 2.2.x kernels with Richard's
patches before 2.4.0 was released.  I like just having an empty /dev and
knowing the kernel will take care of everything I need at boot.

I'm thinking this will not exactly work with udev, as you will need a
few seed nodes to get to userland so udev can be started.  Then udev
will create the entries for devices that actually exist on the machine,
and then these entries will still be present at the next boot.  So it
will just be a problem for initial installs.

Right?

I can handle all of this.  I'm flexible.  Just make it work.  :)

-- 
Chris

