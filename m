Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUCLWin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUCLWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:38:43 -0500
Received: from [66.35.79.110] ([66.35.79.110]:64658 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263006AbUCLWiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:38:15 -0500
Date: Fri, 12 Mar 2004 14:38:11 -0800
From: Tim Hockin <thockin@hockin.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Tim Hockin <thockin@Sun.COM>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: calling flush_scheduled_work()
Message-ID: <20040312223811.GA15636@hockin.org>
References: <20040312205814.GY1333@sun.com> <1079128848.3166.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079128848.3166.44.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 05:00:48PM -0500, Trond Myklebust wrote:
> It would be dead easy to change RPC+NFS to use their own, workqueue. In
> fact I've already considered that several times in the places where the
> NFSv4 state stuff gets hairy. ... but it might be nice not to have to
> set up all these (mostly) idle threads for exclusive use by NFS just in
> order to catch a corner case.
> 
> Could we therefore perhaps consider setting up one or more global
> workqueues that would be alternatives to keventd?

That just divides up the problem, but doesn't solve it.  The simplest would
be to print a badness and somehow get out of the flush.  Then anyone who is
triggering the corner case (us, in this case) can just solve it ourselves.
It's not pretty.

In short, it's dubious that ANYONE call flush_scheduled_work() on a
workqueue that they don't own.

Tim
