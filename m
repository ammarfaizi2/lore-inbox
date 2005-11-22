Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVKVNgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVKVNgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKVNgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:36:43 -0500
Received: from hera.kernel.org ([140.211.167.34]:33514 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751309AbVKVNgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:36:42 -0500
Date: Tue, 22 Nov 2005 06:08:56 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly account readahead file major faults
Message-ID: <20051122080856.GA30761@logos.cnet>
References: <20051121140038.GA27349@logos.cnet> <20051122042443.GA4588@mail.ustc.edu.cn> <20051122062321.GA30413@logos.cnet> <Pine.LNX.4.61.0511221249470.24803@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511221249470.24803@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh!

On Tue, Nov 22, 2005 at 12:55:02PM +0000, Hugh Dickins wrote:
> On Tue, 22 Nov 2005, Marcelo Tosatti wrote:
> > 
> > Pages which hit the first time in cache due to readahead _have_ caused
> > IO, and as such they should be counted as major faults.
> 
> Have caused IO, or have benefitted from IO which was done earlier?

Which caused IO, either synchronously or via (previously read)
readahead.

> It sounds debatable, each will have their own idea of what's major.

I see your point... and I much prefer the "majflt means IO performed"
definition :)

As a user I want to know how many pages have been read in from disk to
service my application requests.

>From the "time" manpage:

F      Number of major, or I/O-requiring, page faults  that  oc-
       curred  while  the process was running.  These are faults
       where the page has actually migrated out of primary memo-
       ry.

> Maybe PageUptodate at the time the entry is found in the page cache
> should come into it?  !PageUptodate implying that we'll be waiting
> for read to complete.

Hum, I still strongly feel that users care about IO performed and not
readahead effectiveness (which could be separate information).

I don't think the semantics are precisely defined anywhere are they?
