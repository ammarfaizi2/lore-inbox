Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbUKKXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUKKXRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbUKKXQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:16:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33234 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262428AbUKKXLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:11:25 -0500
Date: Thu, 11 Nov 2004 17:10:48 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <Pine.LNX.4.44.0411111929370.2939-300000@localhost.localdomain>
Message-ID: <Pine.SGI.4.58.0411111645000.106380@kzerza.americas.sgi.com>
References: <Pine.LNX.4.44.0411111929370.2939-300000@localhost.localdomain>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004, Hugh Dickins wrote:

> The first (against 2.6.10-rc1-mm5) being my reversion of NULL sbinfo
> in shmem.c, to make it easier for others to add things into sbinfo
> without having to worry about NULL cases.  So that goes back to
> allocating an sbinfo even for the internal mount: I've rounded up to
> L1_CACHE_BYTES to avoid false sharing, but even so, please test it out
> on your 512-way to make sure I haven't screwed up the scalability we
> got before - thanks.  If you find it okay, I'll send to akpm soonish.

I won't be able to get a 512 run in until Monday, due to test machine
availability.  However runs at 32P and 64P indicate nothing disastrous.
Results seem to be in line with the numbers we were getting when doing
the NULL sbinfo work.

So, thus far a preliminary "Looks good".

> The second (against the first) being my take on your patch, with
> mpol=interleave, and minor alterations which may irritate you so much
> you'll revert them immediately! (mainly, using MPOL_INTERLEAVE and
> MPOL_DEFAULT within shmem.c rather than defining separate flags).
> Only slightly tested at this end.

Seems to work just fine, and I rather like how this was made a bit more
general.  Thumbs up!

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
