Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264371AbTCXT13>; Mon, 24 Mar 2003 14:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264373AbTCXT13>; Mon, 24 Mar 2003 14:27:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10903 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264371AbTCXT12>; Mon, 24 Mar 2003 14:27:28 -0500
Subject: Re: [PATCH] anobjrmap 2/6 mapping
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030320224832.0334712d.akpm@digeo.com>
References: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
	 <Pine.LNX.4.44.0303202312560.2743-100000@localhost.localdomain>
	 <20030320224832.0334712d.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048534712.1907.398.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 19:38:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2003-03-21 at 06:48, Andrew Morton wrote:

> It goes BUG in try_to_free_buffers().
> 
> We really should fix this up for other reasons, probably by making ext3's
> per-page truncate operations wait on commit, and be more aggressive about
> pulling the page's buffers off the transaction at truncate time.

Ouch.

> The same thing _could_ happen with other filesystems; not too sure about
> that.

XFS used to have synchronous truncates, for similar sorts of reasons. 
It was dog slow for unlinks.  They worked pretty hard to fix that; I'd
really like to avoid adding extra synchronicity to ext3 in this case.

Pulling buffers off the transaction more aggressively would certainly be
worth looking at.  Trouble is, if a truncate transaction on disk gets
interrupted by a crash, you really do have to be able to undo it, so you
simply don't have the luxury of throwing the buffers away until a commit
has occurred (unless you're in writeback mode.)

--Stephen

