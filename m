Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUA0WCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUA0WCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:02:00 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:23743 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264477AbUA0WBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:01:54 -0500
Date: Tue, 27 Jan 2004 17:01:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
Message-ID: <20040127220153.GA4992@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:43:21AM +0000, Adam Sampson wrote:
> Michael A Halcrow <mahalcro@us.ibm.com> writes:
> 
> >  - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)
> 
> Going off on a tangent...
> 
> There are all sorts of potentially-interesting things that could be
> done if Linux had a userspace filesystem mechanism included in the
> standard kernel -- as well as encryption, there's also network
> filesystems, various sorts of specialised caching (such as Zero
> Install), automounter-like systems, prototyping and so on.
> 
> Is there a technical reason that none of the userspace filesystem
> layers have been included in the stock kernel, or is it just that
> nobody's submitted any of them for inclusion yet?

Ehh, Coda's kernel module does just that. It is used by the userspace
cache manager of the Coda Distributed File System.

    http://www.coda.cs.cmu.edu/

But several other projects seem to be using it,

    http://uservfs.sourceforge.net/
    http://dav.sourceforge.net/

The interface to userspace a bit clumsy to work with, but there are
kernel modules for FreeBSD/NetBSD/Solaris and an experimental one for
Windows 2000/NT/XP, which makes any significant changes a bit of a pain.

It does have it's pecularities, reads and writes are not passed up to
userspace, only the open and close VFS calls. This makes the module
reasonably quite simple as it doesn't have to deal with VM issues and it
isn't susceptible to deadlocks,

   app wants to read data from a file ->
   userspace application requires memory allocation to provide this data ->
   VM tries to write out dirty data associated with the Coda mountpoint ==
   deadlock

So whole file caching keeps the kernel module more portable and
simplifies the userspace code. But it makes things like streaming
reads/writes or quotas impossible. If you want to provide encryption
there you would have to store an unencrypted copy of every open file
somewhere on disk or in ramfs/tmpfs and incur the cost of (de)crypting
(and (de)compressing) whenever it is opened or closed.

Jan

