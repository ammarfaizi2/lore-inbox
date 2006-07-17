Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWGQLYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWGQLYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWGQLYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:24:19 -0400
Received: from [212.70.42.180] ([212.70.42.180]:3338 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750741AbWGQLYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:24:15 -0400
From: Al Boldi <a1426z@gawab.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Mon, 17 Jul 2006 14:25:15 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200607152039.50786.a1426z@gawab.com> <F1256E02-209F-4D19-ACB2-1E92004E80B5@mac.com>
In-Reply-To: <F1256E02-209F-4D19-ACB2-1E92004E80B5@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607171425.15248.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Jul 15, 2006, at 13:39:50, Al Boldi wrote:
> > Trond Myklebust wrote:
> >> On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
> >>> I hope the confusion has passed for Trond.  My impression was he
> >>> figured this was per process data so it didn't make sense any
> >>> where near a filesystem, and the superblock was the last place it
> >>> should be.
> >>
> >> You are still using the wrong abstraction. Data that is not global
> >> to the entire machine has absolutely _no_ place being put into the
> >> superblock. It doesn't matter if it is process-specific, container-
> >> specific or whatever-else-specific, it will still be vetoed.
> >>
> >> If your real problem is uid/gid mapping on top of generic
> >> filesystems, then have you looked into the *BSD solution of using
> >> a stackable filesystem (i.e. umapfs)?
> >
> > A stackable FS is really overkill here, when all that is needed is
> > a simple mapping.  An easy solution would be, to allow for perMount
> > Handlers via hooks into the VFS, as was suggested in the '[RFC]
> > VFS: FS CoW using redirection' thread.
>
> IMHO a UID mapping is completely the wrong solution for this.

Sure, maybe it is, but if it were needed, why would I implement it using an 
extra VFS below the VFS?

> The problem is the subject (the process) and object (the filesystem)
> place different meanings on different UIDs, in other words their UIDs
> are in different namespaces.  The result is that you should tag that
> filesystem (vfsmount, really) with a different namespace tag and fix
> the namespace system to properly handle cross-namespace permissions,
> not forcibly graft on some fragile mapping system.

Grafting is probably the wrong way to implement this too, so what I suggest 
is to have the VFS provide hooks (aka plug-ins) for perMount Handlers, which 
would relieve developers from the need to either merge their requirements 
with the VFS, or introduce a subVFS.  This would imply more freedom, while 
at the same time reducing overhead.

> By using the
> keyring system for foreign-namespace UID permissions the actual
> permissions fall out quite nicely.

Maybe it is, for this specific situation.


Thanks!

--
Al

