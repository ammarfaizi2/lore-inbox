Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUHXLbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUHXLbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUHXLbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:31:41 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:40365 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267514AbUHXLbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:31:38 -0400
Subject: Re: [PATCH][7/7] add xattr support to ramfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823205942.GA3370@kroah.com>
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
	 <20040823212623.A20995@infradead.org>
	 <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
	 <20040823205942.GA3370@kroah.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093346824.1800.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 07:27:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 16:59, Greg KH wrote:
> On Mon, Aug 23, 2004 at 04:26:29PM -0400, Stephen Smalley wrote:
> > On Mon, 2004-08-23 at 16:26, Christoph Hellwig wrote:
> > > On Mon, Aug 23, 2004 at 02:22:20PM -0400, James Morris wrote:
> > > > This patch adds xattr support to tmpfs, and a security xattr handler.
> > > > Original patch from: Chris PeBenito <pebenito@gentoo.org>
> > > 
> > > What's the point on doing this for ramfs?  And if you really want this
> > > the implementation could be shared with tmpfs easily and put into xattr.c
> > 
> > For udev.
> 
> What's wrong with using a tmpfs for udev in such situations that xattrs
> are needed?  udev does not require ramfs at all.  In fact, why not just
> use a ext2 or ext3 partition for /dev instead today, if you really need
> it?

It makes no difference to me whether we use ramfs or tmpfs (I'd favor
tmpfs myself); just trying to get Fedora rawhide working again with
SELinux, and it happens to be using udev with ramfs for reasons unknown
to me.  Whatever filesystem is used, udev has to be able to set the
security attribute on the device nodes in it, so that SELinux can
properly mediate access.  Using ext2 in the short term would likely
work, but is obviously not ideal long term, and having security
attribute support for tmpfs would be useful for other uses of tmpfs
(with SELinux) as well.  Likewise, if ramfs has any significant usage,
then it would be good if we could have security attribute support for it
so that it can be labeled and access controlled properly.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

