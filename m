Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWFFRrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFFRrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFFRrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:47:23 -0400
Received: from gold.veritas.com ([143.127.12.110]:46187 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750705AbWFFRrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:47:22 -0400
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="60259703:sNHT2983664444"
Date: Tue, 6 Jun 2006 18:47:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Martin Bligh <mbligh@google.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       ak@suse.de, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <4485BCC2.7040605@google.com>
Message-ID: <Pine.LNX.4.64.0606061837580.29583@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org> <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com> <4485BCC2.7040605@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 17:47:20.0578 (UTC) FILETIME=[4282F620:01C68991]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Martin Bligh wrote:
> > 
> > I'll go mad if I try to work it out again: I was as worried as you
> > when I discovered that test in sys_swapon a year or so ago, apparently
> > without any check on MAX_SWAPFILES; and went moaning to Andrew.  But
> > once I'd worked through swp_type, pte_to_swp_entry, swp_entry_to_pte,
> > swp_entry, I did come to the conclusion that the MAX_SWAPFILES bound
> > was actually safely built in there.
> 
> If it's that difficult to figure out, is that not reason enough to rip
> it all out and replace it? ;-) Life seems quite complicated enough as
> it is.

Not everyone is as deficient as I am.  But I do agree with you.

I think Martin had good reason to do his "maxpages = swp_offset(....)"
to work out the maximum pgoff expressible in an architecture's swap
offset bits; but just went overboard in doing likewise with swap type.

MAX_SWAPFILES and MAX_SWAPFILES_SHIFT are defined in the common
include/linux/swap.h, and every architecture supports that many
(some could manage more, but swp_type doesn't let them).  If an
architecture came along which somehow couldn't support that many
(seems unlikely to me), then we'd move MAX_SWAPFILES_SHIFT into
into arch-dependent files, wouldn't we?

Yes, I'm all for sys_swapon just saying "if (type >= MAX_SWAPFILES)".

Hugh
