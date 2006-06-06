Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWFFQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFFQdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWFFQdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:33:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56714 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750715AbWFFQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:33:17 -0400
Date: Tue, 6 Jun 2006 09:32:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com, apw@shadowen.org,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org> <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Hugh Dickins wrote:

> Christoph's patch looks like it will fix the corruption to me (though
> I'd have thought the alternative below a little cleaner, keeping the
> associated tests together and avoiding a second unlock: whatever).

Yup that looks cleaner.

> Whether it's correct depends on what Martin was trying to achieve
> with his test.  I'm surprised to find a very ordinary
> #define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
> in include/asm-s390/pgtable.h, and no architecture with a more
> limiting mask.

Yes we need to hear from Martin.

> Not really (though the clarity and reassurance of the additional
> MAX_SWAPFILES test is good).  We went over it a year or two back,
> and the macro contortions do involve MAX_SWAPFILES_SHIFT: which
> up to and including 2.6.17 has enforced the MAX_SWAPFILES limit.

It looks though as if the testers were able to define more than 32 swap 
devices. So there is the danger of overwriting the memory 
following the swap info if we do not fix this.

Where are the macro contortions? No arch uses MAX_SWAPFILES_SHIFT for its 
definitions and the only other significant use is in swapops.h to 
determine the shift.

