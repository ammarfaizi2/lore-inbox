Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbULVTya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbULVTya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbULVTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 14:54:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17876 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262028AbULVTyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 14:54:12 -0500
Date: Wed, 22 Dec 2004 11:54:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [1/3]: Introduce
 __GFP_ZERO
In-Reply-To: <20041222105301.GE15894@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0412221152010.9186@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <p73mzw7cm1p.fsf@verdi.suse.de> <Pine.LNX.4.58.0412211452110.2541@schroedinger.engr.sgi.com>
 <20041222105301.GE15894@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Andi Kleen wrote:

> It depends. If you plan to do really big zero_page then it
> may be worth experimenting with cache bypassing clears
> (movntq) or even SSE2 16 byte stores (movntdq %xmm..,..)
> and take out the rep ; stosq optimization. I tried it all
> long ago and it wasn't a win for only 4K.
>
> For normal 4K clear_page that's definitely not a win (tested)
> and especially cache bypassing is a loss.

This may be better realized using a zeroing driver then.

> Yours too at least on non Altix no? Can you demonstrate any benefit?
> Where are the numbers?

In the initial discussion see V1 [0/3].

> I'm sceptical for example that there will be enough higher orders
> to make the batch clearing worthwhile after the system is up for a days.
> Normally memory tends to fragment rather badly in Linux.
> I suspect after some time your approach will just degenerate to be
> the same as Andrea's, even if it should be a win at the beginning (is it?)

I have tried it and the number show clearly that this continues to be a
win although the inital 7-8 fold speed increase degenerates into 3-4 fold
over time (single thread performance).
