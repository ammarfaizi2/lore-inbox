Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUHXTaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUHXTaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHXTai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:30:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:26346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268238AbUHXT31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:29:27 -0400
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
From: Andreas Gruenbacher <agruen@suse.de>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Steve French <sfrench@us.ibm.com>
In-Reply-To: <20040824025259.GC21964@parcelfarce.linux.theplanet.co.uk>
References: <1093288398.27211.257.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0408232046290.16044-100000@thoron.boston.redhat.com>
	 <20040824025259.GC21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1093375652.20259.73.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 21:27:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 04:52, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Mon, Aug 23, 2004 at 08:54:14PM -0400, James Morris wrote:
> > On Mon, 23 Aug 2004, Stephen Smalley wrote:
> > 
> > > On Mon, 2004-08-23 at 15:03, Christoph Hellwig wrote:
> > 
> > > > Given that the actual methods take a dentry this sounds like a bad design.
> > > > Can;t you just pass down the dentry through all of the ext2 interfaces?
> > > 
> > > Changing the methods to take an inode would be even better, IMHO, as the
> > > dentry is unnecessary.  That would simplify SELinux as well.
> > 
> > This could work for all in-tree filesystems with xattrs, except CIFS,
> > which passes the dentry to it's own build_path_from_dentry() function.  
> > 
> > (In this case, they probably want to use d_path() and have a vfsmnt added 
> > to the methods?).
> 
> No.  Think for a second and you'll see why - we are doing an operation that
> by definition should not depend on where we have mounted the filesystem in
> question.

Hm. I seem to recall that Al didn't want to change this within the 2.6
series -- is this still the case? I would favor switching from dentries
to inodes in the xattr iops. Steve, can you live with inodes?

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


