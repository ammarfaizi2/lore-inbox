Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHGBvx>; Tue, 6 Aug 2002 21:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHGBvx>; Tue, 6 Aug 2002 21:51:53 -0400
Received: from holomorphy.com ([66.224.33.161]:64913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316856AbSHGBvv>;
	Tue, 6 Aug 2002 21:51:51 -0400
Date: Tue, 6 Aug 2002 18:55:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807015537.GA4039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org, riel@surriel.com
References: <20020806231522.GJ6256@holomorphy.com> <3D506D43.890EA215@zip.com.au> <20020807010752.GC6343@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020807010752.GC6343@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Andrew Morton wrote:
>> We're piling more and more crap in there to support these pte_chains.
>> How much is too much?
>> Is it likely that large pages and/or shared pagetables would allow us to
>> place pagetables and pte_chains in the direct-mapped region, avoid all
>> this?

On Wed, Aug 07, 2002 at 11:07:52AM +1000, Anton Blanchard wrote:
> On ppc64 shared pagetables will require significant changes to the way
> we handle the hardware hashtable. So add that to the "more and more crap
> in there to support these pte_chains"
> Will shared pagetables be a requirement or can we turn it on per arch?
> Anton

Actually shared pagetables require significant semantic changes in rmap,
e.g. every usage of ptep_to_mm() is broken by shared pagetables and
tracking down assumptions that the (pte, mm) relation is 1:1 is ugly
too. The existing patch for it is not prepared to cope with these.

If they're not already sitting in a back room in ozlabs or Austin
somewhere I'll ship the 3 or 4 singletask 64-bit pagetable OOM's to LTP
etc. to help dispel the 32-bit pagetable space myth, too.


Cheers,
Bill
