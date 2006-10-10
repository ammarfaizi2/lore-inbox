Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWJJMuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWJJMuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWJJMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:50:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965165AbWJJMuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:50:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1160480576.5466.27.camel@lade.trondhjem.org> 
References: <1160480576.5466.27.camel@lade.trondhjem.org>  <1160170629.5453.34.camel@lade.trondhjem.org> <2069.1160473410@redhat.com> 
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 10 Oct 2006 13:49:56 +0100
Message-ID: <5657.1160484596@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> No. Invalidatepage does precisely the wrong thing: it invalidates dirty
> data instead of committing it to disk. If you need to have the data
> invalidated, then you should call truncate_inode_pages().

Hmmm... Good point, but you still need to handle try_to_release_page() failing,
but that only means checking the return value of invalidate_inode_pages2_range
(which you don't do, I notice).  Or is it defined that if must succeed if
__GFP_WAIT is set?

With the two-phase thing, I think I'm thinking of the wrong portion of that
file (I'm thinking of truncate_inode_pages_range()).

Should invalidate_inode_pages2_range() take a gfp_t argument to pass on down?

David
