Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUJSBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUJSBdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJSBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:33:36 -0400
Received: from waste.org ([209.173.204.2]:31641 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268249AbUJSBdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:33:23 -0400
Date: Mon, 18 Oct 2004 20:32:39 -0500
From: Matt Mackall <mpm@selenic.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/3] ext3 reservation remove stale window fix
Message-ID: <20041019013239.GT31237@waste.org>
References: <1098140107.8803.1062.camel@w-ming2.beaverton.ibm.com> <20041018234126.GB28904@waste.org> <1098148283.9754.1090.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098148283.9754.1090.camel@w-ming2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 06:11:16PM -0700, Mingming Cao wrote:
> On Mon, 2004-10-18 at 16:41, Matt Mackall wrote:
> > On Mon, Oct 18, 2004 at 03:55:04PM -0700, Mingming Cao wrote:
> > > 
> > > Before we changed the per-filesystem reservations from a linked list
> > > to a red-black tree, in order to speed up the linear search from the
> > > list head, we keep the current(stale) reservation window as a
> > > reference pointer to skip the nodes prior to the current/stale
> > > window node, when failed to allocate a new window in current group
> > > and try to do allocation in next group.
> > 
> > One wonders whether a prio tree of the sort used by the current VMA
> > searching code would be a better match to the problem than the
> > red-black approach.
> 
> Could you please elaborate more? I think the current VMA code is using
> red-black tree in their searching code(find_vma()).

I was thinking of the priority search tree stuff in mm/prio_tree.c.
But on further reflection, they're not really advantageous here as the
windows in question are non-overlapping and the RB approach looks
perfectly sensible.

-- 
Mathematics is the supreme nostalgia of our time.
