Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVGLEbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVGLEbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVGLEbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:31:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:49885 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262341AbVGLEbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:31:16 -0400
Date: Mon, 11 Jul 2005 21:30:57 -0700
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-ID: <20050712043056.GC2363@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com> <20050712032424.GA1742@kroah.com> <42D33E99.7030101@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D33E99.7030101@opersys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 11:52:57PM -0400, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > Based on the proposed users of this fs, I don't see any.  What ones are
> > you saying are not "debug" type operations?  And yes, I consider LTT a
> > "debug" type operation :)
> > 
> > The best part of this, is it gives distros and users a consistant place
> > to mount the fs, and to know where this kind of thing shows up in the fs
> > namespace.
> 
> Except that relayfs contains files that all behave in a very specific
> way: as relayfs buffers, while debugfs may contain a variety of different
> types of files.

The path/filename dictates how it is used, so putting relayfs type files
in debugfs is just fine.  debugfs allows any types of files to be there.

> I kind'a see what you're trying to say, and I fully understand that some
> debugfs users may indeed use the relayfs fileops to add an entry in
> debugfs which serves as a buffer, and that's the very reason we exported
> them to boot.

Good.

> But there's something to be said about having a single filesystem (and
> therefore tree somewhere in /)

New trees in / are not LSB compliant, hence the reason for writing
securityfs to get rid of /selinux and other LSM filesystems that were
starting to sprout up.

> which contains entries dedicated to a single purpose: dump huge
> amounts of data out of the kernel and into userspace whether or not
> the system is being debuged.

But that's exactly what debugfs is for, to allow data to be dumped out
of the kernel for different usages.

> From a user point of view, it sounds awfully weird if they're using
> "debugfs" on a production system ...

Ok, have a better name for it?  It's simple and easy to understand.

> > Last I looked, this was not possible.  Has this changed in the latest
> > version?
> 
> Here's from 2.6.13-rc2-mm1 fs/relayfs/inode.c
> > +EXPORT_SYMBOL_GPL(relayfs_open);
> > +EXPORT_SYMBOL_GPL(relayfs_poll);
> > +EXPORT_SYMBOL_GPL(relayfs_mmap);
> > +EXPORT_SYMBOL_GPL(relayfs_release);
> > +EXPORT_SYMBOL_GPL(relayfs_file_operations);
> > +EXPORT_SYMBOL_GPL(relayfs_create_dir);
> > +EXPORT_SYMBOL_GPL(relayfs_remove_dir);
> 
> It's been there ever since you've asked for it earlier this year :)

Thanks, didn't realize that.  Wait, all that should be needed is
"relayfs_file_operations", right?  Why have those others exported?

thanks,

greg k-h
