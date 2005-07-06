Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVGFT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGFT6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVGFT4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262089AbVGFPfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:35:34 -0400
Date: Wed, 6 Jul 2005 11:35:12 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Greg KH <greg@kroah.com>, Tony Jones <tonyj@suse.de>, <serge@hallyn.com>,
       <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
In-Reply-To: <1120652941.18855.45.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0507061125530.7680-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Stephen Smalley wrote:

> > Stephen: opinions on this?
> 
> The reason for creating a kernel mount of selinuxfs at that point is so
> that the selinuxfs_mount vfsmount and selinux_null dentry are available
> for flush_unauthorized_files to use.

When exactly is this needed?  The securityfs mountpoint will be available 
via a core_initcall, after which we can initialize the selinux subtree.

> Userspace compatibility is obviously a concern for such a change.
> libselinux determines where selinuxfs is mounted during library
> initialization by checking /proc/mounts for selinuxfs, and rc.sysinit
> does likewise.
>
>  /sbin/init performs the initial mount of selinuxfs prior
> to initial policy load.

With securityfs, we'd have /sys/kernel/security/selinux configured during 
kernel initialization.

> Further, the existence of selinuxfs
> in /proc/filesystems is used as a test of whether SELinux was enabled in
> the kernel (e.g. is_selinux_enabled in libselinux).

Could be a simple change to look for the presence of
/sys/kernel/security/selinux

> I'm not sure such a change is worthwhile for SELinux; large amount of
> disruption for little real gain.

I think it should reduce and simplify the SELinux kernel code, with less
filesystems in the kernel, consolidating several potential projects into
the same security filesystem.


- James
-- 
James Morris
<jmorris@redhat.com>


