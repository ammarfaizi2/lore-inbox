Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSILWXp>; Thu, 12 Sep 2002 18:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSILWXp>; Thu, 12 Sep 2002 18:23:45 -0400
Received: from fungus.teststation.com ([212.32.186.211]:18444 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S317264AbSILWXo>; Thu, 12 Sep 2002 18:23:44 -0400
Date: Fri, 13 Sep 2002 00:27:35 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Joel Votaw <jovotaw@cs.nmsu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops, maybe smbfs on SMP system?  Kernel is RedHat's 2.4.18-10smp
In-Reply-To: <Pine.LNX.4.44.0209120935300.29531-100000@quito>
Message-ID: <Pine.LNX.4.44.0209130007040.20947-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Joel Votaw wrote:

> smb_retry: no connection process

This means that your smbmount process has terminated (crashed?). You could
try some things with that, eg upgrading samba to the latest 2.2.x, running
it with a higher debug level (4, check your smbmount.log), add more debug 
printouts to the smbmount main loop, getting a core dump from it.

The mount should become unusble at this point because smbfs no longer has 
a connection and it can't contact it's smbmount daemon to get a new one.

> last message repeated 2 times
> smb_delete_inode: could not close inode 2

I believe this is at umount time. And if smb_delete_inode wants to 
actually close something and smb_retry is failing it won't be able to.

I need to find out if/why that would cause the busy message. When the 
connection closes any open files are closed, so closing shouldn't be a 
problem.

Did you get either of these the second time?

> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
> day...

Kabooom!

/Urban

