Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWELSMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWELSMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWELSMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:12:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWELSMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:12:13 -0400
Date: Fri, 12 May 2006 11:09:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Valdis.Kletnieks@vt.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, hch@lst.de
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
Message-Id: <20060512110903.4d76b191.akpm@osdl.org>
In-Reply-To: <1147456936.23563.73.camel@moss-spartans.epoch.ncsc.mil>
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu>
	<20060501143344.3952ff53.akpm@osdl.org>
	<1147455407.23563.59.camel@moss-spartans.epoch.ncsc.mil>
	<20060512105320.5d9f932c.akpm@osdl.org>
	<1147456936.23563.73.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Fri, 2006-05-12 at 10:53 -0700, Andrew Morton wrote:
> > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >
> > > On Mon, 2006-05-01 at 14:33 -0700, Andrew Morton wrote:
> > > > Valdis.Kletnieks@vt.edu wrote:
> > > > >
> > > > > There seems to have been a bug introduced in this changeset:
> > > > > 
> > > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> > > > > 
> > > > > Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
> > > > > misbehaves:
> > > > > 
> > > > > > # mkdir /foo
> > > > > > # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> > > > > > # mkdir /foo/bar
> > > > > > # mount --bind /foo/bar /foo
> > > > > > # tail -2 /proc/mounts
> > > > > > none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> > > > > > none /foo tmpfs rw 0 0
> > > > > 
> > > > > Reverting this changeset causes both mounts to have the same options.
> > > > > 
> > > > > (Thanks to Stephen Smalley for tracking down the changeset...)
> > > > > 
> > > > 
> > > > (cc's added)
> > > 
> > > What's the verdict on this change in user-visible behavior for bind
> > > mounts?  Is it a legitimate change and userland just needs to adapt to
> > > it, or is it a change to the kernel's stable ABI that needs to be
> > > reverted?  It still appears to be present in -rc4.
> > > 
> > 
> > Well.  We'd certainly prefer to not change user-visible behaviour without
> > excellent reasons - I don't htink any have been given, really.
> > 
> > AFACIT nobody tested Herbert's 'untested "fix"'.  What was the verdict on
> > that?
> 
> The untested 'fix' makes the rest of the patch pointless (no point in
> passing the mnt_flags if we aren't going to use them).  Might as well
> just revert the patch altogether.

OK, I queued a revert.  It seems to be the sanest thing to do at this time
- Herbert can have another go later..
