Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbTFSPUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbTFSPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:20:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265802AbTFSPUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:20:54 -0400
Date: Thu, 19 Jun 2003 16:34:53 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mike Waychison <michael.waychison@sun.com>
Cc: David Howells <dhowells@warthog.cambridge.redhat.com>,
       David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v2
Message-ID: <20030619153453.GG6754@parcelfarce.linux.theplanet.co.uk>
References: <11504.1056033106@warthog.warthog> <3EF1D326.4040109@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF1D326.4040109@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 11:13:42AM -0400, Mike Waychison wrote:
 
> Introducing special trap vfsmounts w/o super_blocks means we can no 
> longer have arbitrary actions on those traps.  AFS wants to define what 
> happens in kernelspace, autofs wants to define it in userspace.  Last I 
> checked, vfsmount doesn't have an ops structure.

It would have send an event over attached opened file.  Attached at
creation time.
 
> This only works for mounts performed in kernel space.  It doesn't lend 
> itself to performing mounts in userspace and would force autofs to 
> re-implement mount(1) parsing/struct packing in kernelspace.  Definitely 
> not a good solution.

Or if passed event contains opened mountpoint-to-be.
 
> I'm still partial to the idea that a usenamespace ioctl on 
> /proc/<pid>/mounts is a cleaner solution in the long run, both for 
> automounting as well as for administration tools.

Vetoed.  ioctl() is _not_ an acceptable way to implement any generic
functionality.  It basically says "my interface is a garbage".

And yes, we need to think about a new syscall for mount-related
work.  With sane API - mount(2) one is _not_.  sys_mount() would
still stay, obviously.
