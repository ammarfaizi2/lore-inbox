Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWJZAcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWJZAcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 20:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJZAcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 20:32:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37289 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964805AbWJZAcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 20:32:13 -0400
Date: Thu, 26 Oct 2006 01:32:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching
Message-ID: <20061026003202.GH29920@ftp.linux.org.uk>
References: <16969.1161771256@redhat.com> <1161819459.7615.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161819459.7615.42.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 12:37:39AM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-25 am 11:14 +0100, ysgrifennodd David Howells:
> > Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> > own pathwalk through the cache and whilst creating files and directories in the
> > cache.  This allows it to deal with DAC security directly.  All the directories
> > it creates are given permissions mask 0700 and all files 0000.
> 
> That seems sensible and fine. It is precisely why we added a separate
> fsuid in the first place so that the user space nfsd could take on an fs
> identity without breaking signal and other security based forms.

I see a problem with that; not sure if that's what Christoph is objecting
to.  What about access to cache tree by root process that has nothing
to do with that daemon?  Should it get free access to that stuff, regardless
of what policy might say about access to cached files?  Or should we at
least try to make sure that we have the instances in cache no more permissive
than originals on NFS?
