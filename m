Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWFULNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWFULNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWFULNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:13:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751375AbWFULNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:13:38 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <44980064.6040306@yahoo.com.au>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <4497EAC6.3050003@yahoo.com.au>
	 <1150807630.3856.1372.camel@quoit.chygwyn.com>
	 <44980064.6040306@yahoo.com.au>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Wed, 21 Jun 2006 12:20:54 +0100
Message-Id: <1150888854.3856.1494.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-06-21 at 00:04 +1000, Nick Piggin wrote:
> Thanks.
> 
> Steven Whitehouse wrote:
> >  kernel/printk.c                    |    1 
> >  mm/filemap.c                       |    1 
> >  mm/readahead.c                     |    1 
> 
> These EXPORTs are a bit unfortunate.
> 
> BTW. you have one function that calls file_ra_state_init but never appears
> to use the initialized ra_state.
> 
> Why is gfs2_internal_read() called the "external read function" in the
> changelog?
> 
> The internal_read function doesn't look like a great candidate for passing
> a ra_state to, which invokes all the mechanism expecting a regular file
> being accessed by a user program.
> 
> It seems as though you could explicitly control readahead more optimally,
> but I don't know what the best way to do that would be. I assume Andrew
> has had a quick look and doesn't know either.
> 
> The part where you needed file_read_actor looks like pretty much a stright
> cut and paste from __generic_file_aio_read, which indicates that you might
> be exporting at the wrong level.
> 
Having thought about this a bit more and taken some advice, I've changed
this export (file_read_actor) to _GPL so that all three of the exports
you mention are now _GPL exports.

The updated tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git

Let me know if you still feel that there are further issues to look at,

Steve.


