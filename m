Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVITIEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVITIEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVITIEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:04:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63675 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964919AbVITIET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:04:19 -0400
Subject: Re: [RFC PATCH 6/10] vfs: shared subtree aware move mounts
From: Ram Pai <linuxram@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
In-Reply-To: <20050920072755.GJ7992@ftp.linux.org.uk>
References: <20050916182620.GA28504@RAM>
	 <20050920072755.GJ7992@ftp.linux.org.uk>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1127203454.10061.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Sep 2005 01:04:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 00:27, Al Viro wrote:
> On Fri, Sep 16, 2005 at 11:26:20AM -0700, Ram wrote:
> > Patch that help move a mount tree to a different mountpoint. The tree can
> > contain any combination of shared/slave/private/unclonable mounts.
> 
> OK, that answers the question about MS_MOVE...  Please, add brute-force
> "we don't allow it other than in trivial case" *before* the previous
> patch, replacing it with the right thing here. 
> 
> BTW, I suspect that a look at operations on ->mnt_list and friends you
> have in the entire thing would bring several inlined helpers covering
> most of the instances; there's definitely too much raw list_add(), etc.
> instances in the current code.

ok.

> 
> > +/*
> > + * return 1 if the mount tree contains a unclonable mount
> > + */
> > +static inline int tree_contains_unclone(struct vfsmount *mnt)
> > +{
> > +	struct vfsmount *p;
> > +	for (p = mnt; p; p = next_mnt(p, mnt)) {
> > +		if (IS_MNT_UNCLONABLE(p))
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> 
> FWIW, such helpers should probably go in the same place where you
> introduce unclonable - they won't complicate earlier patch and will
> be in place there and they won't clutter this one anymore.

ok and thanks for all the comments!
Very much appreciate it!!
Will have all the comments incorporated and ready for --mm tree by this
week-end,

RP

