Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVCCF0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVCCF0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCCFYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:24:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31677 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261489AbVCCFRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:17:52 -0500
Date: Wed, 2 Mar 2005 21:17:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <20050302205612.451d220b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503022110280.4083@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
 <20050302174507.7991af94.akpm@osdl.org> <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
 <20050302185508.4cd2f618.akpm@osdl.org> <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
 <20050302201425.2b994195.akpm@osdl.org> <Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
 <20050302205612.451d220b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:

> Have the ppc64 and sparc64 people reviewed and acked the change?  (Not a
> facetious question - I just haven't been following the saga sufficiently
> closely to remember).

There should be no change to these arches

> > Because if a pte is locked it should not be used.
>
> Confused.  Why not just spin on the lock in the normal manner?

I thought you wanted to lock the pte? This is realized through a lock bit
in the pte. If that lock bit is set one should not use the pte. Otherwise
the lock is bypassed. Or are you proposing a write lock only?

> If the other relvant architecture people say "we can use this" then perhaps
> we should grin and bear it.  But one does wonder whether some more sweeping
> design change is needed.

Could we at least get the first two patches in? I can then gradually
address the other issues piece by piece.

The necessary more sweeping design change can be found at

http://marc.theaimsgroup.com/?l=linux-kernel&m=110922543030922&w=2

but these may be a long way off. These patches address an urgent issue
that we have with higher CPU counts for a long time and the method used
here has been used for years in our ProPack line.
