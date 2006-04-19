Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWDSP6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDSP6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDSP6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:58:43 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:32255 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750750AbWDSP6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:58:42 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Greg KH <greg@kroah.com>
Cc: Yuichi Nakamura <ynakam@gwu.edu>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kurt Garloff <garloff@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060419154419.GB26635@kroah.com>
References: <20060417225525.GA17463@infradead.org>
	 <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
	 <20060418115819.GB8591@infradead.org>
	 <20060418213833.GC5741@tpkurt.garloff.de>
	 <20060419121034.GE20481@sergelap.austin.ibm.com>
	 <e133c9da8fcba.8fcbae133c9da@gwu.edu>  <20060419154419.GB26635@kroah.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 12:02:32 -0400
Message-Id: <1145462552.24289.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 08:44 -0700, Greg KH wrote:
> On Wed, Apr 19, 2006 at 08:55:56AM -0400, Yuichi Nakamura wrote:
> > However, path-name based configuration can not be achieved on SELinux in
> > following cases.
> > 1) Files on file system that does not support xattr(such as sysfs)
> >    SELinux policy editor handles all files as same on such file systems.
> 
> Hm, I've thought about this in the past and wonder if we should add
> xattr support to sysfs.  Would it be useful for things like SELinux?
> The files would not be created with any xattrs, but would be able to
> have them once they are set.  Would that be good enough?

The generic security xattr fallback behavior in the VFS already provides
us with most of what we need there.  The only thing missing is a way to
preserve the attributes when inodes are evicted and later re-created
from sysfs_dirent.  One of our people was experimenting with a patch to
save and restore that information, but we are waiting for some of the
audit work to finalize as that exports some interfaces from SELinux to
the rest of the kernel that we need.

-- 
Stephen Smalley
National Security Agency

