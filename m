Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUHXCxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUHXCxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUHXCxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:53:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267370AbUHXCxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:53:00 -0400
Date: Tue, 24 Aug 2004 03:52:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
Message-ID: <20040824025259.GC21964@parcelfarce.linux.theplanet.co.uk>
References: <1093288398.27211.257.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0408232046290.16044-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408232046290.16044-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 08:54:14PM -0400, James Morris wrote:
> On Mon, 23 Aug 2004, Stephen Smalley wrote:
> 
> > On Mon, 2004-08-23 at 15:03, Christoph Hellwig wrote:
> 
> > > Given that the actual methods take a dentry this sounds like a bad design.
> > > Can;t you just pass down the dentry through all of the ext2 interfaces?
> > 
> > Changing the methods to take an inode would be even better, IMHO, as the
> > dentry is unnecessary.  That would simplify SELinux as well.
> 
> This could work for all in-tree filesystems with xattrs, except CIFS,
> which passes the dentry to it's own build_path_from_dentry() function.  
> 
> (In this case, they probably want to use d_path() and have a vfsmnt added 
> to the methods?).

No.  Think for a second and you'll see why - we are doing an operation that
by definition should not depend on where we have mounted the filesystem in
question.
