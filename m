Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbULBBCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbULBBCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 20:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbULBBCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 20:02:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:24277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261526AbULBBB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 20:01:57 -0500
Date: Wed, 1 Dec 2004 17:01:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       mason@suse.com
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041201170141.V2357@build.pdx.osdl.net>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil> <20041130112903.C2357@build.pdx.osdl.net> <20041130194328.GA28126@infradead.org> <20041201233203.GA22773@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041201233203.GA22773@locomotive.unixthugs.org>; from jeffm@suse.com on Wed, Dec 01, 2004 at 06:32:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeffrey Mahoney (jeffm@suse.com) wrote:
> I took some more time to find a more optimal solution. Since ReiserFS is
> currently the only filesystem that cares about this, it's far easier to keep
> the whole mess internal to ReiserFS. The issue isn't about the treating of
> "private" files in reiserfs, but rather just to avoid the looping of xattr
> calls that selinux would create.

This sounds a bit better.  BTW, which is the call chain that locks? smth like
open->permission->selinux_hook_does_getxattr->reiser_getxattr->open->permission?

<snip>
> As part of the reiserfs xattr subsystem initialization process, this patch
> copies the existing inode_operations structs and NULLs out the xattr
> operations.

This seems unecessary, just define the reiserfs_priv_foo structures
statically, like other inode ops.  As it is, looks like it will get
re-run once for each mounted superblock.

thanks,
-chris
--
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
