Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbVFXPnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVFXPnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVFXPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:43:31 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:27983 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S263073AbVFXPko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:40:44 -0400
Message-ID: <42BC297A.9000008@tls.msk.ru>
Date: Fri, 24 Jun 2005 19:40:42 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
References: <20050624081808.GA26174@kroah.com> <42BBFB55.3040008@tls.msk.ru> <20050624151615.GA29854@kroah.com>
In-Reply-To: <20050624151615.GA29854@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 24, 2005 at 04:23:49PM +0400, Michael Tokarev wrote:
>>And another question.  Why it isn't possible to use
>>plain tmpfs for this sort of things?
> 
> What do you mean?  What's wrong with a ramfs based fs?  To use tmpfs
> would require a lot more work.  But if you want to do it, I'll gladly
> take patches :)

Hmm.  Ramfs and Tmpfs...  I mean, we already have several filesystems
which works, and are complete filesystems.  Tmpfs is just one of them.

The point is as the following.  Instead of creating completely new
filesystem, there should be a possibility to create just a small
layer on top of existing, feature-complete (think directories)
filesystem, like tmpfs, with the only difference is that it's
especially known by the kernel as containing device nodes (where
the kernel should create/delete the nodes), and is mountable as
such (not as any generic tmpfs).  When a new device is created,
ndevfs_mknod() (or similar) is called as in your patch, but the
node is created in normal, regular tmpfs, instead of on some
stripped-down filesystem.

This tmpfs will be mountable ofcourse, *and* it will support all
the other normal filesystem operations.  But...

>>Why to create another filesystem, instead of just using current
>>tmpfs and call mknod/unlink on it as appropriate?
> 
> Um, that's about all that this code does.

....Ah ok.  Well.  Hmm.  So I misread the code it seems.
I thought it does not support directories and symlinks..

>>This same tmpfs can be used by udev too (to create that "policy"-based
>>names), and it gives us all the directories and other stuff...
> 
> udev doesn't need a kernel specific fs.

I know.  But it should be able to run on top of such an FS
to (at least I don't see why it shouldn't), provided it only
maintains that "policy" names (symlinks) to "canonical" device
nodes (which is easily doable by just stripping config file).

/mjt
