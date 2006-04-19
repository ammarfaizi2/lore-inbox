Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWDSQKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWDSQKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDSQKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:10:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:1966 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750929AbWDSQKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:10:51 -0400
Date: Wed, 19 Apr 2006 09:06:27 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Yuichi Nakamura <ynakam@gwu.edu>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kurt Garloff <garloff@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419160627.GA27252@kroah.com>
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org> <20060418213833.GC5741@tpkurt.garloff.de> <20060419121034.GE20481@sergelap.austin.ibm.com> <e133c9da8fcba.8fcbae133c9da@gwu.edu> <20060419154419.GB26635@kroah.com> <1145462552.24289.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145462552.24289.137.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 12:02:32PM -0400, Stephen Smalley wrote:
> On Wed, 2006-04-19 at 08:44 -0700, Greg KH wrote:
> > On Wed, Apr 19, 2006 at 08:55:56AM -0400, Yuichi Nakamura wrote:
> > > However, path-name based configuration can not be achieved on SELinux in
> > > following cases.
> > > 1) Files on file system that does not support xattr(such as sysfs)
> > >    SELinux policy editor handles all files as same on such file systems.
> > 
> > Hm, I've thought about this in the past and wonder if we should add
> > xattr support to sysfs.  Would it be useful for things like SELinux?
> > The files would not be created with any xattrs, but would be able to
> > have them once they are set.  Would that be good enough?
> 
> The generic security xattr fallback behavior in the VFS already provides
> us with most of what we need there.  The only thing missing is a way to
> preserve the attributes when inodes are evicted and later re-created
> from sysfs_dirent.

Yeah, without that, it's probably pretty useless :)
Take a look at the patch that added support for owner/mode settings, it
shouldn't be that hard to also add xattr support there.

> One of our people was experimenting with a patch to save and restore
> that information, but we are waiting for some of the audit work to
> finalize as that exports some interfaces from SELinux to the rest of
> the kernel that we need.

That sounds fine, thanks for letting me know.

greg k-h
