Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbWBUXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWBUXxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWBUXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:53:42 -0500
Received: from ns1.suse.de ([195.135.220.2]:39619 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161241AbWBUXxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:53:41 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] tmpfs: fix mount mpol nodelist parsing
Date: Wed, 22 Feb 2006 00:51:34 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, Brent Casavant <bcasavan@sgi.com>,
       Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602220051.35559.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 00:49, Hugh Dickins wrote:
> I've been dissatisfied with the mpol_nodelist mount option which was
> added to tmpfs earlier in -rc.  Replace it by mpol=policy:nodelist.
> 
> And it was broken: a nodelist is a comma-separated list of numbers and
> ranges; the mount options are a comma-separated list of token=values.
> Whoops, blindly strsep'ing on commas doesn't work so well: since we've
> no numeric tokens, and unlikely to add them, use that to distinguish.
> 
> Move the mpol= parsing to shmem_parse_mpol under CONFIG_NUMA, reject
> all its options as invalid if not NUMA.  /proc shows MPOL_PREFERRED
> as "prefer", so use that name for the policy instead of "preferred".
> 
> Enforce that mpol=default has no nodelist; that mpol=prefer has one
> node only; that mpol=bind has a nodelist; but let mpol=interleave use
> node_online_map if no nodelist given.  Describe this in tmpfs.txt.

Looks good thanks. Best would be to get that patch into 2.6.16 so
we don't end up with an broken interface in the release.

> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> Acked-by: Robin Holt <holt@sgi.com>
Acked-by: Andi Kleen <ak@suse.de>

-Andi
