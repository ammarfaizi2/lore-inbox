Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUCCVFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUCCVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:05:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50190
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261194AbUCCVFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:05:16 -0500
Date: Wed, 3 Mar 2004 22:05:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303210554.GW4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]> <20040303183901.GU4922@dualathlon.random> <14140000.1078339447@[10.1.1.4]> <20040303185122.GV4922@dualathlon.random> <14830000.1078340481@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14830000.1078340481@[10.1.1.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 01:01:21PM -0600, Dave McCracken wrote:
> The point would be to have a way of finding and skipping the locked page
> before we go look up the vmas for it.  2.4 doesn't have that problem
> because it's working from the vma.

it has the same problem because we scan those pages always at the
physical side and always at the pagetable side. we could avoid scanning
them at the pagetable side, but we scan them anyways exactly to be able
to call mark_page_accessed that will move the page in the active list,
so the physical side doesn't waste an excessive amount of cpu on
unfreeable mlocked pages. 

the trick is to keep marking those mlocked pages as accessed (so they go
into the active list) every time we encounter them and we find them
mlocked, so they're not in our way all the time.
