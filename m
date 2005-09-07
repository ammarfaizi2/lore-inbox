Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVIGSTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVIGSTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVIGSTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:19:37 -0400
Received: from dvhart.com ([64.146.134.43]:1930 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932191AbVIGSTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:19:36 -0400
Date: Wed, 07 Sep 2005 11:19:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       hugh@veritas.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Hugh's alternate page fault scalability approach on 512p Altix
Message-ID: <508740000.1126117173@flay>
In-Reply-To: <Pine.LNX.4.62.0509070838240.21170@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com><20660000.1126103324@[10.10.2.4]> <Pine.LNX.4.62.0509070838240.21170@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Anticipatory prefaulting raises the highest fault rate obtainable three-fold
>> > through gang scheduling faults but may allocate some pages to a task that are
>> > not needed.
>> 
>> IIRC that costed more than it saved, at least for forky workloads like a
>> kernel compile - extra cost in zap_pte_range etc. If things have changed
>> substantially in that path, I guess we could run the numbers again - has
>> been a couple of years.
> 
> Right. The costs come about through wrong anticipations installing useless 
> mappings. The patches that I posted have this feature off by default. Gang 
> scheduling can be enabled by modifying a value in /proc. But I guess the 
> approach is essentially dead unless others want this feature too. The 
> current page fault scalability approach should be fine for a couple of 
> years and who knows what direction mmu technology has taken then.

It would seem to depends on the locality of reference in the affected files.
Which implies to me that the locality of libc, etc probably sucks, though
we had a simple debug patch somewhere to print out a bitmap of which pages
are faulted in and which are not ... was somewhere, I'll see if I can find
it.

M.

