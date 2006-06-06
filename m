Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWFFSFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWFFSFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFFSFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:05:55 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:55171 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750835AbWFFSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:05:54 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.64.0606061850001.30030@blonde.wat.veritas.com>
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
	 <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606061850001.30030@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 06 Jun 2006 20:05:55 +0200
Message-Id: <1149617155.29059.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 18:59 +0100, Hugh Dickins wrote:
> Even s390 is okay, isn't it?  MartinS's swp_type returns the highest
> type, 31, corresponding to 32 types, as on every other architecture.
> You and I and Martin Bligh would prefer this patch...
> 
> 
> Remove unnecessary obfuscation from sys_swapon's range check on swap
> type, which blew up causing memory corruption once swapless migration
> made MAX_SWAPFILES no longer 2 ^ MAX_SWAPFILES_SHIFT.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.6.17-rc5-mm3/mm/swapfile.c	2006-06-04 11:52:47.000000000 +0100
> +++ linux/mm/swapfile.c	2006-06-06 18:53:40.000000000 +0100
> @@ -1404,7 +1404,7 @@ asmlinkage long sys_swapon(const char __
>  	 * from the initial ~0UL that can't be encoded in either the
>  	 * swp_entry_t or the architecture definition of a swap pte.
>  	 */
> -	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
> +	if (type >= MAX_SWAPFILES) {
>  		spin_unlock(&swap_lock);
>  		goto out;
>  	}

As long as nobody will have the smart idea to increase MAX_SWAPFILES to
more than 32 I'm fine with it.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


