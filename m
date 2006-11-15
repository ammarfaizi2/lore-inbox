Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbWKOQMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWKOQMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWKOQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:12:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030592AbWKOQMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:12:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061115155205.GA3911@infradead.org> 
References: <20061115155205.GA3911@infradead.org>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200702.12943.39624.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       sds@tycho.nsa.gov, trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 19/19] CacheFiles: Permit daemon to probe inuseness of a cache file 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 16:10:08 +0000
Message-ID: <26620.1163607008@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Once again a very strong NACK for anything that gets a fd argument as
> text from userspace.

Why?  Would you rather I passed it in a struct to an ioctl?

> Also a very strong NACK for use of fget/fget_light from non-core code and
> exports for either of them.

Why?

I could possibly pass the pathname as text, except that (a) the path length
may exceed PAGE_SIZE and MAXPATHLEN, and (b) doing a full path lookup() is a
complete waste of time as the daemon already has the directory open on a file
descriptor, and so effectively has a bookmark to the location that I can use,
if I can but get hold of it.

David
