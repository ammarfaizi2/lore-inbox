Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWEMNyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWEMNyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWEMNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 09:54:47 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:58599 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932402AbWEMNyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 09:54:47 -0400
Date: Sat, 13 May 2006 15:54:45 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Valdis.Kletnieks@vt.edu,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
Message-ID: <20060513135445.GA20711@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Stephen Smalley <sds@tycho.nsa.gov>, Valdis.Kletnieks@vt.edu,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, hch@lst.de
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu> <20060501143344.3952ff53.akpm@osdl.org> <1147455407.23563.59.camel@moss-spartans.epoch.ncsc.mil> <20060512105320.5d9f932c.akpm@osdl.org> <1147456936.23563.73.camel@moss-spartans.epoch.ncsc.mil> <20060512110903.4d76b191.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512110903.4d76b191.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 11:09:03AM -0700, Andrew Morton wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On Fri, 2006-05-12 at 10:53 -0700, Andrew Morton wrote:
> > > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >
> > > > On Mon, 2006-05-01 at 14:33 -0700, Andrew Morton wrote:
> > > > > Valdis.Kletnieks@vt.edu wrote:
> > > > > >
> > > > > > There seems to have been a bug introduced in this changeset:
> > > > > > 
> > > > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> > > > > > 
> > > > > > Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
> > > > > > misbehaves:
> > > > > > 
> > > > > > > # mkdir /foo
> > > > > > > # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> > > > > > > # mkdir /foo/bar
> > > > > > > # mount --bind /foo/bar /foo
> > > > > > > # tail -2 /proc/mounts
> > > > > > > none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> > > > > > > none /foo tmpfs rw 0 0
> > > > > > 
> > > > > > Reverting this changeset causes both mounts to have the same options.
> > > > > > 
> > > > > > (Thanks to Stephen Smalley for tracking down the changeset...)
> > > > > > 
> > > > > 
> > > > > (cc's added)
> > > > 
> > > > What's the verdict on this change in user-visible behavior for bind
> > > > mounts?  Is it a legitimate change and userland just needs to adapt to
> > > > it, or is it a change to the kernel's stable ABI that needs to be
> > > > reverted?  It still appears to be present in -rc4.
> > > > 
> > > 
> > > Well.  We'd certainly prefer to not change user-visible behaviour without
> > > excellent reasons - I don't htink any have been given, really.
> > > 
> > > AFACIT nobody tested Herbert's 'untested "fix"'.  What was the verdict on
> > > that?
> > 
> > The untested 'fix' makes the rest of the patch pointless (no point in
> > passing the mnt_flags if we aren't going to use them).  Might as well
> > just revert the patch altogether.
> 
> OK, I queued a revert.  It seems to be the sanest thing to do at this time
> - Herbert can have another go later..

okay, probably the best choice right now, had a chat
with hch, and will try to achieve the new functionality
with remount instead of mount -o bind, which seems to
be a less intrusive way from the userspace PoV

best,
Herbert

