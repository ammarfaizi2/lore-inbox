Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKWTwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKWTwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKWTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:50:04 -0500
Received: from [144.51.25.10] ([144.51.25.10]:17842 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261552AbUKWTsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:48:23 -0500
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <41A38F10.8000609@suse.com>
References: <20041121001318.GC979@locomotive.unixthugs.org>
	 <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>
	 <41A22A2D.1000708@suse.com>
	 <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil>
	 <41A23922.80501@suse.com> <20041122123000.C14339@build.pdx.osdl.net>
	 <41A38F10.8000609@suse.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101238981.19785.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 23 Nov 2004 14:43:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 14:27, Jeff Mahoney wrote:
> Chris Wright wrote:
> | Why add extra hook, when this could be done in VFS with i_flags?
> 
> Sure, it could be done w/ an i_flags bit. However, since it's explicitly
> related to the security infrastructure, I think it's more appropriate
> there. There's no change in the size of inode_security_struct, and the
> addition of the deref is trivial given how many other places in the
> file-io path use the same call table. That said, I'll change it to use
> whatever ends up being agreed upon. I'm just looking to get selinux to
> not call xattr routines on reiserfs-internal files/directories.

I suppose the question is whether the VFS maintainer thinks that this
reiserfs private inode flag should be made visible in the i_flags, or
whether it should remain private to reiserfs and only explicitly
exported to the security modules via the new hook.  We can implement the
corresponding SELinux support for handling such private inodes either
way.  Would the VFS ever make use of the flag itself, e.g. to skip DAC
permission checking on such inodes as well?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

