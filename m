Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUI3BlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUI3BlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUI3BlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:41:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:57575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268113AbUI3BlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:41:16 -0400
Date: Wed, 29 Sep 2004 21:31:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: ray-lk@madrabbit.org, rml@novell.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040929213129.6b90b342.akpm@osdl.org>
In-Reply-To: <1096404035.30123.22.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<1096404035.30123.22.camel@vertex>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> On Tue, 2004-09-28 at 15:08, Andrew Morton wrote:
> > Ray Lee <ray-lk@madrabbit.org> wrote:
> > >
> > > The current way pads out the structure unnecessarily, and still doesn't
> > > handle the really long filenames, by your admission. It incurs extra
> > > syscalls, as few filenames are really 256 characters in length. 
> > 
> > Why don't you pass a file descriptor into the syscall instead of a pathname?
> > You can then take a ref on the inode and userspace can close the file.
> > That gets you permission checking for free.
> > 
> 
> I don't think moving inotify to a syscall based interface is worth it.

That wasn't my point.

What I'm trying to get away from is this passing of full pathnames into and
out of the kernel, whether by syscall or ioctl.  It is a poor interface
and, less importantly, is slow.

And it is slow on the common (notify) path!  It's worth adding additional
setup overhead if we can make he event delivery faster, no?

> First off, on startup, this would require about 2k open() calls,
> followed by 2k syscalls to inotify. Not as nice as just 2k ioctl()
> calls.

There's probably not a lot of difference, even if all those pathnames and
inodes are in cache.
