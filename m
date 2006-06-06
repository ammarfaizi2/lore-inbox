Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWFFRp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFFRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWFFRp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:45:29 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:40283 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750764AbWFFRp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:45:28 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Martin Bligh <mbligh@google.com>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <4485BCC2.7040605@google.com>
References: <447DEF49.9070401@google.com>
	 <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org>
	 <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org>
	 <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org>
	 <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	 <44848DD2.7010506@shadowen.org>
	 <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
	 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
	 <20060605135812.30138205.akpm@osdl.org>
	 <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
	 <4485BCC2.7040605@google.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 06 Jun 2006 19:45:30 +0200
Message-Id: <1149615930.29059.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 10:34 -0700, Martin Bligh wrote:
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

Is it that complicated? You convert UINT_MAX as the type to a swap entry
and back to a number. __swp_entry_to_pte() needs to do the correct
masking. If it doesn't it is broken. The alternative would be to add
architecture defines with the maximum number of swap devices and the
maximum swap offset.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


