Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWHDIwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWHDIwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWHDIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:52:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030209AbWHDIwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:52:40 -0400
Date: Fri, 4 Aug 2006 01:52:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Maarten Maathuis" <madman2003@gmail.com>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: heavy file i/o on ext3 filesystem leads to huge
 ext3_inode_cache and dentry_cache that doesn't return to normal for hours
Message-Id: <20060804015221.dbcfa9d6.akpm@osdl.org>
In-Reply-To: <6d4bc9fc0608040053x4d7a9e14xe9de793cd0787736@mail.gmail.com>
References: <6d4bc9fc0608030927t175f16c0kfef6a21cc521e368@mail.gmail.com>
	<1154661560.17180.31.camel@kleikamp.austin.ibm.com>
	<6d4bc9fc0608040053x4d7a9e14xe9de793cd0787736@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 09:53:14 +0200
"Maarten Maathuis" <madman2003@gmail.com> wrote:

> On 8/4/06, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> > On Thu, 2006-08-03 at 18:27 +0200, Maarten Maathuis wrote:
> > > I have a kernel specific problem and this seemed like a suitable place to ask.
> > >
> > > I would like responces to be CC'ed to me if possible.
> > >
> > > I use a 2.6.17-ck1 kernel on an amd64 system. I have observed this
> > > problem on other/older kernels.
> > >
> > > Whenever there is serious hard drive activity (such as doing "slocate
> > > -u") ext3_inode_cache and dentry_cache grow to a combined 400-500 MiB.

Increasing /proc/sys/vm/vfs_cache_pressure should increase the inode/dentry
reclaim rate.

> >
> > echo 2 > /proc/sys/vm/drop_caches
> >
> > This feature is relatively new.
> >
> 
> Thank you, i tried echo'ing a 1 into that and it had no effect iirc.

1 drops pagecache, 2 drops dentries and inodes.  Pagecache pins inodes, so
using 2 will drop less inodes than using 3.

> Documentation on /proc/sys/vm seems pretty scarce.

Documentation/filesystems/proc.txt

