Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUC3PP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUC3PP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:15:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51104
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263709AbUC3PPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:15:19 -0500
Date: Tue, 30 Mar 2004 17:15:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [andrea@suse.de: Re: 2.6.5-rc2-aa vma merging]
Message-ID: <20040330151518.GY3808@dualathlon.random>
References: <20040329223307.GH3808@dualathlon.random> <Pine.LNX.4.44.0403300613280.20766-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403300613280.20766-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 06:27:18AM +0100, Hugh Dickins wrote:
> On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> > On Mon, Mar 29, 2004 at 08:44:25PM +0100, Hugh Dickins wrote:
> > 
> > > So I assume that what's there is needed, and the example below
> > > does looks plausible enough: add page, fill it, protect it, ...
> > 
> > this will work perfect, absolutely perfect. You didn't read my code well
> > enough.
> 
> Sure, and I most certainly haven't read your future code well enough.
> Your present implementation, one vma per page (in that real case where
> vmas are properly merged by mainline or anonmm), is far from perfect.
> 
> anon_vma has surprised me more than once by working smoothly just
> where I thought it must go wrong.  Please do surprise me again:
> write that code and post the patch which resolves this doubt.

I will, it just wasn't high prio enough at this time (I mean, I still
have pending some prio-tree bit to fixup with the xfs, that was higher
prio since it impacts functionality, and the mremap race may also be
higher prio).

My point is that merging in your program will work fine, this is what
matters to me, it doesn't right now because I didn't fixup the merging
code yet, but there's nothing that will prevent your program to use just
1 single vma for the whole thing (after I fixup the merging code ;). The
bonus is that after I fixup the merging, it'll use 1 vma even for the
file mappings, not just for anonymous memory, something that is not true
with anonmm (and the complexity of doing file merging or anon-vma
merging is the same, so I will do both at the same cost).
