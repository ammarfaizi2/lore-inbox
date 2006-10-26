Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423047AbWJZKqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbWJZKqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJZKqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:46:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423047AbWJZKqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:46:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061026003202.GH29920@ftp.linux.org.uk> 
References: <20061026003202.GH29920@ftp.linux.org.uk>  <16969.1161771256@redhat.com> <1161819459.7615.42.camel@localhost.localdomain> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 11:45:44 +0100
Message-ID: <8649.1161859544@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> > > Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst
> > > doing its own pathwalk through the cache and whilst creating files and
> > > directories in the cache.  This allows it to deal with DAC security
> > > directly.  All the directories it creates are given permissions mask
> > > 0700 and all files 0000.
> > 
> > That seems sensible and fine. It is precisely why we added a separate
> > fsuid in the first place so that the user space nfsd could take on an fs
> > identity without breaking signal and other security based forms.
> 
> I see a problem with that; not sure if that's what Christoph is objecting
> to.  What about access to cache tree by root process that has nothing
> to do with that daemon?  Should it get free access to that stuff, regardless
> of what policy might say about access to cached files?  Or should we at
> least try to make sure that we have the instances in cache no more permissive
> than originals on NFS?

Well, if the data is being copied to where userspace can get at it, and if MAC
is disabled, then it doesn't matter: root can always gain access if it wants
to, no matter what the DAC-related attributes are.

I'm quite happy to attach security data to the files in the cache, and use MAC
if it's available, but most of the time, it can't be the MAC-related attributes
of the process in who's context we're running.

David
