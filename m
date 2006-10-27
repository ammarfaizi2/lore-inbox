Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752360AbWJ0RfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbWJ0RfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbWJ0RfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:35:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752359AbWJ0RfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:35:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161968942.1306.87.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161968942.1306.87.camel@moss-spartans.epoch.ncsc.mil>  <1161965410.1306.47.camel@moss-spartans.epoch.ncsc.mil> <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil> <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <2340.1161903200@redhat.com> <4786.1161963766@redhat.com> <5506.1161966323@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, aviro@redhat.com,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 18:34:10 +0100
Message-ID: <7451.1161970450@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > You start the cache by mounting it:
> > 
> > 	mount -t cachefs /dev/hdx9 /cachefs
> > 
> > Then it's online.  However, you might want to check that whoever's calling
> > mount has permission to bring a cache online...
> 
> Hmmm...that raises a separate issue - how does SELinux label cachefs
> inodes?  Does cachefs support xattrs?  Other option is to use a mount
> context (mount -o context=...) to apply a single context to all inodes
> within it.

There are only two inodes publically available through cachefs - the root dir
and a file of statistics - and they're both read only.  Everything else, for
the moment, is strictly internal and unavailable to userspace.  In fact, there
may not be any other inodes.

> Where exactly is the cachefs code available?

It'll need a little bit of work to make it compilable again; but I can probably
get you a copy on Monday.  I've been concentrating on CacheFiles.

> I'm also unclear on where you establish the binding between the files
> being cached and the cache.  What specifies that e.g. a given NFS mount
> should be backed to a given cache?  We need to be able to control that
> relationship too, to establish that the cache is being protected
> adequately for the source data.

Yes.  I haven't worked that one out yet.  Currently it's not a problem as only
CacheFiles is available at the moment, and that currently only supports one
cache.

But I have an idea that I need to work on to make it possible to associate
directories and files with caches (or other useful parameters).

> >  (1) Permission to bring a cache online or to take a cache offline.
> 
> At present, this will show up as the usual checking on mount (security
> hooks in do_mount and vfs_kern_mount) and on umount (security hook in
> do_umount) by SELinux.  I'm not sure whether you need anything specific
> to the cache.

That doesn't apply to CacheFiles, but okay; we can always add it later if we
decide we want it.

David
