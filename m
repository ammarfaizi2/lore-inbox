Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTCJLzP>; Mon, 10 Mar 2003 06:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261303AbTCJLzP>; Mon, 10 Mar 2003 06:55:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23967 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261302AbTCJLzO>; Mon, 10 Mar 2003 06:55:14 -0500
Date: Mon, 10 Mar 2003 12:07:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ed Tomlinson <tomlins@cam.org>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nonlinear oddities
In-Reply-To: <20030309013747.D394BC0@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.44.0303101150480.1145-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Mar 2003, Ed Tomlinson wrote:
> Dave McCracken wrote:
> > --On Thursday, March 06 2003, Hugh Dickins wrote:
> > 
> >> Now I think about it more, install_page's SetPageAnon is not good at all.
> >> That (unlocked) page may already be mapped into other vmas as a shared
> >> file page, non-zero mapcount, we can't suddenly switch it to Anon
> >> (pte_chained) without doing the work to handle that case.
> > 
> > Ouch.  You're right.  I'll go stare at it for awhile and see if any
> > solutions jump out at me.  I suppose at worst I could write a function to
> > convert an object page to use pte_chains, but it'd be nice if that weren't
> > necessary.
> 
> Does this look like the above happening?  

I very much doubt it.  You'd have to be running an application using Ingo's
new (since 2.5.46) remap_file_pages system call to suffer from Dave's ouch
e.g. something like an experimental version of a major database app.  That
said, I've given no thought to what that ouch might look like in practice.

Hugh

