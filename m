Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753114AbWKCE5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbWKCE5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbWKCE5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:57:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753114AbWKCE5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:57:37 -0500
Date: Fri, 03 Nov 2006 14:57:33 +1000
From: Timothy Shimmin <tes@sgi.com>
To: Andreas Gruenbacher <agruen@suse.de>
cc: linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
Message-ID: <BA8CE04BC202FBB09918854E@timothy-shimmins-power-mac-g5.local>
In-Reply-To: <200611022251.21816.agruen@suse.de>
References: <200611021724.02886.agruen@suse.de> <20061102112741.e1bb88c9.akpm@osdl.org>
 <200611022251.21816.agruen@suse.de>
X-Mailer: Mulberry/4.0.6 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

--On 2 November 2006 10:51:21 PM +0100 Andreas Gruenbacher <agruen@suse.de> wrote:

> On Thursday 02 November 2006 20:27, Andrew Morton wrote:
>> On Thu, 2 Nov 2006 17:24:02 +0100
>>
>> Andreas Gruenbacher <agruen@suse.de> wrote:
>> > The user.* extended attributes are only allowed on regular files and
>> > directories. Sticky directories further restrict write access to the
>> > owner and privileged users. (See the attr(5) man page for an
>> > explanation.)
>> >
>> > The original check in ext2/ext3 when user.* xattrs were merged was more
>> > restrictive than intended, and when the xattr permission checks were
>> > moved into the VFS, read access to user.* attributes on sticky directores
>> > ended up being denied in addition.
>>
>> Am struggling to understand the impact of this.  I assume this problem was
>> introduced on Jan 9 by e0ad7b073eb7317e5afe0385b02dcb1d52a1eedf "move xattr
>> permission checks into the VFS"?
>
> Commits e0ad7b073eb7317e5afe0385b02dcb1d52a1eedf and
> c37ef806a3e1c0bca65fd03b7590d56d19625da4 move the following check from
> ext3_xattr_user_set() to xattr_permission(), which is used in vfs_getxattr()
> as well as xfs_setxattr() and vfs_removexattr(),

> so this added the check to
> the xfs_getxattr() path by accident:
>
> []	if (!S_ISREG(inode->i_mode) &&
> []	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
> []		return -EPERM;
>
>
Now, I'm a bit confused.
xfs_getxattr?
I see the "correct" version of the test in xfs_attr.c/attr_user_capable().

--Tim
