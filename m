Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUHHRgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUHHRgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 13:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUHHRgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 13:36:13 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:33685 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266014AbUHHRgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 13:36:08 -0400
Subject: Re: dynamic /dev security hole?
From: Albert Cahalan <albert@users.sf.net>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com
In-Reply-To: <20040808175834.59758fc0.Ballarin.Marc@gmx.de>
References: <1091969260.5759.125.camel@cube>
	 <20040808175834.59758fc0.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1091977471.5761.144.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Aug 2004 11:04:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 11:58, Marc Ballarin wrote:
> On 08 Aug 2004 08:47:40 -0400
> Albert Cahalan <albert@users.sf.net> wrote:
> 
> > Suppose I have access to a device, for whatever legit
> > reason. Maybe I'm given access to a USB key with
> > some particular serial number.
> > 
> > I hard link this to somewhere else. Never mind that an
> > admin could in theory use 42 separate partitions and
> > mount most of the system with the "nodev" option. This
> > is rarely done.
> > 
> > Now the device is removed. The /dev entry goes away.
> > A new device is added, and it gets the same device
> > number as the device I had legit access to. Hmmm?
> 
> This would require (1) /dev to be inside the root filesystem and (2) users
> having write access somewhere in that filesystem.
> 
> (1) is uncommon, often a separate filesystem is used for udev
> (2) is very bad practice anyway and should never be seen on a true
> multi-user machine

Sure, blame the admins. This is like leaving landmines
in your front yard, then blaming people who step on them.

> Besides, this is nothing new. Dynamic permission updates through PAM have
> the same issue, and anyone calling themselves "admin" should be well aware
> of those issues. This is basic Unix-security, after all.

This isn't, or at least shouldn't, be basic UNIX security.

PAM should call revoke(), except that Linux still doesn't
have this system call. It's been in BSD since 4.3BSD-Reno.
Calling revoke() would fully solve the PAM problems. Any
open file descriptors would be useless. Any hard links to
the device file would get the new permission bits via the
shared inode.

IMHO, hard links need to be severely restricted by default.
It's a waste to make this even a boot option, since almost
nobody would have a legitimate need for the current behavior.
Perhaps there are other ways to deal with the problem though.

> Yet, this issue should probably mentioned in documentation. It certainly
> should be mentioned in the udev-HOWTO.

You don't have to document problems if you fix them.


