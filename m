Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWJJLnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWJJLnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJJLnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:43:07 -0400
Received: from mx2.netapp.com ([216.240.18.37]:25953 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030179AbWJJLnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:43:03 -0400
X-IronPort-AV: i="4.09,289,1157353200"; 
   d="scan'208"; a="416638476:sNHT41967176"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <2069.1160473410@redhat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	 <2069.1160473410@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Tue, 10 Oct 2006 07:42:56 -0400
Message-Id: <1160480576.5466.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 10 Oct 2006 11:43:13.0958 (UTC) FILETIME=[44F5CC60:01C6EC61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 10:43 +0100, David Howells wrote:
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> 
> > -	if (PagePrivate(page) && !try_to_release_page(page, 0))
> > +	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
> 
> This can't be the right way to fix things.  try_to_release_page() may fail
> whatever GFP flags you give it.  If the page *must* be invalidated at this
> point then you _must_ call the invalidatepage() op, not the releasepage() op.

No. Invalidatepage does precisely the wrong thing: it invalidates dirty
data instead of committing it to disk. If you need to have the data
invalidated, then you should call truncate_inode_pages().

Trond
