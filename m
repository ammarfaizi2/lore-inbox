Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHKIMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHKIMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHKIMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:12:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750767AbWHKIMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:12:00 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060810125306.61425f94.akpm@osdl.org> 
References: <20060810125306.61425f94.akpm@osdl.org>  <E1GB6qO-0003qU-00@dorka.pomaz.szeredi.hu> 
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, zam@namesys.com,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH try #2] fuse: fix error case in fuse_readpages 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 11 Aug 2006 09:11:47 +0100
Message-ID: <18358.1155283907@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Don't let fuse_readpages leave the @pages list not empty when exiting
> > on error.
> > 
> 
> Oh dear.  read_cache_pages_release_page() is not a readahead thing.  It is
> a dhowells fscache thing.

The pages passed to read_cache_pages() may already be marked with metadata
information (such as to-be-cached marks from NFS or AFS calling FS-Cache), so
we can't just ditch the pages on an error, we have to clean them up properly.

David
