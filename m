Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWELR6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWELR6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWELR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:58:12 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:38359 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932092AbWELR6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:58:12 -0400
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, hch@lst.de
In-Reply-To: <20060512105320.5d9f932c.akpm@osdl.org>
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu>
	 <20060501143344.3952ff53.akpm@osdl.org>
	 <1147455407.23563.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20060512105320.5d9f932c.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 12 May 2006 14:02:16 -0400
Message-Id: <1147456936.23563.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 10:53 -0700, Andrew Morton wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On Mon, 2006-05-01 at 14:33 -0700, Andrew Morton wrote:
> > > Valdis.Kletnieks@vt.edu wrote:
> > > >
> > > > There seems to have been a bug introduced in this changeset:
> > > > 
> > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> > > > 
> > > > Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
> > > > misbehaves:
> > > > 
> > > > > # mkdir /foo
> > > > > # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> > > > > # mkdir /foo/bar
> > > > > # mount --bind /foo/bar /foo
> > > > > # tail -2 /proc/mounts
> > > > > none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> > > > > none /foo tmpfs rw 0 0
> > > > 
> > > > Reverting this changeset causes both mounts to have the same options.
> > > > 
> > > > (Thanks to Stephen Smalley for tracking down the changeset...)
> > > > 
> > > 
> > > (cc's added)
> > 
> > What's the verdict on this change in user-visible behavior for bind
> > mounts?  Is it a legitimate change and userland just needs to adapt to
> > it, or is it a change to the kernel's stable ABI that needs to be
> > reverted?  It still appears to be present in -rc4.
> > 
> 
> Well.  We'd certainly prefer to not change user-visible behaviour without
> excellent reasons - I don't htink any have been given, really.
> 
> AFACIT nobody tested Herbert's 'untested "fix"'.  What was the verdict on
> that?

The untested 'fix' makes the rest of the patch pointless (no point in
passing the mnt_flags if we aren't going to use them).  Might as well
just revert the patch altogether.

-- 
Stephen Smalley
National Security Agency

